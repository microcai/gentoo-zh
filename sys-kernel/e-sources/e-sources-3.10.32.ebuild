# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
K_DEBLOB_AVAILABLE="1"

ck_version="1"
gentoo_version="39"
tuxonice_version="2014.02.23"
uksm_version="0.1.2.2"

aufs_kernel_version="3.10.x_p20140224"
cjktty_kernel_version="3.10.0"
reiser4_kernel_version="3.10.0"
tuxonice_kernel_version="3.10.32"
uksm_kernel_version="3.10.0"

KEYWORDS="amd64 x86 mips"

SUPPORTED_USE="+additional +aufs +cjktty +ck +exfat +experimental +gentoo +imq +optimization +reiser4 +thinkpad +tuxonice +uksm"
UNSUPPORTED_USE=""

UNIPATCH_EXCLUDE="*BFQ*"

OVERRIDE_AUFS_PATCHES=""
OVERRIDE_CJKTTY_PATCHES=""
OVERRIDE_CK_PATCHES=""
OVERRIDE_REISER4_PATCHES=""
OVERRIDE_TUXONICE_PATCHES=""
OVERRIDE_UKSM_PATCHES=""

inherit e-sources
