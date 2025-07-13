# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg

MY_PV=${PV/_p/_}
_I="Linux"
_ArchExt="_01"
_QQDownSite="https://dldir1.qq.com/qqfile/qq/QQNT"
_QQFileName="QQ"
_QQFileSuffix=".deb"

_LiteLoader_PV="1.2.3"
DESCRIPTION="The new version of the official linux-qq"
HOMEPAGE="https://im.qq.com/linuxqq/index.shtml"

SRC_URI="
	amd64? ( ${_QQDownSite}/$_I/${_QQFileName}_${MY_PV}_amd64${_ArchExt}${_QQFileSuffix} )
	arm64? ( ${_QQDownSite}/$_I/${_QQFileName}_${MY_PV}_arm64${_ArchExt}${_QQFileSuffix} )
	loong? ( ${_QQDownSite}/$_I/${_QQFileName}_${MY_PV}_loongarch64${_ArchExt}${_QQFileSuffix} )
	liteloader? (
		https://github.com/LiteLoaderQQNT/LiteLoaderQQNT/releases/download/${_LiteLoader_PV}/LiteLoaderQQNT.zip \
		-> LiteLoaderQQNT-${_LiteLoader_PV}.zip
	)
"
S=${WORKDIR}
LICENSE="Tencent"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

IUSE="bwrap system-vips gnome liteloader"

RESTRICT="strip mirror"

RDEPEND="
	x11-libs/gtk+:3
	x11-libs/libnotify
	dev-libs/nss
	x11-libs/libXScrnSaver
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXtst
	x11-misc/xdg-utils
	app-accessibility/at-spi2-core:2
	app-crypt/libsecret
	virtual/krb5
	sys-apps/keyutils
	system-vips? (
		dev-libs/glib
		>=media-libs/vips-8.15.2[-pdf]
	)
	bwrap? (
		sys-apps/bubblewrap
		x11-misc/snapd-xdg-open
		x11-misc/flatpak-xdg-utils
	)
	gnome? ( dev-libs/gjs )
	media-libs/openslide
	loong? (
			virtual/loong-ow-compat
	)
"
BDEPEND="liteloader? ( app-arch/unzip )"

src_unpack() {
	:
	if use liteloader; then
		unpack LiteLoaderQQNT-${_LiteLoader_PV}.zip
	fi
}

src_install() {
	dodir /
	cd "${D}" || die
	if [ "${ARCH}" = "loong" ]; then
		unpacker "${DISTDIR}/${_QQFileName}_${MY_PV}_loongarch64${_ArchExt}${_QQFileSuffix}"
	else
		unpacker "${DISTDIR}/${_QQFileName}_${MY_PV}_${ARCH}${_ArchExt}${_QQFileSuffix}"
	fi

	# Fix KDK Wayland QQ icons
	mv "${D}/usr/share/applications/qq.desktop" "${D}/usr/share/applications/QQ.desktop" || die

	if use system-vips; then
		rm -r "${D}"/opt/QQ/resources/app/sharp-lib || die
	fi

	if use bwrap; then
		exeinto /opt/QQ
		patch "${FILESDIR}"/start.sh -o "${WORKDIR}"/start_sh_patched < "${FILESDIR}"/start_sh.patch || die
		newexe "${WORKDIR}"/start_sh_patched start.sh
		sed -i 's!/opt/QQ/qq!/opt/QQ/start.sh!' "${D}"/usr/share/applications/QQ.desktop || die
		insinto /opt/QQ/workarounds
		doins "${FILESDIR}"/{config.json,xdg-open.sh,vercmp.sh}
		fperms +x /opt/QQ/workarounds/{xdg-open.sh,vercmp.sh}

		local _base_pkgver=${PV/_p/-} || die
		local _update_pkgver=${_base_pkgver} || die
		local cur_ver=${_update_pkgver:-${base_ver}} || die
		local build_ver=${cur_ver#*-} || die

		sed -i "s|__BASE_VER__|${base_ver}|g;s|__CURRENT_VER__|${cur_ver}|g;s|__BUILD_VER__|${build_ver}|g" \
			"${D}"/opt/QQ/workarounds/config.json \
			"${D}"/opt/QQ/start.sh || die

	else
		sed -i 's!/opt/QQ/qq!/usr/bin/qq!' "${D}"/usr/share/applications/QQ.desktop || die
	fi

	if use bwrap; then
		dosym -r /opt/QQ/start.sh /usr/bin/qq
	else
		newbin "$FILESDIR/qq.sh" qq
	fi

	sed -i 's!/usr/share/icons/hicolor/512x512/apps/qq.png!qq!' "${D}"/usr/share/applications/QQ.desktop || die
	gzip -d "${D}"/usr/share/doc/linuxqq/changelog.gz || die
	dodoc "${D}"/usr/share/doc/linuxqq/changelog
	rm -rf "${D}"/usr/share/doc/linuxqq/ || die

	if use liteloader; then
		insinto /opt/LiteLoader
		doins -r "${WORKDIR}"/*
		dosym -r /opt/LiteLoader/src/preload.js /opt/QQ/resources/app/application/preload.js
		sed -i "1 i require(\"/opt/LiteLoader\");" "${D}"/opt/QQ/resources/app/app_launcher/index.js || die
	fi
}

pkg_postinst() {
	xdg_pkg_postinst
	if use bwrap; then
		elog "-EN-----------------------------------------------------------------"
		elog "If you want to download files in QQ"
		elog "Please set the QQ download path to ~/Download"
		elog "If you have enabled LiteLoaderQQNT support, relevant plugins can be "
		elog "downloaded from https://liteloaderqqnt.github.io/, "
		elog "For instance, after downloading the 「轻量工具箱」 and unzipping it, "
		elog "download it to the directory ~/.config/QQ/LiteLoaderQQNT/plugins/lite_tools_v4/, "
		elog "and the changes will take effect after a restart."
		elog "--------------------------------------------------------------------"
		elog "-ZH-----------------------------------------------------------------"
		elog "如果要在 QQ 中下载文件，请先在「设置」->「存储管理」中把下载文件夹"
		elog "更改为系统的“下载”/“Downloads”文件夹。"
		elog "如果您启用了 LiteLoaderQQNT 支持，"
		elog "可以从 https://liteloaderqqnt.github.io/ 下载相关插件，"
		elog "例如：「轻量工具箱」下载后"
		elog "解压到 ~/.config/QQ/LiteLoaderQQNT/plugins/“lite_tools_v4”/ 目录下，重启后生效。"
		elog "--------------------------------------------------------------------"
	fi
}
