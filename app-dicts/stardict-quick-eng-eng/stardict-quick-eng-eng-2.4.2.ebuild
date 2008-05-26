# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/app-dicts/stardict-quick-eng-eng/stardict-quick-eng-eng-2.4.2.ebuild,v 1.1 2006/10/05 08:06:04 scsi Exp $

FROM_LANG="English"
TO_LANG="French"
DICT_PREFIX="quick_"

inherit stardict
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=app-dicts/stardict-2.4.2"

