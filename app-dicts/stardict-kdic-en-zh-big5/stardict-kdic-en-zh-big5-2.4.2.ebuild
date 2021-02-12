# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

FROM_LANG="English"
TO_LANG="Traditional Chinese (BIG5)"
DICT_PREFIX="kdic-ec-"
DICT_SUFFIX="14w-big5"

DESCRIPTION="英譯中字典"

inherit stardict
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
