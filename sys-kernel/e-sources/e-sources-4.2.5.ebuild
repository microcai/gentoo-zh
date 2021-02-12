# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6
K_DEBLOB_AVAILABLE="1"

ck_version=""
gentoo_version="8"
tuxonice_version="2015.10.30"
#uksm_version=""

aufs_kernel_version="4.2_p20151012"
cjktty_kernel_version="4.2"
reiser4_kernel_version="4.2.2"
tuxonice_kernel_version="4.2.5"
#uksm_kernel_version=""

KEYWORDS="~amd64 ~x86 ~mips"

SUPPORTED_USE="+additional +aufs +cjktty +experimental +gentoo +reiser4 +thinkpad +tuxonice"
UNSUPPORTED_USE="ck uksm"

UNIPATCH_EXCLUDE=""

OVERRIDE_AUFS_PATCHES=""
OVERRIDE_CJKTTY_PATCHES=""
OVERRIDE_CK_PATCHES=""
OVERRIDE_REISER4_PATCHES=""
OVERRIDE_TUXONICE_PATCHES=""
OVERRIDE_UKSM_PATCHES=""

inherit e-sources
