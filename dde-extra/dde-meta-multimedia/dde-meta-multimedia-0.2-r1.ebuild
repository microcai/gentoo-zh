# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4

DESCRIPTION="Deepin Multimedia Softwares (meta package)"
HOMEPAGE="http://www.linuxdeepin.com"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-sound/deepin-music
		|| ( media-video/deepin-movie-reborn
			 media-video/deepin-movie )
		media-gfx/deepin-screenshot
		media-gfx/deepin-screen-recorder
		media-sound/deepin-voice-recorder
		media-gfx/deepin-image-viewer
		"
