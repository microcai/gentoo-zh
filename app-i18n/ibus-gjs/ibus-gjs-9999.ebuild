# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools eutils git-2

DESCRIPTION="GNOME-Shell GJS Plugin for IBus"
HOMEPAGE="https://github.com/fujiwarat/ibus-gjs"
SRC_URI=""
EGIT_REPO_URI="git://github.com/fujiwarat/ibus-gjs.git
	https://github.com/fujiwarat/ibus-gjs.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="debug"

RDEPEND=">=app-i18n/ibus-1.3.99
	>=gnome-base/gnome-shell-3.2.1"
DEPEND="${RDEPEND}
	>=dev-libs/gjs-1.30.0
	>=dev-util/intltool-0.50.0"

src_prepare() {
	[[ ! -d "${S}/m4" ]] && mkdir "${S}/m4"
	intltoolize --copy --force || die "intltoolize failed"
	eautoreconf
}

src_configure() {
        econf $(use_enable debug maintainer-mode)
}
