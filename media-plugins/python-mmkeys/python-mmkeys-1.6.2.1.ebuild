# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_DEPEND=2:2.4

inherit python flag-o-matic
DESCRIPTION="Multimedia key support as a PyGTK object"
HOMEPAGE="http://sonata.berlios.de"
SRC_URI="http://codingteam.net/project/sonata/download/file/sonata-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pygtk
		!media-sound/sonata"
RDEPEND="${DEPEND}"

S=${WORKDIR}/sonata-${PV}/mmkeys

pkg_setup() {
	python_set_active_version 2.7
	python_pkg_setup
}

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


