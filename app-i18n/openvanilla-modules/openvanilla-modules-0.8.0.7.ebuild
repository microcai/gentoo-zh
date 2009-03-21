# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit versionator

#MYLANG="ja ko th vi zh_CN zh_HK zh_TW"
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
	local myoptions="--without-asia "
	use linguas_ja && myoptions+="--with-jp_JP "
	use linguas_ko && myoptions+="--with-ko_KR "
	use linguas_th && myoptions+="--with-th_TH "
	use linguas_vi && myoptions+="--with-vi_VN "
	use linguas_zh_CN && myoptions+="--with-zh_CN "
	use linguas_zh_HK && myoptions+="--with-zh_HK "
	use linguas_zh_TW && \
		myoptions+="--with-zh_TW --with-zh_TW_hakka --with-zh_TW_taigi "
	econf \
		${myoptions} \
		--disable-dependency-tracking
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
}
