# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="MonkVG is an OpenVG 1.1 like vector graphics API implementation
currently using an OpenGL ES backend"
HOMEPAGE="https://github.com/micahpearlman/MonkVG"
SRC_URI=""

EGIT_REPO_URI="git://github.com/microcai/MonkVG.git"

#git://github.com/micahpearlman/${PN}.git"

inherit git-2 autotools-utils

LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/opengl"
DEPEND="${RDEPEND}"

src_prepare(){
	eautoreconf
}
