# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
ETYPE="sources"

ck_version="1"
bfq_version="5r1"
#uksm_version="0.1.2.1"

bfq_kernel_version="3.7.0"
#uksm_kernel_version="3.6.2"
#reiser4_kernel_version="3.6.4"

#SUPPORTED_USE="ck bfq cjk uksm reiser4" 
SUPPORTED_USE="ck bfq cjk" 
DESCRIPTION="Full sources for the Linux kernel including: ck, bfq and other patches"
KEYWORDS="~amd64 ~x86"

inherit e-sources
