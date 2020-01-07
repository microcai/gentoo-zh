# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

DESCRIPTION="Deepin Extra Applications (meta package)"
HOMEPAGE="https://www.deepin.org"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dde-extra/dde-calendar
	dde-extra/deepin-boot-maker
	dde-extra/deepin-calculator
	dde-extra/deepin-clone
	dde-extra/deepin-editor
	dde-extra/deepin-font-installer
	dde-extra/deepin-picker
	dde-extra/deepin-system-monitor
	dde-extra/deepin-topbar
	media-gfx/deepin-draw
	"
