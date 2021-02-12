# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="HIME Input Method Editor"
HOMEPAGE="http://hime.luna.com.tw/"
SRC_URI="http://hime.luna.com.tw/hime-${PV}.tar.xz
	chinese-sound? ( http://www.csie.nctu.edu.tw/~cp76/hime/download/ogg.tgz )"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="filter-nobopomofo chinese-sound anthy chewing gtk3 qt4"

DEPEND=">=x11-libs/gtk+-2
	anthy? ( >=app-i18n/anthy-9100 )
	chewing? ( dev-libs/libchewing )
	gtk3? ( x11-libs/gtk+:3 )
	qt4? ( dev-qt/qtcore:4 dev-qt/qtgui )"
RDEPEND="${DEPEND}
	chinese-sound? ( media-sound/vorbis-tools[ogg123] )"
DEPEND="${DEPEND}
	virtual/pkgconfig
	sys-devel/gettext"

RESTRICT="mirror"
S=${WORKDIR}/${P/_/.}

src_prepare() {
	echo "${P}" > ${S}/VERSION.hime
}

src_configure() {
	econf --use_i18n=Y \
		--use_tsin=Y \
		--use_qt3=N \
		$(! use anthy && echo --use_anthy=N ) \
		$(! use chewing && echo --use_chewing=N ) \
		$(! use qt4 && echo --use_qt4=N ) \
		$(! use gtk3 && echo --use_gtk3=N )
}

src_compile() {
	filter-ldflags "-Wl,--as-needed"
	MAKEOPTS="${MAKEOPTS} -j1" emake CC="$(tc-getCC)" || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	if use filter-nobopomofo ; then
		insinto /usr/share/pixmaps/hime
		doins "${FILESDIR}"/nobopomofo/{SS1135_ST,SS1208_DT}.jpg || die
		exeinto /usr/share/hime/script
		doexe "${FILESDIR}"/nobopomofo/hime-filter-nobopomofo || die
		doenvd "${FILESDIR}"/nobopomofo/99hime-filter-nobopomofo || die
	fi

	if use chinese-sound ; then
		insinto /usr/share/${PN}
		doins -r "${WORKDIR}"/ogg || die
	fi
}
