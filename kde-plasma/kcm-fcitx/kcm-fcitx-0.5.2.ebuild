# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils kde5-functions kde5

DESCRIPTION="KDE5 control Module for Fcitx"
HOMEPAGE="https://github.com/fcitx/kcm-fcitx"
SRC_URI="http://download.fcitx-im.org/${PN}/${P}.tar.xz"
#SRC_URI="https://github.com/fcitx/kcm-fcitx/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND=">=app-i18n/fcitx-4.2.8.6[dbus]
$(add_frameworks_dep plasma)"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	virtual/pkgconfig
	sys-devel/gettext
	app-i18n/fcitx-qt5"

src_prepare(){
	echo
}
