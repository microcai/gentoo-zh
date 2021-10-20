# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Merge this to pull in Fcitx packages"
HOMEPAGE="https://fcitx-im.org"

LICENSE="metapackage"
SLOT="5"
KEYWORDS="~amd64 ~x86"
IUSE="+configtool gtk2 +gtk3 +qt5"

DEPEND=""
RDEPEND="
	app-i18n/fcitx5
	qt5? ( app-i18n/fcitx5-qt )
	gtk2? ( app-i18n/fcitx5-gtk[gtk2] )
	gtk3? ( app-i18n/fcitx5-gtk[gtk3] )
	configtool? ( app-i18n/fcitx5-configtool )
"
BDEPEND=""
