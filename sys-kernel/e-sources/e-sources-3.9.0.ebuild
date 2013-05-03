# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
K_DEBLOB_AVAILABLE="1"

# bfq_version=" "
# ck_version=" "
fbcondecor_version="0.9.6"
gentoo_version="1"
tuxonice_version="2013.05.01"
# uksm_version=" "

aufs_kernel_version="3.x_p20130429"
# bfq_kernel_version=" "
cjktty_kernel_version="3.8.1"
# imq_kernel_version=" "
# reiser4_kernel_version=" "
tuxonice_kernel_version="3.9.0"
# uksm_kernel_version=" "

KEYWORDS="~amd64 ~x86"

# KNOWN_FEATURES="aufs bfq cjktty ck fbcondecor gentoo imq reiser4 tuxonice uksm"
SUPPORTED_USE="+aufs cjktty +gentoo +fbcondecor +tuxonice"

# CK_PRE_PATCH=" "
# CK_POST_PATCH=" "
# UNIPATCH_EXCLUDE=" "

inherit e-sources
