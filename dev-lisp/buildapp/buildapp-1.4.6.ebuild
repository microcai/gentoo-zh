# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit common-lisp-2

DESCRIPTION="Create executables with SBCL"
HOMEPAGE="http://www.xach.com/lisp/buildapp/"
SRC_URI="http://www.xach.com/lisp/${PN}.tgz -> ${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
		dev-lisp/sbcl"

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
