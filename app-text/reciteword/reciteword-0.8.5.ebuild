# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7
inherit eutils

DESCRIPTION="Reciteword is a education software to help people to study English,
reciting english words. It have very beautiful interface, make reciting word
being a interesting things."
HOMEPAGE="http://reciteword.sourceforge.net/"
SRC_URI="http://downloads.sourceforge.net/reciteword/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="alsa"

RDEPEND=">=x11-libs/gtk+-2.6
	!alsa? ( media-sound/esound ) "

src_install() {
	einstall || die "aborted."
	dodoc README INSTALL COPYING AUTHORS NEWS TODO
}
