# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

PYTHON_COMPAT=( python2_7 )
inherit flag-o-matic python-single-r1
DESCRIPTION="Multimedia key support as a PyGTK object"
HOMEPAGE="http://sonata.berlios.de"
SRC_URI="http://codingteam.net/project/sonata/download/file/sonata-${PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pygtk
		!media-sound/sonata"
RDEPEND="${DEPEND}"

S=${WORKDIR}/sonata-${PV}/mmkeys

src_compile() {
	# mmkeys have import error--"undefined symbol: gdk_display" with "--as-needed" LDFLAGS
	append-ldflags -Wl,--no-as-needed
	emake PYTHON_DIR=$(python_get_includedir) mmkeys.so
}

src_install() {
	dodoc README
	
	insinto "$(python_get_sitedir)"
	doins mmkeys.so
	#fperms 0755 $(python_get_sitedir)/mmkeys.so
}


