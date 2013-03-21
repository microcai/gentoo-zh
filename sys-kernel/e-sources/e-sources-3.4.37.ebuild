# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
K_GENPATCHES_VER="19"

ck_version="3"
bfq_version="6"
uksm_version="0.1.2.2"
fbcondecor_version="0.9.6"

bfq_kernel_version="3.4.0"
cjktty_kernel_version="3.4.0"
imq_kernel_version="3.3.0"
uksm_kernel_version="3.4.36"

SUPPORTED_USE="+ck +bfq +imq +uksm +fbcondecor"

CK_PRE_PATCH="${FILESDIR}/${PN}-3.4-pre-ck-fix_task_group.patch"
CK_POST_PATCH="${FILESDIR}/${PN}-3.4-post-ck-fix_task_group.patch ${FILESDIR}/${PN}-3.4-post-ck-fix_calc_load_idle.patch"

inherit e-sources
