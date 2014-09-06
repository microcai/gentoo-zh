# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit font

MY_PN="SourceHanSans"
SRC_PREFIX="mirror://sourceforge/${PN}.adobe/${MY_PN}"
SRC_SUFFIX="-${PV}.zip"

DESCRIPTION="Source Han Sans is an OpenType/CFF Pan-CJK font family."
HOMEPAGE="https://github.com/adobe-fonts/source-han-sans"

SRC_URI="otc? ( ${SRC_PREFIX}OTC${SRC_SUFFIX} )
	linguas_ja? ( ${SRC_PREFIX}JP${SRC_SUFFIX} )
	linguas_ko? ( ${SRC_PREFIX}KR${SRC_SUFFIX} )
	linguas_zh_CN? ( ${SRC_PREFIX}CN${SRC_SUFFIX} )
	linguas_zh_TW? ( ${SRC_PREFIX}TWHK${SRC_SUFFIX} )
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc mips ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE="+otc linguas_ja linguas_ko linguas_zh_CN linguas_zh_TW"
REQUIRED_USE="|| ( otc linguas_ja linguas_ko linguas_zh_CN linguas_zh_TW )"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/"
FONT_S="${S}"

# Only installs fonts
RESTRICT="strip binchecks mirror"

src_prepare() {
	if use otc ; then
		mv -vf "${WORKDIR}/${MY_PN}OTC-${PV}/"* ${S} || die
	fi
	if use linguas_ja ; then
		mv -vf "${WORKDIR}/${MY_PN}JP-${PV}/"* ${S} || die
	fi
	if use linguas_ko ; then
		mv -vf "${WORKDIR}/${MY_PN}KR-${PV}/"* ${S} || die
	fi
	if use linguas_zh_CN ; then
		mv -vf "${WORKDIR}/${MY_PN}CN-${PV}/"* ${S} || die
	fi
	if use linguas_zh_TW ; then
		mv -vf "${WORKDIR}/${MY_PN}TWHK-${PV}/"* ${S} || die
	fi
}

src_install() {
	local has_linguas=false
	FONT_SUFFIX=""
	FONT_CONF=()
	if use otc ; then
		FONT_CONF+=(${FILESDIR}/81-source-han-sans-otc.conf)
		FONT_SUFFIX="${FONT_SUFFIX} ttc"
	fi
	if use linguas_ja ; then
		FONT_CONF+=(${FILESDIR}/81-source-han-sans-jp.conf)
		has_linguas=true
	fi
	if use linguas_ko ; then
		FONT_CONF+=(${FILESDIR}/81-source-han-sans-kr.conf)
		has_linguas=true
	fi
	if use linguas_zh_CN ; then
		FONT_CONF+=(${FILESDIR}/81-source-han-sans-cn.conf)
		has_linguas=true
	fi
	if use linguas_zh_TW ; then
		FONT_CONF+=(${FILESDIR}/81-source-han-sans-twhk.conf)
		has_linguas=true
	fi

	if [ $has_linguas = true ]; then
		FONT_SUFFIX="${FONT_SUFFIX} otf"
	fi

	font_src_install
}
