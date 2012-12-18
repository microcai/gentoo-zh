# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
ETYPE="sources"

ck_version="1"
bfq_version="5r1"
uksm_version="0.1.2.1"
fbcondecor_version="0.9.6"

bfq_kernel_version="3.6.0"
cjktty_kernel_version="3.6.0"
uksm_kernel_version="3.6.2"
reiser4_kernel_version="3.6.4"

SUPPORTED_USE="ck bfq cjktty uksm reiser4 fbcondecor"

CK_POST_PATCH="${FILESDIR}/${PN}-3.6-post-ck-fix_kvm_boot.patch"

inherit e-sources
