# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils cmake-utils versionator

DESCRIPTION="a modern terminal emulator for Linux"
HOMEPAGE="http://fqterm.googlecode.com"
SRC_URI="${HOMEPAGE}/files/${PN}_$(replace_all_version_separators '_')_r770.zip
	${HOMEPAGE}/files/QQWry.Dat.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="x11-libs/qt-core[ssl,qt3support]
	x11-libs/qt-gui
	media-libs/alsa-lib
	dev-libs/openssl"
DEPEND="${RDEPEND}
	app-arch/unzip"

RESTRICT="primaryuri"
S=${WORKDIR}/${PN/term}

src_unpack() {
	unpack ${A}
	# patch partially based upon qterm-0.5.2-as-needed.patch
	epatch "${FILESDIR}"/${P}-as-needed.patch
}

src_install() {
	cmake-utils_src_install
	insinto /usr/share/FQTerm
	doins "${WORKDIR}"/QQWry.Dat  || die
}
