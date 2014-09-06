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
	cn? ( ${SRC_PREFIX}CN${SRC_SUFFIX} )
	jp? ( ${SRC_PREFIX}JP${SRC_SUFFIX} )
	kr? ( ${SRC_PREFIX}KR${SRC_SUFFIX} )
	twhk? ( ${SRC_PREFIX}TWHK${SRC_SUFFIX} )
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc mips ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE="+otc cn jp kr twhk"
REQUIRED_USE="|| ( otc cn jp kr twhk )"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/"
FONT_S="${S}"

# Only installs fonts
RESTRICT="strip binchecks"

src_prepare() {
	if use cn ; then
		mv -vf "${WORKDIR}/${MY_PN}CN-${PV}/"* ${S} || die
	fi
	if use jp ; then
		mv -vf "${WORKDIR}/${MY_PN}JP-${PV}/"* ${S} || die
	fi
	if use kr ; then
		mv -vf "${WORKDIR}/${MY_PN}KR-${PV}/"* ${S} || die
	fi
	if use twhk ; then
		mv -vf "${WORKDIR}/${MY_PN}TWHK-${PV}/"* ${S} || die
	fi
	if use otc ; then
		mv -vf "${WORKDIR}/${MY_PN}OTC-${PV}/"* ${S} || die
	fi
}

src_install() {
	FONT_SUFFIX="otc"
	FONT_CONF=()
	if use cn ; then
		FONT_CONF+=(${FILESDIR}/81-source-han-sans-cn.conf)
	fi
	if use jp ; then
		FONT_CONF+=(${FILESDIR}/81-source-han-sans-jp.conf)
	fi
	if use kr ; then
		FONT_CONF+=(${FILESDIR}/81-source-han-sans-otc.conf)
	fi
	if use twhk ; then
		FONT_CONF+=(${FILESDIR}/81-source-han-sans-twhk.conf)
	fi
	if use otc ; then
		FONT_CONF+=(${FILESDIR}/81-source-han-sans-otc.conf)
		FONT_SUFFIX="ttc"
	fi

	font_src_install
}
