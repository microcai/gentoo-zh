# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit git python

EGIT_PROJECT="sunpinyin"
EGIT_REPO_URI="git://github.com/sunpinyin/sunpinyin.git"

DESCRIPTION="SunPinyin is a SLM (Statistical Language Model) based IME"
HOMEPAGE="http://sunpinyin.org/"

LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS=""
IUSE="nls"

RDEPEND="dev-db/sqlite:3
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/scons
	nls? ( sys-devel/gettext )"

_scons_do() {
	if [ "${1}" == "compile" ]; then
		dest=""
		operation=""
	elif [ "${1}" == "install" ]; then
		dest="--install-sandbox=${D}"
		operation="${1}"
	fi
	scons --prefix=/usr "${dest}" "${operation}" || die "${1} failed"
}

src_compile() {
	_scons_do "compile"
}

src_install() {
	_scons_do "install"
}
