# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# 要求：1) 解压用 unpacker；2) 账户用 user；3) systemd 单元从 files/ 安装
inherit unpacker user systemd

DESCRIPTION="Nix package manager (binary) — ebuild 内联移植上游 install 逻辑"
HOMEPAGE="https://nixos.org/"
# 这里填写你上传到 DISTFILES 的安装器压缩包（里面包含 upstream 的二进制 tarball）
SRC_URI="https://your.mirror.example/nix-2.32.2-installer.tar.xz -> nix-2.32.2-installer.tar.xz"

LICENSE="LGPL-2.1 MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# Nix 运行期的最小依赖（按需增减）
RDEPEND="
  app-arch/xz-utils
  net-misc/curl
  sys-apps/coreutils
  sys-apps/findutils
  sys-apps/sed
"
DEPEND="${RDEPEND}"

# 不把上游闭包铺到 ${ED}，避免 QA；只安装我们控制的文件
RESTRICT="strip mirror"

# 根据你的安装器内部 tarball 名称调整
NIX_VER="2.32.2"
NIX_TARBALL="nix-${NIX_VER}-x86_64-linux.tar.xz"

# 解包位置（unpacker 会把 SRC_URI 解开到 ${WORKDIR}）
S="${WORKDIR}/nix-installer"

pkg_setup() {
    # ====== 等价于 install 里的 groupadd/useradd ======
    enewgroup nixbld
    # 上游常见是 32 个构建用户；这里给 16 个示例，按需调整数量
    for i in $(seq 1 16); do
        enewuser "nixbld${i}" -1 -1 /var/empty "nixbld"
    done
}


src_install() {
    # ====== 仅安装我们控制的文件，避免 QA ======

    # 1) 把上游二进制 tarball 作为“引导资源”放到 /usr/libexec（不会被 Portage 扫描为系统库）
    insinto /usr/libexec/nix-bootstrap/${NIX_VER}
    doins "${S}/${NIX_TARBALL}"

    # 2) profile.d：用固定脚本指向 daemon profile（等价于 install 修改 shell 配置）
    insinto /etc/profile.d
    newins - nix-nix.sh <<'EOF'
# Nix profile (added by app-admin/nix-bin)
if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi
EOF

    # 3) systemd 单元：从 files/ 目录安装（不自动生成）
    #    请在同目录放置 files/nix-daemon.service
    systemd_dounit "${FILESDIR}/nix-daemon.service"
}

pkg_postinst() {
    # ====== 这里把 install 脚本的“落地动作”逐条翻译执行 ======

    # 1) 准备 /nix 目录
    if [[ ! -d /nix ]]; then
        install -d -m 0755 -o root -g root /nix || die "create /nix failed"
    fi

    # 2) 解包 tarball 到临时目录，只同步 /nix 内容到真实系统（避免把闭包放进 ${ED} 触发 QA）
    local bootroot="/usr/libexec/nix-bootstrap/${NIX_VER}"
    local tb="${bootroot}/${NIX_TARBALL}"
    local workdir
    workdir="$(mktemp -d -t nix-unpack-XXXXXXXX)" || die
    # shellcheck disable=SC2064
    trap "rm -rf '${workdir}'" EXIT

    pushd "${workdir}" >/dev/null || die
    # 上游 tarball 一般是 xz；如有变体按需改 tar 参数
    tar -xJf "${tb}" || die "extract ${tb} failed"

    # 查找解出的根目录（通常只有一个）
    local top
    top="$(find . -mindepth 1 -maxdepth 1 -type d | head -n1)"
    [[ -n "${top}" ]] || die "unexpected tar layout"

    # 只同步其中的 /nix（保留权限/硬链接）到真实 /nix
    if command -v rsync >/dev/null 2>&1; then
        rsync -aH --ignore-existing --numeric-ids "${top}/nix/" /nix/ || die "rsync nix/ failed"
    else
        ( cd "${top}/nix" && find . -xdev -print0 | cpio --null -pdmav /nix ) || die "cpio nix/ failed"
    fi
    popd >/dev/null || die

    # 3) 初始化 store（等价于 install 里的 nix-store --init）
    #    将落地后的 nix 放入 PATH，仅本阶段使用
    local nix_bin
    nix_bin="$(echo /nix/store/*-nix-*/bin 2>/dev/null | awk '{print $1}')" || true
    if [[ -d "${nix_bin}" ]]; then
        PATH="${nix_bin}:${PATH}"
        export PATH
    fi
    if command -v nix-store >/dev/null 2>&1; then
        nix-store --init || ewarn "nix-store --init returned non-zero"
    else
        ewarn "nix-store not found in /nix/store/*-nix-*/bin — tarball may be incomplete?"
    fi

    # 4) 写入基础 /etc/nix/nix.conf（若不存在）
    if [[ ! -s /etc/nix/nix.conf ]]; then
        mkdir -p /etc/nix || die
        cat > /etc/nix/nix.conf <<'EOC' || die
# Basic nix.conf installed by app-admin/nix-bin
sandbox = false
build-users-group = nixbld
experimental-features = nix-command flakes
EOC
    fi

    # 5) 不在 ebuild 中启用服务（遵循 Gentoo 惯例）；给出提示
    ewarn "Nix installed. Start the daemon via: systemctl start nix-daemon"
    ewarn "Enable on boot: systemctl enable nix-daemon"
    einfo  "Shell integration via /etc/profile.d/nix-nix.sh"
}

pkg_postrm() {
    ewarn "Note: /nix is preserved. Remove it manually if you want a full cleanup."
}
