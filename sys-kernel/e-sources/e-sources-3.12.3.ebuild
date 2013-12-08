# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
K_DEBLOB_AVAILABLE="1"

ck_version="2"
gentoo_version="4"
optimization_version="1"
tuxonice_version="2013.12.05"
uksm_version="0.1.2.2"

aufs_kernel_version="3.12_p20131111"
cjktty_kernel_version="3.11.0"
reiser4_kernel_version="3.12.0"
tuxonice_kernel_version="3.12.3"
uksm_kernel_version="3.12.0"

KEYWORDS="~amd64 ~x86"

SUPPORTED_USE="+ck +additional +aufs +cjktty +experimental +gentoo +optimization +reiser4 +tuxonice +uksm"
UNSUPPORTED_USE=""

UNIPATCH_EXCLUDE=""

OVERRIDE_CJKTTY_PATCHES=""
OVERRIDE_CK_PATCHES=""
OVERRIDE_REISER4_PATCHES="1"
OVERRIDE_TUXONICE_PATCHES=""
OVERRIDE_UKSM_PATCHES=""

inherit e-sources
