# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
K_DEBLOB_AVAILABLE="1"

# aufs_version=""
bfq_version="6"
ck_version="1"
fbcondecor_version="0.9.6"
gentoo_version="13"
tuxonice_version="2013.02.20"
uksm_version="0.1.2.2"

aufs_kernel_version="3.7.10"
bfq_kernel_version="3.7.0"
cjktty_kernel_version="3.7.0"
imq_kernel_version="3.7.0"
reiser4_kernel_version="3.7.1"
tuxonice_kernel_version="3.7.9"
uksm_kernel_version="3.7.10"

KEYWORDS="~amd64 ~x86"

# KNOWN_FEATURES="aufs bfq cjktty ck fbcondecor gentoo imq reiser4 tuxonice uksm"
SUPPORTED_USE="+aufs +bfq cjktty +ck +fbcondecor +gentoo +imq +reiser4 +tuxonice +uksm"

CK_POST_PATCH="${FILESDIR}/${PN}-3.7-bfs426-427.patch"

inherit e-sources
