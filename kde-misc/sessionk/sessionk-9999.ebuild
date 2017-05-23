# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base git-r3

DESCRIPTION="load kde session faster"
HOMEPAGE="https://dantti.wordpress.com/2013/02/27/1-2-3-plasma/"
SRC_URI=""

EGIT_REPO_URI="https://anongit.kde.org/scratch/dantti/sessionk.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-apps/dbus
		kde-base/kdelibs"

RDEPEND="${DEPEND}
	kde-base/kwin
	kde-base/plasma-workspace"



