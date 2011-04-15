# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 

EAPI="3"

inherit git autotools

EGIT_REPO_URI="git://live.debian.net/git/live-build.git"
EGIT_BRANCH="debian"

DESCRIPTION="Debian Live System Build Scripts"
HOMEPAGE="http://live.debian.net/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS=""

DEPEND="dev-util/debootstrap || ( dev-util/cdebootstrap )"
RDEPEND="${DEPEND}"

src_configure() {
	echo "pass..."
}

src_compile() {
	echo "pass..."
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
}
