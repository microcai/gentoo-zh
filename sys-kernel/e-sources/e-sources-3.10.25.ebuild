# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
K_DEBLOB_AVAILABLE="1"

ck_version="1"
gentoo_version="32"
optimization_version="2"
tuxonice_version="2013.12.09"
uksm_version="0.1.2.2"

aufs_kernel_version="3.10_p20131111"
cjktty_kernel_version="3.8.1"
reiser4_kernel_version="3.10.0"
tuxonice_kernel_version="3.10.23"
uksm_kernel_version="3.10.0"

KEYWORDS="~amd64 ~x86 ~mips"

SUPPORTED_USE="+additional +aufs +cjktty +ck +experimental +gentoo +optimization +reiser4 +tuxonice +uksm"
UNSUPPORTED_USE=""

UNIPATCH_EXCLUDE=""

OVERRIDE_CJKTTY_PATCHES=""
OVERRIDE_CK_PATCHES=""
OVERRIDE_REISER4_PATCHES=""
OVERRIDE_TUXONICE_PATCHES=""
OVERRIDE_UKSM_PATCHES=""

inherit e-sources
