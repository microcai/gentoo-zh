# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/app-i18n/iiimf-chewing/iiimf-chewing-0.0.2.ebuild,v 1.1 2005/01/05 17:17:10 scsi Exp $

inherit eutils iiimf

IUSE="debug"
DESCRIPTION="An IIIMF Language Engine for Traditional Chinese."
HOMEPAGE="http://chewing.csie.net"
SRC_URI="http://chewing.csie.net/download/iiimf/${P}.tar.gz"

KEYWORDS=""
#RDEPEND="app-i18n/iiimsf"

#S=${WORKDIR}/${PN}
# sorry but I only do one job at a time.
MAKEOPTS="-j1"

