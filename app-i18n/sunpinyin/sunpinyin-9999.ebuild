# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git scons-utils multilib

LM_DICT="dict.utf8.tar.bz2"
LM_DATA="lm_sc.t3g.arpa.tar.bz2"

DESCRIPTION="A statistical language model based Chinese input method library"
HOMEPAGE="http://code.google.com/p/sunpinyin/"
SRC_URI="http://open-gram.googlecode.com/files/${LM_DICT}
	http://open-gram.googlecode.com/files/${LM_DATA}"
EGIT_PROJECT="sunpinyin"
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

src_prepare() {
	cp -v "${DISTDIR}"/{${LM_DICT},${LM_DATA}} "${S}/raw" || die
}

src_compile() {
	escons --prefix=/usr
}

src_install() {
	escons install --prefix=/usr --install-sandbox="${D}"
}
