# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
K_DEBLOB_AVAILABLE="1"

bfq_version=""
ck_version="1"
fbcondecor_version="0.9.6"
gentoo_version="4"
tuxonice_version="2013.05.01"
uksm_version=""

aufs_kernel_version="3.x_p20130429"
bfq_kernel_version=""
cjktty_kernel_version="3.8.1"
imq_kernel_version=""
reiser4_kernel_version=""
tuxonice_kernel_version="3.9.0"
uksm_kernel_version=""

KEYWORDS="~amd64 ~x86"

SUPPORTED_USE="+aufs *bfq cjktty +ck +fbcondecor +gentoo *imq *reiser4 +tuxonice *uksm"

CK_PRE_PATCH=""
CK_POST_PATCH=""
UNIPATCH_EXCLUDE=""

OVERRIDE_AUFS_PATCHES=""
OVERRIDE_BFQ_PATCHES=""
OVERRIDE_CJKTTY_PATCHES=""
OVERRIDE_CK_PATCHES=""
OVERRIDE_FBCONDECOR_PATCHES=""
OVERRIDE_IMQ_PATCHES=""
OVERRIDE_REISER4_PATCHES=""
OVERRIDE_TUXONICE_PATCHES=""
OVERRIDE_UKSM_PATCHES=""

inherit e-sources
