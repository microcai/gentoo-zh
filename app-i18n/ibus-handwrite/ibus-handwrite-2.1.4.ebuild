# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils autotools googlecode

DESCRIPTION="hand write recognition/input using ibus IM engine"
EGIT_REPO_URI="https://github.com/microcai/${PN}.git"

SRC_URI="$SRC_URI
	zinnia? ( mirror://sourceforge/zinnia/zinnia-tomoe/0.6.0-20080911/zinnia-tomoe-0.6.0-20080911.tar.bz2 )"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+zinnia +nls +opengl"

RDEPEND="
	>=app-i18n/ibus-1.2
	nls? ( virtual/libintl )
	zinnia? ( app-i18n/zinnia )
	opengl? ( >=x11-libs/gtkglext-1.0 )
	"


DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( >=sys-devel/gettext-0.16.1 )"

src_unpack(){
	if use zinnia ; then
		unpack zinnia-tomoe-0.6.0-20080911.tar.bz2
	fi
	unpack ${P}.tar.bz2
}

src_configure() {

	if use zinnia ; then

	( cd ../zinnia-tomoe-0.6.0-20080911 && econf )   || die

	ECONF="$ECONF $(use_enable zinnia)
	--with-zinnia-tomoe=/usr/share/${PN}/data
	"
	fi

	econf $(use_enable nls) $ECONF || die

}

src_compile(){

	if use zinnia ; then
		( cd ../zinnia-tomoe-0.6.0-20080911 && emake )   || die
	fi

	emake || die
}

src_install(){

	googlecode_src_install

	if use zinnia ; then

	cd ../zinnia-tomoe-0.6.0-20080911

	install handwriting-ja.model ${D}/usr/share/ibus-handwrite/data/ || die
	install handwriting-zh_CN.model ${D}/usr/share/ibus-handwrite/data/ || die

	fi

}
