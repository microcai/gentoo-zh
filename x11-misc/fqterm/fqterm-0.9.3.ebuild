# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils cmake-utils

DESCRIPTION="FQTerm, a modern terminal emulator"
HOMEPAGE="http://fqterm.googlecode.com"
SRC_URI="http://fqterm.googlecode.com/files/${P}-src-r569.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="x11-libs/qt-core
	x11-libs/qt-qt3support
	x11-libs/qt-gui
	x11-libs/qt-script
	dev-libs/openssl"
DEPEND="${RDEPEND}
	app-arch/unzip
	>=dev-util/cmake-2.4.2"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Quick-and-dirty fix (based on qterm-0.5.2-as-needed.patch)
	epatch "${FILESDIR}"/${P}-qad-openssl-fix.patch
}
