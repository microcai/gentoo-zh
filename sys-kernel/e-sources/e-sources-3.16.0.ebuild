# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
K_DEBLOB_AVAILABLE="0"

#ck_version="1"
gentoo_version="1"
tuxonice_version="2014.07.31"
uksm_version="0.1.2.3"

#aufs_kernel_version="3.15_p20140728"
cjktty_kernel_version="3.14"
#reiser4_kernel_version=""
tuxonice_kernel_version="head-3.16.0-rc7"
#uksm_kernel_version="3.15.3"

KEYWORDS=""

SUPPORTED_USE="+additional +cjktty +experimental +gentoo +thinkpad +tuxonice"
UNSUPPORTED_USE="aufs ck exfat imq reiser4 uksm"

UNIPATCH_EXCLUDE=""

OVERRIDE_AUFS_PATCHES=""
OVERRIDE_CJKTTY_PATCHES=""
OVERRIDE_CK_PATCHES=""
OVERRIDE_REISER4_PATCHES=""
OVERRIDE_TUXONICE_PATCHES=""
OVERRIDE_UKSM_PATCHES=""

inherit e-sources
