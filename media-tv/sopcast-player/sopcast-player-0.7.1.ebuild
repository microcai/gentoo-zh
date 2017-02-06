# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

TAR_SUFFIX=tar.gz

inherit googlecode

DESCRIPTION="A GTK+ front-end for the SopCast P2P TV player"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""


S=${WORKDIR}/${PN}

DEPEND="dev-lang/python[sqlite]
	sys-devel/gettext"
RDEPEND="${DEPEND}
	dev-python/pygtk
	dev-python/pygobject
	net-p2p/sopcast-bin
	=media-video/vlc-1.1*"

src_install() {
	emake DESTDIR=${D} install \
	|| die "emake install failed"
	dosym /usr/bin/sopcast-bin /usr/bin/sp-sc
}
