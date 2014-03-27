# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
K_DEBLOB_AVAILABLE="1"

ck_version="1"
gentoo_version="10"
tuxonice_version="2014.03.17"
uksm_version="0.1.2.2"

aufs_kernel_version="3.13_p20140310"
cjktty_kernel_version="3.11.0"
reiser4_kernel_version="3.13.1"
tuxonice_kernel_version="3.13.6"
uksm_kernel_version="3.13.0"

KEYWORDS="~amd64 ~x86 ~mips"

SUPPORTED_USE="+additional +aufs +cjktty +ck +exfat +experimental +gentoo +reiser4 +thinkpad +tuxonice +uksm"
UNSUPPORTED_USE="imq"

UNIPATCH_EXCLUDE=""

OVERRIDE_AUFS_PATCHES=""
OVERRIDE_CJKTTY_PATCHES=""
OVERRIDE_CK_PATCHES=""
OVERRIDE_REISER4_PATCHES=""
OVERRIDE_TUXONICE_PATCHES=""
OVERRIDE_UKSM_PATCHES=""

inherit e-sources
