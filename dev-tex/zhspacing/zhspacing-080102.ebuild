# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit xetex-package

DESCRIPTION="zhspacing fine-tunes several details in typesetting Chinese using XeTeX and XeLaTeX"
HOMEPAGE="http://code.google.com/p/zhspacing/"
SRC_URI="http://zhspacing.googlecode.com/files/${PN}${PV}.tar.bz2
	http://zhspacing.googlecode.com/files/zhs-man071211.pdf"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

RESTRICT="mirror"

S=${WORKDIR}
