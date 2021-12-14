# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="CutefishOS Desktop Enviroment (meta package)"
HOMEPAGE="https://cutefishos.com"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="+base +terminal +extra"

RDEPEND="
		>=sys-libs/cutefish-core-${PV}:${SLOT}
		>=cutefish-base/cutefish-kwin-plugins-${PV}:${SLOT}
		>=cutefish-base/cutefish-icons-${PV}:${SLOT}
		>=cutefish-base/cutefish-filemanager-${PV}:${SLOT}
		>=cutefish-base/cutefish-calculator-${PV}:${SLOT}
		>=cutefish-base/cutefish-launcher-${PV}:${SLOT}
		>=cutefish-base/cutefish-qt-plugins-${PV}:${SLOT}
		>=cutefish-base/cutefish-settings-${PV}:${SLOT}
		>=cutefish-base/cutefish-statusbar-${PV}:${SLOT}
		>=cutefish-base/cutefish-dock-${PV}:${SLOT}
		>=cutefish-base/cutefish-wallpapers-${PV}:${SLOT}
		>=cutefish-base/cutefish-screenlocker-${PV}:${SLOT}
		>=cutefish-base/cutefish-screenshot-${PV}:${SLOT}
		>=cutefish-base/cutefish-videoplayer-${PV}:${SLOT}
		x11-misc/sddm
		terminal?	(	>=cutefish-base/cutefish-terminal-${PV}:${SLOT}	)
		extra?	(	>=cutefish-base/cutefish-texteditor-${PV}:${SLOT}	)
"
