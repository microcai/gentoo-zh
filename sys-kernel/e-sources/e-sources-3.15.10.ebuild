# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
K_DEBLOB_AVAILABLE="1"

ck_version="1"
gentoo_version="12"
tuxonice_version="2014.08.07"
uksm_version="0.1.2.3"

aufs_kernel_version="3.15_p20140811"
cjktty_kernel_version="3.14"
reiser4_kernel_version="3.15.1"
tuxonice_kernel_version="3.15.8"
uksm_kernel_version="3.15.3"

KEYWORDS="~x86 ~amd64 ~mips"

SUPPORTED_USE="+additional +aufs +cjktty +ck +exfat +experimental +gentoo +imq +reiser4 +thinkpad +tuxonice +uksm"
UNSUPPORTED_USE=""

UNIPATCH_EXCLUDE=""

OVERRIDE_AUFS_PATCHES=""
OVERRIDE_CJKTTY_PATCHES=""
OVERRIDE_CK_PATCHES=""
OVERRIDE_REISER4_PATCHES=""
OVERRIDE_TUXONICE_PATCHES=""
OVERRIDE_UKSM_PATCHES=""

inherit e-sources
