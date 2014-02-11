# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
K_DEBLOB_AVAILABLE="1"

ck_version=""
gentoo_version="5"
tuxonice_version=""
uksm_version="0.1.2.2"

aufs_kernel_version="3.13_p20140127"
cjktty_kernel_version="3.11.0"
reiser4_kernel_version="3.13.1"
tuxonice_kernel_version=""
uksm_kernel_version="3.13.0"

KEYWORDS="~amd64 ~x86 ~mips"

SUPPORTED_USE="+additional +aufs +cjktty +exfat +experimental +gentoo +reiser4 +thinkpad +uksm"
UNSUPPORTED_USE="ck imq tuxonice"

UNIPATCH_EXCLUDE=""

OVERRIDE_AUFS_PATCHES=""
OVERRIDE_CJKTTY_PATCHES=""
OVERRIDE_CK_PATCHES=""
OVERRIDE_REISER4_PATCHES=""
OVERRIDE_TUXONICE_PATCHES=""
OVERRIDE_UKSM_PATCHES=""

inherit e-sources
