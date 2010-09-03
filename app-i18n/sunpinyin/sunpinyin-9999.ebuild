# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
PYTHON_DEPEND="ibus? 2:2.5"
inherit confutils git python

EGIT_REPO_URI="git://github.com/sunpinyin/sunpinyin.git"

DESCRIPTION="SunPinyin is a SLM (Statistical Language Model) based IME"
HOMEPAGE="http://sunpinyin.org/"
SRC_URI="http://open-gram.googlecode.com/files/dict.utf8.tar.bz2
	http://open-gram.googlecode.com/files/lm_sc.t3g.arpa.tar.bz2"

LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS=""
IUSE_FRONTEND="ibus xim"
IUSE="${IUSE_FRONTEND} nls"

RDEPEND="dev-db/sqlite:3
	ibus? (
		>=app-i18n/ibus-1.1
		!app-i18n/ibus-sunpinyin
	)
	nls? ( virtual/libintl )
	xim? (
		>=x11-libs/gtk+-2.12:2
		x11-libs/libX11
	)"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/scons
	nls? ( sys-devel/gettext )
	xim? ( x11-proto/xproto )"

RESTRICT="primaryuri"

pkg_setup() {
	confutils_require_any ibus xim
}

src_prepare() {
	ln -s "${DISTDIR}"/{dict.utf8,lm_sc.t3g.arpa}.tar.bz2 "${S}"/raw
	epatch "${FILESDIR}/${PN}"-disable-checkpkg.patch
}

_scons_do_all() {
	_scons_do() {
		if [ "${1}" == "compile" ]; then
			operation=""
		else
			operation=${1}
		fi
		scons --prefix=/usr "${operation}" || die "compile failed"
	}

	_scons_do_use() {
		if use $2; then
			cd "${S}/wrapper/$2"
			_scons_do "$1"
		fi
	}

	_scons_do "$1"
	for wrapper in ${IUSE_FRONTEND}; do
		_scons_do_use "$1" "${wrapper}"
	done
	cd "${S}"
}

src_compile() {
	_scons_do_all "compile"
}

src_install() {
	_scons_do_all "install"

	dodoc AUTHORS README || die
}

pkg_postinst() {
	use ibus && python_mod_optimize /usr/share/ibus-${PN}/setup
	if use xim ; then
		elog "To use sunpinyin with XIM, you should use the following"
		elog "in your user startup scripts such as .xinitrc or .xprofile:"
		elog "XMODIFIERS=@im=xsunpinyin ; export XMODIFIERS"
	fi
}

pkg_postrm() {
	use ibus && python_mod_cleanup /usr/share/ibus-${PN}/setup
}
