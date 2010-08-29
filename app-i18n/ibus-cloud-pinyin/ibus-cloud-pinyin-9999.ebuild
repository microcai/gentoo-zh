# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit subversion

DESCRIPTION="Pinyin input method based on web pinyin services and ibus"
HOMEPAGE="http://code.google.com/p/ibus-cloud-pinyin/"
SRC_URI=""

ESVN_REPO_URI="http://ibus-cloud-pinyin.googlecode.com/svn/trunk/"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
KEYWORDS=""

RDEPEND=">=app-i18n/ibus-1.3.4
	dev-db/sqlite:3
	dev-lang/lua
	dev-lang/vala
	dev-libs/libgee
	dev-libs/luasocket
	x11-libs/libnotify"
DEPEND="${RDEPEND}"

QA_PRESTRIPPED="
	usr/lib/ibus-cloud-pinyin/ibus-cloud-pinyin-request
	usr/lib/ibus/ibus-engine-cloud-pinyin"

src_install() {
	emake DESTDIR="${D}" install || die
}
