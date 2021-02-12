# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
K_DEBLOB_AVAILABLE="1"

ck_version="1"
gentoo_version="16"
tuxonice_version="2015.05.11"
uksm_version="0.1.2.3"

aufs_kernel_version="3.18.1+_p20150518"
cjktty_kernel_version="3.18.14"
reiser4_kernel_version="3.18.6"
tuxonice_kernel_version="3.18.13"
uksm_kernel_version="3.18.0"

KEYWORDS="x86 amd64 mips"

SUPPORTED_USE="+additional +aufs +cjktty +ck +experimental +gentoo +uksm +reiser4 +thinkpad +tuxonice"
UNSUPPORTED_USE=""

UNIPATCH_EXCLUDE=""

OVERRIDE_AUFS_PATCHES=""
OVERRIDE_CJKTTY_PATCHES="1"
OVERRIDE_CK_PATCHES=""
OVERRIDE_REISER4_PATCHES=""
OVERRIDE_TUXONICE_PATCHES=""
OVERRIDE_UKSM_PATCHES=""

inherit e-sources
