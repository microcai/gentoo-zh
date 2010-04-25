# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils subversion

DESCRIPTION="Sogou Pinyin Cloud Client on ibus platform"
HOMEPAGE="https://ibus-sogoupycc.googlecode.com/"
SRC_URI=""

ESVN_REPO_URI="${HOMEPAGE}svn/trunk/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS=""

RDEPEND=">=app-i18n/ibus-1.2.0.20100111
	>=dev-lang/lua-5.1
	dev-db/sqlite:3
	dev-libs/glib
	dev-libs/luasocket
	sys-apps/dbus
	x11-libs/gtk+:2
	x11-libs/libnotify"
DEPEND="${RDEPEND}"

RESTRICT="mirror"

QA_PRESTRIPPED="usr/share/ibus-sogoupycc/engine/ibus-sogoupycc"

src_configure() {
	# Set cmake root dir. MUST be done here.
	S=${S}/linux

	cmake-utils_src_configure
}
