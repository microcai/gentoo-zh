# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="Ly - a TUI display manager"
HOMEPAGE="https://github.com/nullgemm/ly"

CLAP="8c98e6404b22aafc0184e999d8f068b81cc22fa1"
ZIGINI="ce1f322482099db058f5d9fdd05fbfa255d79723"
ZIGLIBINI="da0af3a32e3403e3113e103767065cbe9584f505"

SRC_URI="
	https://github.com/nullgemm/ly/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Hejsil/zig-clap/archive/${CLAP}.tar.gz -> zig-clap.tar.gz
	https://github.com/Kawaii-Ash/zigini/archive/${ZIGINI}.tar.gz -> zigini.tar.gz
	https://github.com/ziglibs/ini/archive/${ZIGLIBINI}.tar.gz -> ziglibini.tar.gz
"
LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64"

EZIG_MIN="0.12"
DEPEND="
	|| ( dev-lang/zig-bin:${EZIG_MIN} dev-lang/zig:${EZIG_MIN} )
	sys-libs/pam
	x11-libs/libxcb
"

RDEPEND="
	x11-base/xorg-server
	x11-apps/xauth
	sys-libs/ncurses
"

RES="${S}/res"

PATCHES=(
	"${FILESDIR}/${PN}-build-zig-zon.patch"
	"${FILESDIR}/${PN}-zigini-build-zig-zon.patch"
)

src_unpack() {
	default

	# create a subdir for deps
	mkdir "${S}/deps" || die

	# move all deps to the subdir
	mv "zig-clap-${CLAP}" "${S}/deps/zig-clap" || die
	mv "zigini-${ZIGINI}" "${S}/deps/zigini" || die
	mv "ini-${ZIGLIBINI}" "${S}/deps/zigini/ini" || die
}

src_compile() {
	zig build || die "Zig build failed"
}

src_install(){
	dobin "${S}/zig-out/bin/${PN}"
	newinitd "${RES}/${PN}-openrc" ly
	systemd_dounit "${RES}/${PN}.service"
}

pkg_postinst() {
	systemd_reenable "${PN}.service"

	ewarn
	ewarn "The init scripts are installed only for systemd/openrc"
	ewarn "If you are using something else like runit etc."
	ewarn "Please check upstream for get some help"
	ewarn "You may need to take a look at /etc/ly/config.ini"
	ewarn "If you are using a window manager as DWM"
	ewarn "Please make sure there is a .desktop file in /usr/share/xsessions for it"
}
