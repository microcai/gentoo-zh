# Copyright 1999-2009 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/app-dicts/stardict-soothill-buddhist-zh-en-big5/stardict-soothill-buddhist-zh-en-big5-2.4.2.ebuild,v 1.1 2006/10/05 08:06:04 scsi Exp $

FROM_LANG="Traditional Chinese (BIG5)"
TO_LANG="English"
DICT_PREFIX="soothill-"
DICT_SUFFIX="buddhist"

DESCRIPTION="Soothill-Hodous Dictionary of Chinese Buddhist Terms"

inherit stardict
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=app-dicts/stardict-2.4.2"

