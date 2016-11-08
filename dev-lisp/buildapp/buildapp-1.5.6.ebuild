# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit common-lisp-2

DESCRIPTION="Create executables with SBCL"
HOMEPAGE="http://www.xach.com/lisp/buildapp/"
SRC_URI="https://codeload.github.com/xach/buildapp/tar.gz/release-${PV} -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
		dev-lisp/sbcl"

S="${WORKDIR}/${PN}-release-${PV}"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	common-lisp-install *.lisp ${PN}.asd
	common-lisp-symlink-asdf
	dobin buildapp
	dodoc README
	dohtml doc/{LICENSE,index.html,style.css}
}
