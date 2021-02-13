# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

FROM_LANG="Traditional Chinese (BIG5)"
TO_LANG="English"
DICT_PREFIX="langdao-ce-"
DICT_SUFFIX="big5"

DESCRIPTION="朗道漢英字典5.0"

inherit stardict
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
