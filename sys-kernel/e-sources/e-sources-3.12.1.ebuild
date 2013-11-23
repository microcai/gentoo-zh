# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
K_DEBLOB_AVAILABLE="1"

ck_version="1"
gentoo_version="2"
optimization_version="1"
tuxonice_version="2013.11.22"
uksm_version="0.1.2.2"

aufs_kernel_version="3.12_p20131111"
cjktty_kernel_version="3.11.0"
imq_kernel_version="3.11.0"
reiser4_kernel_version="3.11.1"
tuxonice_kernel_version="3.12.1"
uksm_kernel_version="3.12.0"

KEYWORDS=""

SUPPORTED_USE="+additional +aufs +ck +experimental +gentoo +optimization +tuxonice +uksm +cjktty +imq"
UNSUPPORTED_USE="+reiser4"

UNIPATCH_EXCLUDE=""

OVERRIDE_CJKTTY_PATCHES=""
OVERRIDE_CK_PATCHES=""
OVERRIDE_IMQ_PATCHES="1"
OVERRIDE_REISER4_PATCHES=""
OVERRIDE_TUXONICE_PATCHES=""
OVERRIDE_UKSM_PATCHES=""

inherit e-sources
