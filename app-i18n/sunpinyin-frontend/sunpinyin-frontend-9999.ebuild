# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )
inherit git-2 python-single-r1 scons-utils

DESCRIPTION="IME frontends for Sunpinyin"
HOMEPAGE="https://code.google.com/p/sunpinyin/"
EGIT_PROJECT="sunpinyin"
EGIT_REPO_URI="https://github.com/sunpinyin/sunpinyin.git"

LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS=""
IUSE_FRONTEND="ibus xim"
IUSE="${IUSE_FRONTEND} nls"
REQUIRED_USE="|| ( ${IUSE_FRONTEND} )"

RDEPEND="
	dev-db/sqlite:3
	ibus? (
		${PYTHON_DEPS}
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
	if use xim ; then
		elog "To use sunpinyin with XIM, you should use the following"
		elog "in your user startup scripts such as .xinitrc or .xprofile:"
		elog "XMODIFIERS=@im=xsunpinyin ; export XMODIFIERS"
	fi
}
