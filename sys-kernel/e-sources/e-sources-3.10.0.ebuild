# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
K_DEBLOB_AVAILABLE="0"

ck_version="1"
gentoo_version="3"
optimization_version="1"
tuxonice_version="2013.06.29"
uksm_version="0.1.2.2"

aufs_kernel_version="3.10_p20130708"
cjktty_kernel_version="3.8.1"
imq_kernel_version="3.9.0"
reiser4_kernel_version="3.9.2"
tuxonice_kernel_version="3.10.0"
uksm_kernel_version="3.10.0"

KEYWORDS=""

# aufs cjktty ck gentoo imq optimization reiser4 tuxonice uksm
SUPPORTED_USE="+aufs +cjktty +gentoo +optimization +uksm"

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

ADDITION_PATCHES=""

inherit e-sources
