# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils subversion

DESCRIPTION="lyrics display plugin for audacious/amarok"
HOMEPAGE="http://xlyrics.googlecode.com/"
ESVN_REPO_URI="http://xlyrics.googlecode.com/svn/trunk/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.4.0
		>=dev-libs/glib-2.4.0
		>=media-sound/audacious-1.4.2"

RDEPEND="${DEPEND}"

src_install(){
	emake install DESTDIR="${D}" || die "install faled"
}
