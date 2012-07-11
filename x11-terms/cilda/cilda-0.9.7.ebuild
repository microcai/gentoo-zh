# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/tilda/tilda-0.9.6.ebuild,v 1.8 2011/03/23 06:21:38 ssuominen Exp $

EAPI=2
inherit eutils autotools

DESCRIPTION="cilda = Cai forked Tilda"
HOMEPAGE="https://github.com/microcai/cilda"
SRC_URI="http://cloud.github.com/downloads/microcai/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=x11-libs/vte-0.30.1
	>=dev-libs/glib-2.32
	>=x11-libs/gtk+-3.0
	dev-libs/confuse"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die
}
