# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs

DESCRIPTION="a modular audio visualizer"
HOMEPAGE="https://github.com/Kharacternyk/barva"
EGIT_REPO_URI="https://github.com/Kharacternyk/barva.git"
EGIT_BRANCH="legacy"

LICENSE="GPL-3"
SLOT="0"
DEPEND="media-libs/libpulse"
src_compile() {
	emake CC="$(tc-getCC)" -C src
}

src_install() {
	dobin "${S}/src/${PN}"
	dodoc "${S}/README.rst"

	into /usr/share/${PN}
	dobin "${S}/scripts/pa-get-default-monitor.sh"
	dobin "${S}/scripts/bspwm-borders.sh"
	dobin "${S}/scripts/to-all-ttys.sh"
}

pkg_postinst() {
	elog "The usage documentation should be installed in /usr/share/doc/barva-9999"
	elog "scripts are stored in /usr/share/barva"

	ewarn "Please note that, the bundled script pa-get-default-monitor.sh,"
	ewarn "is currently broken."
	ewarn "please manually specify BARVA_SOURCE instead."
}
