# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools eutils

DESCRIPTION="GNOME-Shell GJS Plugin for IBus"
HOMEPAGE="https://github.com/fujiwarat/ibus-gjs"
SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=app-i18n/ibus-1.4.99
		>=app-i18n/ibus-xkb-1.4.99
	>=gnome-base/gnome-shell-3.4"
DEPEND="${RDEPEND}
	>=dev-libs/gjs-1.32.0
	>=dev-util/intltool-0.50.0"
