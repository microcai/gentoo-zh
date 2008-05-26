# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kde

DESCRIPTION="This is small wrapper for netstat for KDE"
HOMEPAGE="http://ksquirrel.sourceforge.net/subprojects.php"
SRC_URI="mirror://sourceforge/ksquirrel/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

need-kde 3.3
