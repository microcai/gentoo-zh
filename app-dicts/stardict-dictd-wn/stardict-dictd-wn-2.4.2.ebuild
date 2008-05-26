# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/app-dicts/stardict-dictd-wn/stardict-dictd-wn-2.4.2.ebuild,v 1.1 2006/10/05 08:06:04 scsi Exp $

DESCRIPTION="Stardict Dictionary for Gcide.org's Wn's Dictionary"
DICT_PREFIX="dictd_www.dict.org_"

inherit stardict
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=app-dicts/stardict-2.4.2"

