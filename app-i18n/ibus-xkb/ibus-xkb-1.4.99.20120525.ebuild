# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools

DESCRIPTION=""
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE="+introspection -gconf +dconf python xkb"

DEPEND=">=app-i18n/ibus-1.4.99[X,gconf=,dconf=,introspection=,python=]"
RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_enable dconf) \
			$(use_enable gconf) \
			$(use_enable introspection) \
 			--disable-gtk3 \
			$(use_enable python) \
			$(use_enable xkb)  \
			--disable-libgnomekbd \
			--disable-vala 
}
