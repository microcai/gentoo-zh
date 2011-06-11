# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

LM_DATA="lm_sc.t3g.arpa.tar.bz2"
LM_DICT="dict.utf8.tar.bz2"
BASE_URI="http://sunpinyin.googlecode.com/files"

EGIT_PROJECT="sunpinyin"
EGIT_REPO_URI="git://github.com/sunpinyin/sunpinyin.git"
inherit git scons-utils multilib

DESCRIPTION="A statistical language model based Chinese input method library"
HOMEPAGE="http://www.sunpinyin.org"
SRC_URI="${BASE_URI}/${LM_DATA} ${BASE_URI}/${LM_DICT}"

LICENSE="CDDL LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-db/sqlite:3"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

src_prepare() {
	cp -v "${DISTDIR}"/{${LM_DATA},${LM_DICT}} raw || die
}

src_compile() {
	escons --prefix=/usr --libdir=/usr/$(get_libdir) --libdatadir=/usr/share
}

src_install() {
	escons install --install-sandbox="${D}"
}
