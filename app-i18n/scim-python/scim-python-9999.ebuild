# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools eutils subversion

DESCRIPTION="A python wrapper for Smart Common Input Method (SCIM)"
HOMEPAGE="http://code.google.com/p/scim-python/"
#SRC_URI="http://scim-python.googlecode.com/files/${P}.tar.bz2"
#RESTRICT="mirror"
ESVN_REPO_URI="http://scim-python.googlecode.com/svn/trunk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls pinyin enwriter"

RDEPEND="x11-libs/libXt
	>=dev-lang/python-2.5
	enwriter? ( dev-python/pyenchant )
	|| ( >=app-i18n/scim-1.1 >=app-i18n/scim-cvs-1.1 )
	nls? ( virtual/libintl )
	"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

pkg_setup() {
	if ! built_with_use '>=dev-lang/python-2.5*' sqlite; then
		echo
		ewarn "You need build dev-lang/python-2.5 with \"sqlite\" USE flag"
		echo
		ebeep 3
	fi
}


src_unpack() {
	subversion_src_unpack
	cd "${S}"
	autopoint
	AT_NO_RECURSIVE=yes AT_M4DIR=${S}/m4
	eautoreconf
}

src_compile() {
	econf \
		$(use_enable pinyin) \
		$(use_enable nls) \
		$(use_enable enwriter english-writer) \
		--disable-static \
		--disable-dependency-tracking \
		|| die "econf failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc README ChangeLog AUTHORS NEWS TODO
}
