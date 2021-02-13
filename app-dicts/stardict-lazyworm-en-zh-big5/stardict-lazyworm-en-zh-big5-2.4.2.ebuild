# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

FROM_LANG="English"
TO_LANG="Traditional Chinese (BIG5)"
DICT_PREFIX="lazyworm-ec-"
DICT_SUFFIX="big5"

DESCRIPTION="懶蟲簡明英漢詞典"

inherit stardict
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
