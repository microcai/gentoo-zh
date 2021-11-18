# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Merge this to pull in Fcitx packages"
HOMEPAGE="https://fcitx-im.org"

LICENSE="metapackage"
SLOT="5"
KEYWORDS="~amd64 ~x86"
IUSE="+configtool +chinese-addons gtk2 +gtk3 hangul +qt5 rime skk "

DEPEND=""
RDEPEND="
	app-i18n/fcitx5
	configtool? ( app-i18n/fcitx5-configtool )
	chinese-addons? ( app-i18n/fcitx5-chinese-addons )
	gtk2? ( app-i18n/fcitx5-gtk[gtk2] )
	gtk3? ( app-i18n/fcitx5-gtk[gtk3] )
	hangul? ( app-i18n/fcitx5-hangul )
	qt5? ( app-i18n/fcitx5-qt )
	rime? ( app-i18n/fcitx5-rime )
	skk? ( app-i18n/fcitx5-skk )
"
BDEPEND=""
