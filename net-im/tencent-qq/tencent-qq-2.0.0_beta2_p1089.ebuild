# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
MULTILIB_COMPAT=( abi_x86_64 abi_mips_n64 )

inherit desktop multilib-build rpm xdg

MY_PV=$(ver_cut 1-3)-b$(ver_cut 5)-$(ver_cut 7)

DESCRIPTION="Official Linux version of Tencent QQ"
HOMEPAGE="https://im.qq.com/linuxqq/download.html"
LICENSE="Tencent"
RESTRICT="bindist mirror strip"

SRC_URI="
	amd64? ( http://down.qq.com/qqweb/LinuxQQ/linuxqq_${MY_PV}_x86_64.rpm )
	arm64? ( http://down.qq.com/qqweb/LinuxQQ/linuxqq_${MY_PV}_aarch64.rpm )
	mips? ( http://down.qq.com/qqweb/LinuxQQ/linuxqq_${MY_PV}_mips64el.rpm )
"

SLOT="stable"
KEYWORDS="-* ~amd64 ~mips"  # arm64 not tested
IUSE="big-endian"
REQUIRED_USE="
	arm64? ( !big-endian )
	mips? ( !big-endian )
"

QA_PREBUILT="
	opt/tencent-qq/crashpad_handler
	opt/tencent-qq/qq
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

S="${WORKDIR}"

src_prepare() {
	default

	# the original package installed into /usr/local/share/tencent-qq, which is insane
	# rewrite to /opt/tencent-qq
	# also apply several fixes pointed out by QA notice
	# fix some other properties as well, effectively rewriting the file
	sed -i '
		s@/usr/local/bin@/opt/tencent-qq@g;
		s@/usr/local/share/tencent-qq@/opt/tencent-qq@g;
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
	domenu "${S}"/usr/share/applications/qq.desktop
	dodoc "${S}"/usr/local/share/tencent-qq/CHANGELOG.txt

	insinto /opt/tencent-qq
	doins "${S}"/usr/local/share/tencent-qq/{qq.png,res.db}
	exeinto /opt/tencent-qq
	doexe "${S}"/usr/local/bin/{crashpad_handler,qq}

	dosym ../../opt/tencent-qq/qq /usr/bin/qq
}
