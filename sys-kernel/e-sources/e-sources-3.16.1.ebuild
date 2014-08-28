# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
K_DEBLOB_AVAILABLE="1"

ck_version="2"
gentoo_version="2"
tuxonice_version="2014.08.07"
uksm_version="0.1.2.3"

aufs_kernel_version="3.16_p20140811"
cjktty_kernel_version="3.14"
#reiser4_kernel_version=""
tuxonice_kernel_version="head-3.16.0"
uksm_kernel_version="3.16.1"

KEYWORDS=""

SUPPORTED_USE="+aufs +additional +cjktty +ck +exfat +experimental +gentoo +thinkpad +tuxonice +uksm"
UNSUPPORTED_USE="imq reiser4"

UNIPATCH_EXCLUDE=""

OVERRIDE_AUFS_PATCHES=""
OVERRIDE_CJKTTY_PATCHES=""
OVERRIDE_CK_PATCHES=""
OVERRIDE_REISER4_PATCHES=""
OVERRIDE_TUXONICE_PATCHES=""
OVERRIDE_UKSM_PATCHES=""

inherit e-sources
