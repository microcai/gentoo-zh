# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="2"
inherit cmake-utils eutils

DESCRIPTION="BBS client for X Window System written in Qt"
HOMEPAGE="http://qterm.sourceforge.net/"
SRC_URI="mirror://sourceforge/qterm/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus kde phonon test"

RDEPEND="x11-libs/qt-core:4[ssl]
	x11-libs/qt-gui:4
	dbus? ( x11-libs/qt-dbus:4 )
	test? ( x11-libs/qt-test:4 )
	phonon? (
		kde? ( kde-base/phonon-kde )
		!kde? ( x11-libs/qt-phonon:4 )
	)
	dev-libs/openssl"
DEPEND="${RDEPEND}"

RESTRICT="test"
DOCS="README TODO"

src_prepare() {
	# bug #176533
	sed -i -e '/^Exec/s/qterm/QTerm/' src/qterm.desktop.in || die
	# make sure 'cmake-utils_use_enable' works as expected
	sed -i -e 's:QTERM_ENABLE:ENABLE:g' src/CMakeLists.txt || die

	epatch ${FILESDIR}/${P}-debian-gcc-4.4.patch
}

src_configure() {
	#$(cmake-utils_use_enable ssl SSH )
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_enable dbus DBUS )
		$(cmake-utils_use_enable phonon PHONON )
		$(cmake-utils_use_enable test TEST )"
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	mv "${D}"/usr/bin/{qterm,QTerm} || die
}

pkg_postinst() {
	einfo
	elog "Since 0.4.0-r1, /usr/bin/qterm has been renamed to /usr/bin/QTerm."
	elog "Please see bug #176533 for more information."
	einfo
}
