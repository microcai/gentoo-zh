# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

FROM_LANG="English"
TO_LANG="Traditional Chinese (BIG5)"
DICT_PREFIX="21shijishuangxiangcidian-"
DICT_SUFFIX="big5"

DESCRIPTION="21世紀英漢漢英雙向詞典"

inherit stardict
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
