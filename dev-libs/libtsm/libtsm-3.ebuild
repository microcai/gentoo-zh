# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

DESCRIPTION="TSM is a state machine for DEC VT100-VT520 compatible terminal emulators. "
HOMEPAGE="http://www.freedesktop.org/wiki/Software/libtsm/"
SRC_URI="http://freedesktop.org/software/kmscon/releases/${P}.tar.xz"

LICENSE=""
SLOT="0"
KEYWORDS="x86 arm amd64"
IUSE="static-libs"

DEPEND="x11-libs/libxkbcommon
  !<sys-apps/kmscon-8"
RDEPEND="${DEPEND}"

src_configure(){

	econf $(use_enable static-libs static)
}
