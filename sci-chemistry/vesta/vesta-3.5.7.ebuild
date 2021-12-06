# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg

DESCRIPTION="Visualization for Electronic and STructural Analysis"
HOMEPAGE="https://jp-minerals.org/vesta"
SRC_URI="https://jp-minerals.org/vesta/archives/${PV}/VESTA-gtk3.tar.bz2 -> ${PN}-${PV}.tar.bz2"

LICENSE="VESTA"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="mirror strip"

DEPEND=""
RDEPEND="
	x11-libs/gtk+
	virtual/glu
	dev-util/desktop-file-utils
	x11-libs/libXtst
	virtual/jdk
	${DEPEND}"
BDEPEND=""

S="${WORKDIR}/VESTA-gtk3"

QA_PREBUILD="*"

src_install() {
	insinto /opt/VESTA
	doins -r *
	fperms +x /opt/VESTA/VESTA
	fperms +x /opt/VESTA/VESTA-gui

	domenu "${FILESDIR}/VESTA.desktop"

	dosym ../VESTA/VESTA /opt/bin/VESTA
	dosym ../VESTA/VESTA /opt/bin/vesta
}

pkg_postinst() {
	xdg_desktop_database_update

	elog "Since version 3.5.6, a behavior change has been made, which may cause deleted atoms appear again."
	elog "See: https://groups.google.com/g/vesta-discuss/c/y7TCMRe1HlA"
	elog "To restore the previous behavior, please install version 3.5.5 or earlier."

	elog "If you meet any abnormal behavior while using VESTA after upgrade or downgrade,"
	elog "please remove ~/.VESTA and restart VESTA."
}

pkg_postrm() {
	xdg_desktop_database_update
}
