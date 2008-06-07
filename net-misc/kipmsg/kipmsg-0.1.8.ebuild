# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils kde 


DSCRIPTION="This is a pop up style LAN Messenger for KDE ."
HOMEPAGE="http://kipmsg.sourceforge.jp"
SRC_URI="mirror://sourceforge.jp/kipmsg/30904/${P}.tar.gz"

SLOT="0"         
IUSE=""
LICENSE="GPL-2" 
KEYWORDS="x86 amd64" 
RESTRICT="mirror"  

DEPEND="net-misc/libipmsg"

need-kde 3

