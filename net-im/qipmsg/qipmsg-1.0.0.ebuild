# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit googlecode  qt4-r2

DESCRIPTION="An open-source Qt4 implementation of IP Messenger for linux."

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-qt/qtcore-4.3
	>=dev-qt/qtgui-4.3
"
DEPEND="${RDEPEND}"

export PREFIX=/usr

src_compile(){
	emake QMAKE=qmake LRELEASE=lrelease || die
}
