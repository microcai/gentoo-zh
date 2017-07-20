# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit font

DESCRIPTION="Those five TrueType fonts are transformed from cwTeX Traditional Chinese Type 1 fonts(Version 1.1)."
HOMEPAGE="https://code.google.com/p/cwtex-q-fonts/"

SRC_URI="https://github.com/l10n-tw/cwtex-q-fonts/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="x86 amd64"

IUSE=""
DEPEND=""
FONT_S="${S}/ttf"
FONT_SUFFIX="ttf"
RESTRICT="nostrip nomirror"

