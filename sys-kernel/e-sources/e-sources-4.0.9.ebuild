# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6
K_DEBLOB_AVAILABLE="1"

ck_version="1"
gentoo_version="7"
tuxonice_version="2015.06.04"
uksm_version="0.1.2.4-beta"

aufs_kernel_version="4.0_p20150518"
cjktty_kernel_version="3.18.14"
reiser4_kernel_version="4.0.4"
tuxonice_kernel_version="4.0.4"
uksm_kernel_version="4.0.0"

KEYWORDS="~amd64 ~x86 ~mips"

SUPPORTED_USE="+additional +aufs +ck +cjktty +experimental +gentoo +uksm +reiser4 +thinkpad +tuxonice"
UNSUPPORTED_USE=""

UNIPATCH_EXCLUDE=""

OVERRIDE_AUFS_PATCHES=""
OVERRIDE_CJKTTY_PATCHES="1"
OVERRIDE_CK_PATCHES=""
OVERRIDE_REISER4_PATCHES=""
OVERRIDE_TUXONICE_PATCHES=""
OVERRIDE_UKSM_PATCHES=""

inherit e-sources
