# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6
K_DEBLOB_AVAILABLE="1"

ck_version="2"
gentoo_version="10"
tuxonice_version="2015.10.30"
#uksm_version=""

aufs_kernel_version="4.1_p20150629"
cjktty_kernel_version="3.18.14"
reiser4_kernel_version="4.1.4"
tuxonice_kernel_version="4.1.12"
#uksm_kernel_version=""

KEYWORDS="~amd64 ~x86 ~mips"

SUPPORTED_USE="+additional +aufs +cjktty +ck +experimental +gentoo +reiser4 +thinkpad +tuxonice"
UNSUPPORTED_USE="uksm"

UNIPATCH_EXCLUDE=""

OVERRIDE_AUFS_PATCHES=""
OVERRIDE_CJKTTY_PATCHES="1"
OVERRIDE_CK_PATCHES=""
OVERRIDE_REISER4_PATCHES=""
OVERRIDE_TUXONICE_PATCHES=""
OVERRIDE_UKSM_PATCHES=""

inherit e-sources
