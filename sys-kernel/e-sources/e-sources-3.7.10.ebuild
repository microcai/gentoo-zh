# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
K_GENPATCHES_VER="13"

ck_version="1"
bfq_version="6"
ice_version="2013.02.20"
uksm_version="0.1.2.2"
fbcondecor_version="0.9.6"

bfq_kernel_version="3.7.0"
cjktty_kernel_version="3.7.0"
ice_kernel_version="3.7.9"
imq_kernel_version="3.7.0"
uksm_kernel_version="3.7.10"
reiser4_kernel_version="3.7.1"

SUPPORTED_USE="+ck +bfq +ice imq +cjktty reiser4 +uksm fbcondecor"

CK_POST_PATCH="${FILESDIR}/${PN}-3.7-post-bfs426-427.patch"

inherit e-sources
