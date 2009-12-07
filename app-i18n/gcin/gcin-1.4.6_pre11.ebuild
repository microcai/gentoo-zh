# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="Another Traditional Chinese IM."
HOMEPAGE="http://www.csie.nctu.edu.tw/~cp76/gcin/ http://cle.linux.org.tw/trac/wiki/GcinGirlForNoBopomofo"
SRC_URI="http://cle.linux.org.tw/gcin/download/${P/_/.}.tar.bz2
	chinese-sound? ( http://cle.linux.org.tw/gcin/download/ogg.tgz )"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ia64 ~ppc ~hppa"
IUSE="qt3 filter-nobopomofo chinese-sound anthy qt4"

# XXX: Missing QT4 dependencies.
DEPEND=">=x11-libs/gtk+-2
	>=dev-libs/glib-2.4
	>=dev-libs/atk-1.0.1
	>=x11-libs/pango-1.4
	anthy? ( >=app-i18n/anthy-9100 )
	qt3? ( x11-libs/qt:3 )
	qt4? ( x11-libs/qt-core:4 x11-libs/qt-gui )"
RDEPEND="${DEPEND}
	chinese-sound? ( media-sound/vorbis-tools[ogg123] )"

RESTRICT="mirror"
S=${WORKDIR}/${P/_/.}


src_prepare() {
	epatch "${FILESDIR}/gcin-1.4.4-qt3_fix.patch" \
		"${FILESDIR}/gcin-1.4.4-qt4_fix.patch" 
}

src_configure() {
	default
	# To avoid magic dependencies.
	! use anthy && echo "USE_ANTH=NO" >> config.mak
	! use qt3 && echo "QT_IM=NO" >> config.mak
	! use qt4 && echo "QT4_IM=NO" >> config.mak
}

src_compile() {
	filter-ldflags "-Wl,--as-needed"
	MAKEOPTS="${MAKEOPTS} -j1" emake CC="$(tc-getCC)" || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	if use filter-nobopomofo ; then
		insinto /usr/share/pixmaps/gcin
		doins "${FILESDIR}"/nobopomofo/{SS1135_ST,SS1208_DT}.jpg || die
		exeinto /usr/share/gcin/script
		doexe "${FILESDIR}"/nobopomofo/gcin-filter-nobopomofo || die
		doenvd "${FILESDIR}"/nobopomofo/99gcin-filter-nobopomofo || die
	fi

	if use chinese-sound ; then
		insinto /usr/share/${PN}
		doins -r "${WORKDIR}"/ogg || die
	fi
}
