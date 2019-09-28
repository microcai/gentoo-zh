# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Virtual for DDE Window Manager"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mutter kwin +minimal"
REQUIRED_USE="|| ( mutter kwin minimal )
			?? ( mutter kwin )"

RDEPEND="
	mutter? (
		x11-wm/deepin-wm
		x11-wm/deepin-metacity
	)
	kwin? ( x11-wm/dde-kwin )
	minimal? (
		|| ( x11-wm/deepin-metacity
			x11-wm/deepin-wm
			x11-wm/dde-kwin )
	)"
