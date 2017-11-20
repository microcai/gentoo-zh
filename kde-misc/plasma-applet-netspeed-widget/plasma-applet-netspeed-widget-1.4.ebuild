# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit kde5

DESCRIPTION="Plasma 5 widget that displays the currently used network bandwidth."
HOMEPAGE="https://www.kde-look.org/p/998895/
https://github.com/HessiJames/plasma-applet-netspeed-widget"

if [[ ${KDE_BUILD_TYPE} = live ]] ; then
	EGIT_REPO_URI="https://github.com/HessiJames/${PN}.git"
else
	SRC_URI="https://github.com/HessiJames/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-2+"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	$(add_frameworks_dep plasma)
"
RDEPEND="${DEPEND}"

DOCS=( README.md )
