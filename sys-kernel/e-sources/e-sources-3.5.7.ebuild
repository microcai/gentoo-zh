# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
ETYPE="sources"

ck_version="1"
bfq_version="5r1"
uksm_version="0.1.2.2"
fbcondecor_version="0.9.6"

bfq_kernel_version="3.5.0"
cjktty_kernel_version="3.5.0"
imq_kernel_version="3.5.0"
uksm_kernel_version="3.5.7"
reiser4_kernel_version="3.5.3"

SUPPORTED_USE="ck bfq cjktty imq reiser4 uksm fbcondecor"

CK_PRE_PATCH="${FILESDIR}/${PN}-3.4-3.5-pre-ck-fix_task_group.patch"
CK_POST_PATCH="${FILESDIR}/${PN}-3.4-3.5-post-ck-fix_task_group.patch"

inherit e-sources
