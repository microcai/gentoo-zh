# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/coffee-script-source/coffee-script-source-1.4.0.ebuild,v 1.2 2013/01/15 06:29:09 zerochaos Exp $

EAPI="5"

DESCRIPTION="the official CoffeeScript compiler"
HOMEPAGE="http://coffeescript.org/"
SRC_URI="http://github.com/jashkenas/${PN}/archive/${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-libs/nodejs"
DEPEND="${RDEPEND}"

src_compile() {
	node bin/cake build
}

src_test() {
	node bin/cake test
}

src_install() {
	node bin/cake --prefix "${D}"/usr install
}
