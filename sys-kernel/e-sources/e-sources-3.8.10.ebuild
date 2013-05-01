# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
K_DEBLOB_AVAILABLE="1"

aufs_version="2013.04.01"
bfq_version="6"
ck_version="1"
fbcondecor_version="0.9.6"
gentoo_version="13"
tuxonice_version="2013.04.24"
uksm_version="0.1.2.2"

# aufs_kernel_version=""
bfq_kernel_version="3.8.0"
cjktty_kernel_version="3.8.1"
imq_kernel_version="3.8.0"
reiser4_kernel_version="3.8.5"
tuxonice_kernel_version="3.8.8"
uksm_kernel_version="3.8.3"

KEYWORDS="~amd64 ~x86"

# KNOWN_FEATURES="aufs bfq cjktty ck fbcondecor gentoo imq reiser4 tuxonice uksm"
SUPPORTED_USE="+aufs +bfq cjktty +ck +fbcondecor +gentoo +imq +reiser4 +tuxonice +uksm"

inherit e-sources
