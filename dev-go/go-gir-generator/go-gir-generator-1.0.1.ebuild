# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4


DESCRIPTION="Generate static golang bindings for GObject"
HOMEPAGE="https://github.com/linuxdeepin/go-gir-generator"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""


DEPEND="sys-devel/gcc[go]
	dev-libs/gobject-introspection
	dev-libs/libgudev
	dev-lang/go"

#src_prepare() {
#	 export GOPATH="${S}:/usr/share/gocode"
#}

#src_compile() {
#	emake USE_GCCGO=1
#}
