# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="CutefishOS Desktop Enviroment (meta package)"
HOMEPAGE="https://cutefishos.com"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="+base +appmotor +terminal +extra +themes +sddm +cjk"

RDEPEND="
		>=sys-libs/cutefish-core-0.8:${SLOT}
		>=cutefish-base/cutefish-kwin-plugins-0.8:${SLOT}
		>=cutefish-base/cutefish-icons-0.8:${SLOT}
		>=cutefish-base/cutefish-filemanager-0.8:${SLOT}
		>=cutefish-base/cutefish-calculator-0.7:${SLOT}
		>=cutefish-base/cutefish-launcher-0.8:${SLOT}
		>=cutefish-base/cutefish-qt-plugins-0.8:${SLOT}
		>=cutefish-base/cutefish-settings-0.8:${SLOT}
		>=cutefish-base/cutefish-statusbar-0.8:${SLOT}
		>=cutefish-base/cutefish-dock-0.8:${SLOT}
		>=cutefish-base/cutefish-wallpapers-0.7:${SLOT}
		>=cutefish-base/cutefish-screenlocker-0.8:${SLOT}
		>=cutefish-base/cutefish-screenshot-0.8:${SLOT}
		>=cutefish-base/cutefish-videoplayer-0.7:${SLOT}
		x11-misc/sddm
		x11-misc/xdg-user-dirs
		appmotor?	(	>=cutefish-base/cutefish-appmotor-0.8:${SLOT}	)
		terminal?	(	>=cutefish-base/cutefish-terminal-0.8:${SLOT}	)
		extra?	(	>=cutefish-base/cutefish-texteditor-0.8:${SLOT}	)
		themes?	(	>=cutefish-base/cutefish-gtk-themes-0.7:${SLOT}	)
		sddm?	(	>=cutefish-base/cutefish-sddm-theme-0.8:${SLOT}	)
		cjk?	(	media-fonts/noto[cjk]	)
"
