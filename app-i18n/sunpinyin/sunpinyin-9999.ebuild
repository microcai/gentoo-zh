# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 scons-utils

DESCRIPTION="A statistical language model based Chinese input method library"
HOMEPAGE="https://code.google.com/p/sunpinyin/"
EGIT_PROJECT="${PN}"
EGIT_REPO_URI="https://github.com/sunpinyin/sunpinyin.git"

LICENSE="CDDL LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""
RESTRICT="mirror"

RDEPEND="dev-db/sqlite:3"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext"
PDEPEND="app-i18n/sunpinyin-data"

src_configure() {
	myesconsargs=( --prefix=/usr )
}

src_compile() {
	escons
}

src_install() {
	escons --install-sandbox="${D}" install

	rm -rf "${D}"/usr/share/doc/${PN} || die
	dodoc doc/{README,SLM-inst.mk,SLM-train.mk}
}
