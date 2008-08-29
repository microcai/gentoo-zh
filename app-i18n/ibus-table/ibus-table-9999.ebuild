# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
inherit eutils

if [[ ${PV} == 9999 ]] ; then
	EGIT_REPO_URI="git://github.com/acevery/ibus-table.git"
	inherit autotools git
else
	SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"
fi

DESCRIPTION="The Table Engine for IBus Input Framework"
HOMEPAGE="http://ibus.googlecode.com"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="" #~x86 ~amd64
IUSE="nls zhengma wubi86 wubi98 cangjie5 erbi-qs +additional +extra-phrases"

# To run autopoint you need cvs.
RDEPEND="app-i18n/ibus
	>=dev-lang/python-2.5
	"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/cvs
	"

pkg_setup() {
	if ! built_with_use '>=dev-lang/python-2.5' sqlite; then
		echo
		ewarn "You need build dev-lang/python-2.5 with \"sqlite\" USE flag"
		echo
		ebeep 3
		die
	fi
}
src_unpack() {
	git_src_unpack
	autopoint && eautoreconf
}

src_compile() {
	econf $(use_enable nls) \
		$(use_enable zhengma) \
		$(use_enable wubi86) \
		$(use_enable wubi98) \
		$(use_enable cangjie5) \
		$(use_enable erbi-qs) \
		$(use_enable extra-phrases) \
		$(use_enable additional) \
		--disable-option-checking \
		--disable-rpath
		emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
	#dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	ewarn "This package is very experimental, please report your bug here:"
	ewarn "http://ibus.googlecode.com/issues/list"
	elog
	elog "Please run ibus-setup and choose pinyin as the"
	elog "default input engine"
	elog
}
