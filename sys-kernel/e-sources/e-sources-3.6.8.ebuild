# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
K_SECURITY_UNSUPPORTED="1"
K_DEBLOB_AVAILABLE="1"
ETYPE="sources"

inherit kernel-2 versionator
detect_version
detect_arch

SUB_VERSION="$(get_version_component_range 3)"
BASE_VERSION="$(get_version_component_range 1-2)"
MAIN_VERSION="$(get_version_component_range 1).0"
FULL_VERSION="${BASE_VERSION}.0"

ck_version="1"
ck_url="http://ck.kolivas.org/patches"
ck_src="${ck_url}/${MAIN_VERSION}/${BASE_VERSION}/${BASE_VERSION}-ck${ck_version}/patch-${BASE_VERSION}-ck${ck_version}.bz2"
use ck && CK_PATCHES="${DISTDIR}/patch-${BASE_VERSION}-ck${ck_version}.bz2:1"

bfq_version="v5"
bfq_url="http://algo.ing.unimo.it/people/paolo/disk_sched"
bfq_src="${bfq_url}/patches/${FULL_VERSION}-${bfq_version}/0001-block-cgroups-kconfig-build-bits-for-BFQ-${bfq_version}-${BASE_VERSION}.patch
	${bfq_url}/patches/${FULL_VERSION}-${bfq_version}/0002-block-introduce-the-BFQ-${bfq_version}-I-O-sched-for-${BASE_VERSION}.patch"
use bfq && BFQ_PATCHES="${DISTDIR}/0001-block-cgroups-kconfig-build-bits-for-BFQ-${bfq_version}-${BASE_VERSION}.patch:1
	${DISTDIR}/0002-block-introduce-the-BFQ-${bfq_version}-I-O-sched-for-${BASE_VERSION}.patch:1"

fbcondecor_version="0.9.6"
fbcondecor_url="http://dev.gentoo.org/~spock/projects/fbcondecor"
fbcondecor_src="http://sources.gentoo.org/cgi-bin/viewvc.cgi/linux-patches/genpatches-2.6/trunk/${BASE_VERSION}/4200_fbcondecor-0.9.6.patch"
use fbcondecor && FBCONDECOR_PATCHES="${DISTDIR}/4200_fbcondecor-${fbcondecor_version}.patch:1"

uksm_version="0.1.2.1"
uksm_url="http://kerneldedup.org"
uksm_src="${uksm_url}/download/uksm/${uksm_version}/uksm-${uksm_version}-for-v${BASE_VERSION}.ge.2.patch"
use uksm && UKSM_PATCHES="${DISTDIR}/uksm-${uksm_version}-for-v${BASE_VERSION}.ge.2.patch:1"

cjk_url="http://repo.or.cz/w/linux-2.6/cjktty.git"
cjk_src="${cjk_url}/patch/611e97828af5c42355c870b9c7e4137e166b7220 -> vt-fix-255-glyph-limit-prepare-for-CJK-font-support.patch
	${cjk_url}/patch/286181b3fabb5a982cf6dd55683109d2831ff97d -> vt-diable-setfont-if-we-have-cjk-font-in-kernel.patch
	${cjk_url}/patch/60b2ff855ccbcf6cbacd5e8beba0285712eb0929 -> vt-add-cjk-font-that-has-65536-chars.patch
	${cjk_url}/patch/8ff71e69d24ffa02fb8d79b4c88e292a9b9303e3 -> vt-default-to-cjk-font.patch"

reiser4_version="3.6.2"
reiser4_url="http://sourceforge.net/projects/reiser4"
reiser4_src="${reiser4_url}/files/reiser4-for-linux-3.x/reiser4-for-${reiser4_version}.patch.gz"
use reiser4 && REISER4_PATCHES="${DISTDIR}/reiser4-for-${reiser4_version}.patch.gz:1"

IUSE="+ck bfq fbcondecor reiser4 +uksm cjk"
DESCRIPTION="Full sources for the Linux kernel including: ck, bfq and other patches"
HOMEPAGE="http://www.kernel.org ${ck_url} ${bfq_url} ${fbcondecor_url} ${uksm_src} ${cjk_src}"
SRC_URI="${KERNEL_URI} ${ARCH_URI}
	ck?		( ${ck_src} )
	bfq?		( ${bfq_src} )
	fbcondecor?	( ${fbcondecor_src} )
	reiser4?	( ${reiser4_src} )
	cjk?		( ${cjk_src} )
	uksm?		( ${uksm_src} )"

KEYWORDS="~amd64 ~x86"
RDEPEND=">=sys-devel/gcc-4.5"

REQUIRED_USE="cjk? ( !fbcondecor )"

KV_FULL="${PVR}-e"
SLOT="${BASE_VERSION}"
S="${WORKDIR}/linux-${KV_FULL}"

UNIPATCH_LIST="${CK_PATCHES} ${BFQ_PATCHES} ${FBCONDECOR_PATCHES} ${REISER4_PATCHES} ${UKSM_PATCHES}"
UNIPATCH_STRICTORDER="yes"

src_unpack() {
	kernel-2_src_unpack

	# Comment out EXTRAVERSION added by CK patch:
	sed -i -e 's/\(^EXTRAVERSION :=.*$\)/# \1/' "${S}/Makefile"

	if use cjk; then
		epatch "${DISTDIR}"/vt-fix-255-glyph-limit-prepare-for-CJK-font-support.patch
		epatch "${DISTDIR}"/vt-diable-setfont-if-we-have-cjk-font-in-kernel.patch
		epatch "${DISTDIR}"/vt-add-cjk-font-that-has-65536-chars.patch
		epatch "${DISTDIR}"/vt-default-to-cjk-font.patch
	fi
}
