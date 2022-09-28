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
	x11-libs/gtk+:3[wayland]
	virtual/glu
	dev-util/desktop-file-utils
	x11-libs/libXtst
	virtual/jdk
	${DEPEND}"
BDEPEND=""

S="${WORKDIR}/VESTA-gtk3"

QA_PREBUILT="*"

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

	elog "There is a bug in version 3.5.6 and 3.5.7, which may cause deleted atoms appear again."
	elog "See: https://groups.google.com/g/vesta-discuss/c/y7TCMRe1HlA"
	elog "If this bug affects your use, consider switching to other versions."

	elog "If you meet any abnormal behavior while using VESTA after upgrade or downgrade,"
	elog "try remove ~/.VESTA and restart VESTA. Note that this will make you lost"
	elog "all your saved configs."
}

pkg_postrm() {
	xdg_desktop_database_update
}
