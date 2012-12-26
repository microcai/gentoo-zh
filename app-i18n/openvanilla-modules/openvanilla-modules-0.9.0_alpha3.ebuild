# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit versionator

MY_P=${PN}-0.9.0a1.3

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
		$(useq linguas_ja && echo --enable-jp_JP ) \
		$(useq linguas_ko && echo --enable-ko_KR ) \
		$(useq linguas_th && echo --enable-th_TH ) \
		$(useq linguas_vi && echo --enable-vi_VN ) \
		$(useq linguas_zh_CN && echo --enable-zh_CN ) \
		$(useq linguas_zh_HK && echo --enable-zh_HK ) \
		$(useq linguas_zh_TW && echo --enable-zh_TW ) \
		$(useq linguas_zh_TW && echo --enable-zh_TW_hakka --enable-zh_TW_taigi ) \
		--disable-asia \
		--disable-dependency-tracking \
		--enable-fast-install
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc ChangeLog
}
