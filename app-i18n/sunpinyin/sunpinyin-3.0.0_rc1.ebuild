# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python2_7 )
inherit eutils multilib python-any-r1 scons-utils toolchain-funcs

DESCRIPTION="A statistical language model based Chinese input method library"
HOMEPAGE="https://github.com/sunpinyin/sunpinyin"
_PV=${PV//_/-}
SRC_URI="https://github.com/sunpinyin/sunpinyin/archive/v${_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1 CDDL"
SLOT="0/1"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="dev-db/sqlite:3"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"
PDEPEND="app-i18n/sunpinyin-data"
S="${WORKDIR}/${PN}-${_PV}"

src_prepare() {
	epatch_user
}

src_configure() {
	tc-export CXX
	myesconsargs=(
		--prefix="${EPREFIX}"/usr
		--libdir="${EPREFIX}"/usr/$(get_libdir)
	)
}

src_compile() {
	escons
}

src_install() {
	escons --install-sandbox="${D}" install
	rm -rf "${D}"/usr/share/doc/${PN} || die
	dodoc doc/{README,SLM-inst.mk,SLM-train.mk}
}
