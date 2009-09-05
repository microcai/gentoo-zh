# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

EGIT_REPO_URI="git://anongit.freedesktop.org/~jinghua/libppswrapper"
inherit git autotools

DESCRIPTION="A libpps wrapper"
HOMEPAGE="http://cgit.freedesktop.org/~jinghua"
SRC_URI=""

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-util/intltool-0.40.0
		dev-util/pkgconfig
		sys-devel/gettext"
RDEPEND="${DEPEND}"

src_prepare() {
	NOCONFIGURE=1 ./autogen.sh || die "autogen.sh failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
}

