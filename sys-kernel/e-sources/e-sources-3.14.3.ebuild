# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
K_DEBLOB_AVAILABLE="1"

ck_version="1"
gentoo_version="6"
tuxonice_version="2014.04.28"
uksm_version="0.1.2.2"

aufs_kernel_version="3.14_p20140420"
cjktty_kernel_version="3.11.0"
reiser4_kernel_version="3.14.1"
tuxonice_kernel_version="3.14.2"
uksm_kernel_version="3.14.0"

KEYWORDS=""

SUPPORTED_USE="+additional +aufs +cjktty +ck +experimental +gentoo +imq +thinkpad +rerser4 +tuxonice +uksm"
UNSUPPORTED_USE="exfat"

UNIPATCH_EXCLUDE=""

OVERRIDE_AUFS_PATCHES=""
OVERRIDE_CJKTTY_PATCHES=""
OVERRIDE_CK_PATCHES=""
OVERRIDE_REISER4_PATCHES=""
OVERRIDE_TUXONICE_PATCHES=""
OVERRIDE_UKSM_PATCHES=""

inherit e-sources
