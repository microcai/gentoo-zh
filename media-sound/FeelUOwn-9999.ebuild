# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="NetEaseMusic for Linux(The third party)"
HOMEPAGE="https://github.com/cosven/FeelUOwn"
SRC_URI=""
RESTRICT="mirror"

EGIT_HAS_SUBMODULES=0
EGIT_REPO_URI="https://github.com/cosven/FeelUOwn.git"

LICENSE="*"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt4 qt5"

DEPEND="
	dev-python/PyQt5[multimedia,webkit]
	dev-python/Quamash
	dev-python/requests
	media-libs/gstreamer:0.10
	qt4? (media-video/vlc[qt4,-qt5])
	qt5? (media-video/vlc[-qt4,qt5])
	{$PYTHON_DEPS}
"
RDEPEND="${DEPEND}"

PYTHON_COMPAT = (python3_4)

inherit git-r3 python-any-r1

src_prepare() {
	git-r3_fetch
	cd src || die

src_configure() {
	
}
