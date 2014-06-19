# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_DEPEND="ibus? 2:2.5"
inherit confutils git-2 python scons-utils

DESCRIPTION="IME frontends for Sunpinyin"
HOMEPAGE="https://code.google.com/p/sunpinyin/"

LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS=""
IUSE_FRONTEND="ibus xim"
IUSE="${IUSE_FRONTEND} nls"

EGIT_PROJECT="sunpinyin"
EGIT_REPO_URI="https://github.com/sunpinyin/sunpinyin.git"

RDEPEND="
	dev-db/sqlite:3
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
	app-i18n/sunpinyin
	virtual/pkgconfig
	dev-util/scons
	nls? ( sys-devel/gettext )
	xim? ( x11-proto/xproto )"

pkg_setup() {
	confutils_require_any ibus xim
	python_pkg_setup
}

src_configure() {
	myesconsargs=(
		--prefix=/usr
	)
}

src_compile() {
	for wrapper in ${IUSE_FRONTEND}; do
		if use "${wrapper}"; then
			pushd "${S}/wrapper/${wrapper}"
			escons
			popd
		fi
	done
}

src_install() {
	for wrapper in ${IUSE_FRONTEND}; do
		if use "${wrapper}"; then
			pushd "${S}/wrapper/${wrapper}"
			escons --install-sandbox="${D}" install
			popd
		fi
	done
}

pkg_postinst() {
	use ibus && python_mod_optimize /usr/share/ibus-sunpinyin/setup
	if use xim ; then
		elog "To use sunpinyin with XIM, you should use the following"
		elog "in your user startup scripts such as .xinitrc or .xprofile:"
		elog "XMODIFIERS=@im=xsunpinyin ; export XMODIFIERS"
	fi
}

pkg_postrm() {
	use ibus && python_mod_cleanup /usr/share/ibus-sunpinyin/setup
}
