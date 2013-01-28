# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
ETYPE="sources"

ck_version="1"
bfq_version="5r1"
uksm_version="0.1.2.2"
fbcondecor_version="0.9.6"

bfq_kernel_version="3.7.0"
cjktty_kernel_version="3.5.0"
imq_kernel_version="3.7.0"
uksm_kernel_version="3.7.1"
reiser4_kernel_version="3.7.1"

SUPPORTED_USE="ck bfq imq cjktty reiser4 uksm fbcondecor"

inherit e-sources
