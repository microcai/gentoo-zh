# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

_PN="coffeescript"
_P="${_PN}-${PV}"

DESCRIPTION="The official CoffeeScript compiler"
HOMEPAGE="http://coffeescript.org"
SRC_URI="http://github.com/jashkenas/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-libs/nodejs"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack "${A}"
	mv "${_P}" "${P}"
}

src_compile() {
	node bin/cake build
}

src_test() {
	node bin/cake test
}

src_install() {
	node bin/cake --prefix "${D}"/usr install
}
