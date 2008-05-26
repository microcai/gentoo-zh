# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

USE_KEG_PACKAGING=1
LANGS="ar bg br ca cs cy da de el en_GB es et fr ga gl it ka lt nl pa pt ru rw sk sr sr@Latn sv ta tr vi"

inherit kde

DESCRIPTION="A network sniffer for KDE"
HOMEPAGE="http://www.ksniffer.org"
SRC_URI="http://downloads.sourceforge.net/ksniffer/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="dev-libs/libxml2
				net-libs/libpcap"
RDEPEND="${DEPEND}"

need-kde 3.3
