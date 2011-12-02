# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Synfig: Film-Quality Vector Animation (main UI)"
HOMEPAGE="http://www.synfig.com/"
SRC_URI="mirror://sourceforge/synfig/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-devel/libtool-1.3.5
	>=dev-cpp/gtkmm-2.4.0
	>=dev-libs/libsigc++-2.0
	>=media-gfx/synfig-${PV}"

RDEPEND="${DEPEND}"

src_compile() {
	econf || die "Configure failed!"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed!"
}
