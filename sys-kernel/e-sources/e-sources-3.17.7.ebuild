# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
K_DEBLOB_AVAILABLE="1"

ck_version="2"
gentoo_version="10"
#tuxonice_version=""
uksm_version="0.1.2.3"

aufs_kernel_version="3.17_p20141020"
cjktty_kernel_version="3.17"
reiser4_kernel_version="3.17.2"
#tuxonice_kernel_version=""
uksm_kernel_version="3.17.2"

KEYWORDS="~x86 ~amd64 ~mips"

SUPPORTED_USE="+aufs +additional +cjktty +ck +exfat +experimental +gentoo +reiser4 +thinkpad +uksm"
UNSUPPORTED_USE="imq tuxonice"

UNIPATCH_EXCLUDE=""

OVERRIDE_AUFS_PATCHES=""
OVERRIDE_CJKTTY_PATCHES=""
OVERRIDE_CK_PATCHES=""
OVERRIDE_REISER4_PATCHES=""
OVERRIDE_TUXONICE_PATCHES=""
OVERRIDE_UKSM_PATCHES=""

inherit e-sources
