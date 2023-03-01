# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Merge this to pull in Fcitx packages"
HOMEPAGE="https://fcitx-im.org"

LICENSE="metapackage"
SLOT="5"
KEYWORDS="~amd64 ~arm64 ~loong ~x86"
IUSE="+configtool +chinese-addons gtk2 +gtk3 gtk4 hangul lua +qt5 rime skk"

DEPEND=""
RDEPEND="
	app-i18n/fcitx:${SLOT}
	configtool? ( app-i18n/fcitx-configtool:${SLOT} )
	chinese-addons? (
		lua? ( app-i18n/fcitx-chinese-addons:${SLOT}[lua] )
		!lua? ( app-i18n/fcitx-chinese-addons:${SLOT} )
	)
	gtk2? ( app-i18n/fcitx-gtk:${SLOT}[gtk2] )
	gtk3? ( app-i18n/fcitx-gtk:${SLOT}[gtk3] )
	gtk4? ( app-i18n/fcitx-gtk:${SLOT}[gtk4] )
	qt5? ( app-i18n/fcitx-qt:${SLOT} )
	!loong? (
		rime? ( app-i18n/fcitx-rime:${SLOT} )
		!arm64? (
			hangul? ( app-i18n/fcitx-hangul:${SLOT} )
			lua? ( app-i18n/fcitx-lua:${SLOT} )
			skk? ( app-i18n/fcitx-skk:${SLOT} )
		)
	)
"
BDEPEND=""
