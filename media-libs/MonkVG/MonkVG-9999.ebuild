# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7
AUTOTOOLS_IN_SOURCE_BUILD=1

inherit git-2 autotools-utils

DESCRIPTION="MonkVG is an OpenVG 1.1 like vector graphics API implementation
currently using an OpenGL ES backend"
HOMEPAGE="https://github.com/micahpearlman/MonkVG"
SRC_URI=""

EGIT_REPO_URI="https://github.com/microcai/MonkVG.git"

#https://github.com/micahpearlman/${PN}.git"


LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="virtual/opengl
	media-libs/glew"
DEPEND="${RDEPEND}"

src_prepare(){
	eautoreconf
}

src_configure(){
	econf $(use_enable static-libs static)
}
