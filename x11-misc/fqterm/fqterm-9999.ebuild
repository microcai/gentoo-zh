# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ESVN_REPO_URI="http://fqterm.googlecode.com/svn/trunk"
ESVN_PATCHES="${P}-as-needed.patch"
inherit cmake-utils subversion

DESCRIPTION="a modern terminal emulator for Linux"
HOMEPAGE="http://fqterm.googlecode.com"
SRC_URI="qqwry? ( ${HOMEPAGE}/files/QQWry.zip )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="qqwry"

RDEPEND="x11-libs/qt-core
	x11-libs/qt-gui
	media-libs/alsa-lib
	dev-libs/openssl"
DEPEND="${RDEPEND}
	qqwry? ( app-arch/unzip )"

S=${WORKDIR}/${PN}

src_unpack() {
	subversion_src_unpack
	unpack ${A}
}

src_install() {
	cmake-utils_src_install
	if use qqwry ; then
		insinto /usr/share/FQTerm
		doins "${S}"/QQWry.Dat  || die
	fi
}
