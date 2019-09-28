# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="DOM/JavaScript-based terminal-emulator/console https://domterm.org"
HOMEPAGE="https://github.com/PerBothner/DomTerm"
SRC_URI="https://github.com/PerBothner/DomTerm/releases/download/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-ruby/asciidoctor
	>=net-libs/libwebsockets-2.2.0"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	econf --prefix=/usr
}

src_install() {
	emake DESTDIR="${D}" install
}
