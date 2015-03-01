# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
K_DEBLOB_AVAILABLE="1"

ck_version="1"
gentoo_version="1"
#tuxonice_version="2015.02.14"  it is buggy
#uksm_version="0.1.2.3"

aufs_kernel_version="3.19_p20150216"
cjktty_kernel_version="3.19"
#reiser4_kernel_version="3.17.2"
tuxonice_kernel_version="head-3.19.0"
#uksm_kernel_version="3.18.0"

KEYWORDS="~x86 ~amd64 ~mips"

SUPPORTED_USE="+additional +aufs +cjktty +ck +exfat +experimental +gentoo +thinkpad"
UNSUPPORTED_USE="imq reiser4 tuxonice uksm"

UNIPATCH_EXCLUDE=""

OVERRIDE_AUFS_PATCHES=""
OVERRIDE_CJKTTY_PATCHES=""
OVERRIDE_CK_PATCHES=""
OVERRIDE_REISER4_PATCHES=""
OVERRIDE_TUXONICE_PATCHES=""
OVERRIDE_UKSM_PATCHES=""

inherit e-sources
