# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Merge this to pull in Fcitx packages"
HOMEPAGE="https://fcitx-im.org"

LICENSE="metapackage"
SLOT="5"
KEYWORDS="~amd64 ~x86"
IUSE="+configtool +chinese-addons gtk2 +gtk3 hangul lua +qt5 rime skk "

DEPEND=""
RDEPEND="
	app-i18n/fcitx:5
	configtool? ( app-i18n/fcitx-configtool:5 )
	chinese-addons? (
		lua? ( app-i18n/fcitx-chinese-addons:5[lua] )
		!lua? ( app-i18n/fcitx-chinese-addons:5 )
	)
	gtk2? ( app-i18n/fcitx-gtk:5[gtk2] )
	gtk3? ( app-i18n/fcitx-gtk:5[gtk3] )
	hangul? ( app-i18n/fcitx-hangul:5 )
	lua? ( app-i18n/fcitx-lua:5 )
	qt5? ( app-i18n/fcitx-qt:5 )
	rime? ( app-i18n/fcitx-rime:5 )
	skk? ( app-i18n/fcitx-skk:5 )
"
BDEPEND=""
