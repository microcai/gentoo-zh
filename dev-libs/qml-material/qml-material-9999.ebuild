# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_LFS="yes"

inherit git-r3 cmake

DESCRIPTION="A library of Qml implementing Google's Material Design"
HOMEPAGE="https://github.com/hypengw/QmlMaterial"

LICENSE="MPL-2.0"
SLOT="0"

RDEPEND="
	media-libs/freetype[brotli]
	dev-qt/qtbase:6[gui]
	dev-qt/qtdeclarative:6
	dev-qt/qtshadertools:6
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

EGIT_REPO_URI="https://github.com/hypengw/QmlMaterial.git"
