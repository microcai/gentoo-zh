# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
K_DEBLOB_AVAILABLE="1"

ck_version="1"
gentoo_version="13"
tuxonice_version="2015.02.14"
uksm_version="0.1.2.3"

aufs_kernel_version="3.18.1+_p20150406"
cjktty_kernel_version="3.18"
reiser4_kernel_version="3.18.6"
tuxonice_kernel_version="3.18.7"
uksm_kernel_version="3.18.0"

KEYWORDS="~x86 ~amd64 ~mips"

SUPPORTED_USE="+aufs +additional +cjktty +ck +exfat +experimental +gentoo +reiser4 +thinkpad +tuxonice +uksm"
UNSUPPORTED_USE="imq"

UNIPATCH_EXCLUDE=""

OVERRIDE_AUFS_PATCHES=""
OVERRIDE_CJKTTY_PATCHES=""
OVERRIDE_CK_PATCHES=""
OVERRIDE_REISER4_PATCHES=""
OVERRIDE_TUXONICE_PATCHES=""
OVERRIDE_UKSM_PATCHES=""

inherit e-sources
