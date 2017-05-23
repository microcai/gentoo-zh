# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools git-2

DESCRIPTION="An SCIM port of android Google Pinyin IME"
HOMEPAGE="http://code.google.com/p/scim-googlepinyin/"
EGIT_REPO_URI="https://github.com/tchaikov/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	|| ( >=app-i18n/scim-1.1 >=app-i18n/scim-cvs-1.1 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext"

src_prepare() {
	# autogen.sh does more than just run autotools
	sed -i \
		-e 's:^libtoolize:_elibtoolize:' \
		-e 's:^acl:eacl:' \
		-e 's:^auto:eauto:' \
		-e 's:^\.\/configure:#\.\/configure:' \
		 autogen.sh || die "sed failed"
	(. ./autogen.sh) || die "autogen.sh failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc README* ChangeLog AUTHORS NEWS TODO || die "dodoc failed"
}
