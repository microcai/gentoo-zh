# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
K_DEBLOB_AVAILABLE="1"

#ck_version=""
gentoo_version="5"
#tuxonice_version=""
#uksm_version=""

aufs_kernel_version="4.1_p20150629"
cjktty_kernel_version="3.18.14"
#reiser4_kernel_version=""
#tuxonice_kernel_version=""
#uksm_kernel_version=""

KEYWORDS="~amd64 ~x86 ~mips"

SUPPORTED_USE="+additional +aufs +cjktty +experimental +gentoo +thinkpad"
UNSUPPORTED_USE="ck reiser4 tuxonice uksm"

UNIPATCH_EXCLUDE=""

OVERRIDE_AUFS_PATCHES=""
OVERRIDE_CJKTTY_PATCHES="1"
OVERRIDE_CK_PATCHES=""
OVERRIDE_REISER4_PATCHES=""
OVERRIDE_TUXONICE_PATCHES=""
OVERRIDE_UKSM_PATCHES=""

inherit e-sources
