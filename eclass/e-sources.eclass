# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Author stlifey <stlifey@gmail.com>
# $Header: $
#
# e-sources.eclass - Eclass for building sys-kernel/e-sources-* packages , provide patches including :
#
#	additional	- misc kernel patch
#	aufs		- advanced multi layered unification filesystem
#	cjktty		- cjk font support for tty
#	ck		- con kolivas's high performance patchset
#	gentoo		- gentoo linux kernel patches called genpatches
#	reiser4		- reiser4 filesystem support
#	thinkpad	- a set of lenovo thinkpad patches
#	tuxonice	- tuxonice support - another linux hibernate system
#	uksm		- ultra kernel samepage merging support
#

features() {
	if [ "${SUPPORTED_USE/$1/}" != "$SUPPORTED_USE" ]; then
	return 0; else return 1; fi
}

enable() { if features $1 && use $1; then return 0; else return 1; fi }

if features gentoo; then
	K_GENPATCHES_VER="$gentoo_version"
	K_WANT_GENPATCHES="base extras experimental"
else
	SUPPORTED_USE="${SUPPORTED_USE/?experimental/}"
fi

ETYPE="sources"
inherit kernel-2 versionator

K_SECURITY_UNSUPPORTED="1"

KMV="$(get_version_component_range 1-2)"
KMMV="$(get_version_component_range 1)"
KMSV="$(get_version_component_range 1).0"

SLOT="${KMV}"

features optimization && \
RDEPEND="optimization? ( >=sys-devel/gcc-4.8 )"

if features gentoo; then
	HOMEPAGE="http://dev.gentoo.org/~mpagano/genpatches"
	SRC_URI="${GENPATCHES_URI}"
fi

DESCRIPTION="Full sources for the Linux kernel including: gentoo, ck and other patches"

USE_ENABLE() {
	local USE=$1
	IUSE="${IUSE} ${USE}" USE="${USE/+/}" USE="${USE/-/}"

	case ${USE} in

		aufs)		aufs_url="http://aufs.sourceforge.net"
				aufs_tarball="aufs-sources-${aufs_kernel_version}.tar.xz"
				aufs_src="http://dev.gentoo.org/~jlec/distfiles/aufs-sources-${aufs_kernel_version}.tar.xz"
				HOMEPAGE="${HOMEPAGE} ${aufs_url}"
				RDEPEND="
					${RDEPEND}
					aufs?	( >=sys-fs/aufs-util-3.8 )
				"
				SRC_URI="
					${SRC_URI}
					aufs?	( ${aufs_src} )
				"
				if [ "${OVERRIDE_AUFS_PATCHES}" = 1 ]; then
					AUFS_PATCHES="
						${FILESDIR}/${KMV}/aufs/aufs${KMMV}-kbuild.patch
						${FILESDIR}/${KMV}/aufs/aufs${KMMV}-base.patch
						${FILESDIR}/${KMV}/aufs/aufs${KMMV}-mmap.patch
						${FILESDIR}/${KMV}/aufs/aufs${KMMV}-standalone.patch
					"
				else
					AUFS_PATCHES="
						${WORKDIR}/aufs${KMMV}-kbuild.patch
						${WORKDIR}/aufs${KMMV}-base.patch
						${WORKDIR}/aufs${KMMV}-mmap.patch
						${WORKDIR}/aufs${KMMV}-standalone.patch
					"
				fi
			;;

		cjktty)		cjktty_url="http://sourceforge.net/projects/cjktty"
				CJKKMV="$(get_version_component_range 1-2 $cjktty_kernel_version)"
				if [[ "${cjktty_kernel_version/$CJKKMV./}" = "0" ]]
					then cjktty_patch="${CJKKMV}-utf8.diff"
					else cjktty_patch="${cjktty_kernel_version}-utf8.diff"
				fi
				cjktty_src="https://github.com/gentoo-zh/linux-cjktty/compare/${cjktty_patch}"
				HOMEPAGE="${HOMEPAGE} ${cjktty_url}"
				if [ "${OVERRIDE_CJKTTY_PATCHES}" = 1 ]; then
					CJKTTY_PATCHES="${FILESDIR}/${KMV}/${cjktty_patch}:1"
				else
					SRC_URI="
						${SRC_URI}
						cjktty?	( ${cjktty_src} )
					"
					CJKTTY_PATCHES="${DISTDIR}/${cjktty_patch}:1"
				fi
			;;

		ck)		ck_url="http://ck.kolivas.org/patches"
				ck_patch="${KMV}-ck${ck_version}-broken-out.tar.bz2"
				ck_src="${ck_url}/${KMSV}/${KMV}/${KMV}-ck${ck_version}/${ck_patch}"
				HOMEPAGE="${HOMEPAGE} ${ck_url}"
				if [ "${OVERRIDE_CK_PATCHES}" = 1 ]; then
					CK_PATCHES="${FILESDIR}/${KMV}/${ck_patch}"
				else
					SRC_URI="
						${SRC_URI}
						ck?	( ${ck_src} )
					"
					CK_PATCHES="${DISTDIR}/${ck_patch}"
				fi
			;;


		reiser4) 	reiser4_url="http://sourceforge.net/projects/reiser4"
				reiser4_patch="reiser4-for-${reiser4_kernel_version%.0}.patch.gz"
				reiser4_src="${reiser4_url}/files/reiser4-for-linux-${KMMV}.x/${reiser4_patch}"
				HOMEPAGE="${HOMEPAGE} ${reiser4_url}"
				if [ "${OVERRIDE_REISER4_PATCHES}" = 1 ]; then
					REISER4_PATCHES="${FILESDIR}/${KMV}/${reiser4_patch}:1"
				else
					SRC_URI="
						${SRC_URI}
						reiser4?		( ${reiser4_src} )
					"
					REISER4_PATCHES="${DISTDIR}/${reiser4_patch}:1"
				fi
			;;

		tuxonice)	tuxonice_url="http://tuxonice.net"
				ICEKMV="$(get_version_component_range 1-2 $tuxonice_kernel_version)"
				if [[ "${tuxonice_kernel_version/$ICEKMV./}" = "0" ]]
					then tuxonice_patch="tuxonice-for-linux-head-${tuxonice_kernel_version}-${tuxonice_version//./-}.patch.bz2"
					else tuxonice_patch="tuxonice-for-linux-${tuxonice_kernel_version}-${tuxonice_version//./-}.patch.bz2"
				fi
				tuxonice_src="${tuxonice_url}/downloads/all/${tuxonice_patch}"
				HOMEPAGE="${HOMEPAGE} ${tuxonice_url}"
				RDEPEND="
					${RDEPEND}
					tuxonice?	( >=sys-apps/tuxonice-userui-1.0 ( || ( >=sys-power/hibernate-script-2.0 sys-power/pm-utils ) ) )
				"
				if [ "${OVERRIDE_TUXONICE_PATCHES}" = 1 ]; then
					TUXONICE_PATCHES="${FILESDIR}/${KMV}/${tuxonice_patch}:1"
				else
					SRC_URI="
						${SRC_URI}
						tuxonice?	( ${tuxonice_src} )
					"
					TUXONICE_PATCHES="${DISTDIR}/${tuxonice_patch}:1"
				fi
			;;

		uksm)		uksm_url="http://kerneldedup.org"
				UKSMKMV=${uksm_kernel_version:0:4}
				UKSMKMV="$(get_version_component_range 1-2 $uksm_kernel_version)"
				if [[ "${uksm_kernel_version/$UKSMKMV./}" = "0" ]]
					then
						if [[ $uksm_version == *beta* ]]
							then uksm_patch="uksm-${uksm_version}-for-linux-v${UKSMKMV}.patch"
							else uksm_patch="uksm-${uksm_version}-for-v${UKSMKMV}.patch"
						fi
					else uksm_patch="uksm-${uksm_version}-for-v${UKSMKMV}.ge.${uksm_kernel_version/$UKSMKMV./}.patch"
				fi
				if [[ $uksm_version == *beta* ]]
					then uksm_src="${uksm_url}/download/uksm/beta/${uksm_patch}"
					else uksm_src="${uksm_url}/download/uksm/${uksm_version}/${uksm_patch}"
				fi
				HOMEPAGE="${HOMEPAGE} ${uksm_url}"
				if [ "${OVERRIDE_UKSM_PATCHES}" = 1 ]; then
					UKSM_PATCHES="${FILESDIR}/${KMV}/${uksm_patch}:1"
				else
					SRC_URI="
						${SRC_URI}
						uksm?		( ${uksm_src} )
					"
					UKSM_PATCHES="${DISTDIR}/${uksm_patch}:1"
				fi
			;;

	esac
}

for I in ${SUPPORTED_USE}; do
	USE_ENABLE "${I}"
done

PATCH_APPEND() {
	local PATCH=$1
	PATCH="${PATCH/+/}" PATCH="${PATCH/-/}"

	case ${PATCH} in
		aufs)		use aufs && UNIPATCH_LIST="${UNIPATCH_LIST} ${AUFS_PATCHES}" ;;
		cjktty)		use cjktty && UNIPATCH_LIST="${UNIPATCH_LIST} ${CJKTTY_PATCHES}" ;;
		ck)		use ck && UNIPATCH_LIST="${UNIPATCH_LIST} ${CK_PATCHES}" ;;
		reiser4)	use reiser4 && UNIPATCH_LIST="${UNIPATCH_LIST} ${REISER4_PATCHES}" ;;
		tuxonice)	use tuxonice && UNIPATCH_LIST="${UNIPATCH_LIST} ${TUXONICE_PATCHES}" ;;
		uksm)		use uksm && UNIPATCH_LIST="${UNIPATCH_LIST} ${UKSM_PATCHES}" ;;
	esac
}

for I in ${SUPPORTED_USE}; do
	PATCH_APPEND "${I}"
done

features gentoo && REQUIRED_USE=" experimental? ( gentoo ) "

enable cjktty && UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} *fbcondecor*"

SRC_URI="
	${SRC_URI}
	${ARCH_URI}
	${KERNEL_URI}
"

UNIPATCH_STRICTORDER="yes"

src_unpack() {
	enable aufs && unpack ${aufs_tarball}
	kernel-2_src_unpack

	local patch
	for patch in additional ck thinkpad tuxonice ; do
	if enable ${patch}; then
		EPATCH_SOURCE="${FILESDIR}/${KMV}/${patch}" EPATCH_FORCE="yes"  \
		EPATCH_SUFFIX="diff" epatch
		EPATCH_SOURCE="${FILESDIR}/${KMV}/${patch}" EPATCH_FORCE="yes"  \
		EPATCH_SUFFIX="patch" epatch
	fi
	done
}

src_prepare() {
	enable ck && sed -i -e 's/\(^EXTRAVERSION :=.*$\)/# \1/' "Makefile"

	if enable aufs; then
		cp -f "${WORKDIR}"/include/uapi/linux/aufs_type.h include/uapi/linux/aufs_type.h || die
		cp -rf "${WORKDIR}"/{Documentation,fs} . || die
	fi
}
