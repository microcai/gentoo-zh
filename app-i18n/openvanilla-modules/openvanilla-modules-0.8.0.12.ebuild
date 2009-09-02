# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit versionator

MY_P=${PN}-$(replace_version_separator 3 '_')
DESCRIPTION="Input methods modules and tables for OpenVanilla Input Method Framework"
HOMEPAGE="http://openvanilla.org http://ucimf.googlecode.com"
SRC_URI="http://ucimf.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="linguas_ja linguas_ko linguas_th linguas_vi linguas_zh_CN linguas_zh_HK linguas_zh_TW"

DEPEND=">=dev-db/sqlite-3"
RDEPEND=""

S=${WORKDIR}/${MY_P}

src_configure() {
	# use_with doesn't work here.
	econf \
		$(useq linguas_ja && echo --with-jp_JP ) \
		$(useq linguas_ko && echo --with-ko_KR ) \
		$(useq linguas_th && echo --with-th_TH ) \
		$(useq linguas_vi && echo --with-vi_VN ) \
		$(useq linguas_zh_CN && echo --with-zh_CN ) \
		$(useq linguas_zh_HK && echo --with-zh_HK ) \
		$(useq linguas_zh_TW && echo --with-zh_TW ) \
		$(useq linguas_zh_TW && echo --with-zh_TW_hakka --with-zh_TW_taigi ) \
		--without-asia \
		--disable-dependency-tracking \
		--enable-fast-install
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc ChangeLog
}
