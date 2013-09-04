# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
K_DEBLOB_AVAILABLE="1"

ck_version="1"
gentoo_version="1"
optimization_version="1"
tuxonice_version="2013.09.03"
uksm_version="0.1.2.2"

aufs_kernel_version="3.10_p20130812"
cjktty_kernel_version="3.11.0"
reiser4_kernel_version="3.10.0"
tuxonice_kernel_version="3.11.0"
uksm_kernel_version="3.10.0"

KEYWORDS=""

SUPPORTED_USE="+cjktty +gentoo +optimization +tuxonice"

CK_PRE_PATCH=""
CK_POST_PATCH=""
UNIPATCH_EXCLUDE=""

OVERRIDE_CJKTTY_PATCHES="0"
OVERRIDE_CK_PATCHES="0"
OVERRIDE_FBCONDECOR_PATCHES="0"
OVERRIDE_REISER4_PATCHES="0"
OVERRIDE_TUXONICE_PATCHES="0"
OVERRIDE_UKSM_PATCHES="0"

ADDITION_PATCHES="${FILESDIR}/enable-thinkpad-hardware-mute-control.patch"

inherit e-sources
