# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
MULTILIB_COMPAT=( abi_x86_64 abi_mips_n64 )

inherit desktop multilib-build rpm xdg-utils

DESCRIPTION="Official Linux version of Tencent QQ"
HOMEPAGE="https://im.qq.com/linuxqq/download.html"
LICENSE="Tencent"
RESTRICT="bindist mirror"

SRC_URI="
	amd64? ( https://qd.myapp.com/myapp/qqteam/linuxQQ/linuxqq_2.0.0-b1-1024_x86_64.rpm )
	arm64? ( https://qd.myapp.com/myapp/qqteam/linuxQQ/linuxqq_2.0.0-b1-1024_aarch64.rpm )
	mips? ( https://qd.myapp.com/myapp/qqteam/linuxQQ/linuxqq_2.0.0-b1-1024_mips64el.rpm )
"

SLOT="0"
KEYWORDS="-* ~amd64 ~mips"  # arm64 not tested
IUSE="big-endian"
REQUIRED_USE="
	arm64? ( !big-endian )
	mips? ( !big-endian )
"

# the sonames are gathered with the following trick:
#
# readelf -a qq | rg '\(NEEDED\)' | rg -o '\[.*\]' | sed 's/^\[//; s/\]$//;'
#
# then combine this with something even more devilish to get the package names:
#
# ldd qq | \
#     rg "$(cat previous-result | tr '\n' '|' | sed 's/^/(?:/; s/|$/)/; s/\./\\./g;')" | \
#     rg -o '=> (.*) \(' | \
#     sed 's/^=> //; s/($//;' | \
#     xargs equery b | \
#     sort | \
#     uniq
#
# NOTE: sys-devel/gcc and sys-libs/glibc are omitted, not sure if this is right
RDEPEND="
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/nspr:0[${MULTILIB_USEDEP}]
	dev-libs/nss:0[${MULTILIB_USEDEP}]
	x11-libs/cairo:0[${MULTILIB_USEDEP}]
	x11-libs/gdk-pixbuf:2[${MULTILIB_USEDEP}]
	x11-libs/gtk+:2[${MULTILIB_USEDEP}]
	x11-libs/libX11:0[${MULTILIB_USEDEP}]
	x11-libs/pango:0[${MULTILIB_USEDEP}]
"
DEPEND=""
BDEPEND=""

QA_PREBUILT="opt/tencent-qq/crashpad_handler
opt/tencent-qq/qq"

S="${WORKDIR}"

src_unpack() {
	rpm_src_unpack
}

src_prepare() {
	default

	# the original package installed into /usr/share/tencent-qq, which is insane
	# rewrite to /opt/tencent-qq
	# also apply several fixes pointed out by QA notice
	# fix some other properties as well, effectively rewriting the file
	sed -i '
		s@/usr/share/tencent-qq@/opt/tencent-qq@g;
		/^Version=/d;
		s/Application;//g;
		s/;Tencent Software//g;
		s/^Name=腾讯QQ$/Name=Tencent QQ/;
		s/^Comment=腾讯QQ$/Comment=Tencent QQ/;
		s/^GenericName\[zh_CN\]=$/GenericName[zh_CN]=腾讯QQ/;
		' \
		usr/share/applications/qq.desktop || die "sed failed for qq.desktop"

	echo 'GenericName=Tencent QQ' >> usr/share/applications/qq.desktop
}

src_install() {
	# this is not needed, the desktop entry file refers to the install root
	# doicon usr/share/tencent-qq/qq.png
	domenu usr/share/applications/qq.desktop

	insinto /opt
	doins -r usr/share/tencent-qq
	fperms 0755 /opt/tencent-qq/{crashpad_handler,qq}
	dosym ../../opt/tencent-qq/qq usr/bin/qq
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
