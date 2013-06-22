# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Author stlifey <stlifey@gmail.com>
# $Header: $
#
# e-sources.eclass - Eclass for building sys-kernel/e-sources-* packages , provide patchests including :
#
#	aufs - Advanced multi layered unification filesystem
#	cjktty - CJK tty font support
#	ck - Con Kolivas' high performance patchset
#	gentoo - genpatches
#	imq - intermediate queueing device
#	optimization - more optimized gcc options for additional CPUs
#	reiser4 - Reiser4 file system
#	tuxonice - another linux hibernate kernel patchset
#	uksm - ultra kernel samepage merging
#

features() { if [ "${SUPPORTED_USE/$1/}" != "$SUPPORTED_USE" ]; then return 0; else return 1; fi }

if features gentoo; then
	K_GENPATCHES_VER="$gentoo_version"
	K_WANT_GENPATCHES="base extras"
fi

K_NOSETEXTRAVERSION="yes"
K_SECURITY_UNSUPPORTED="1"

ETYPE="sources"
inherit kernel-2

KMV="$(get_version_component_range 1-2)"
KMSV="$(get_version_component_range 1).0"

SLOT="${KMV}"
RDEPEND=">=sys-devel/gcc-4.8"

if features gentoo; then
	HOMEPAGE="http://dev.gentoo.org/~mpagano/genpatches"
	SRC_URI="${GENPATCHES_URI}"
fi

DESCRIPTION="Full sources for the Linux kernel including: gentoo, ck and other patches"

USE_ENABLE() {
	local USE=$1
	if [ "${USE/\*/}" != "$USE" ];
		then USE="";
	fi
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
				if [ "${OVERRIDE_AUFS_PATCHES}" != "" ]; then
					AUFS_PATCHES="${OVERRIDE_AUFS_PATCHES}"
				else
					SRC_URI="
						${SRC_URI}
						aufs?	( ${aufs_src} )
					"
					AUFS_PATCHES="
						${WORKDIR}/aufs3-base.patch
						${WORKDIR}/aufs3-proc_map.patch
						${WORKDIR}/aufs3-kbuild.patch
						${WORKDIR}/aufs3-standalone.patch
					"
				fi
			;;

		cjktty)		cjktty_url="http://sourceforge.net/projects/cjktty"
				cjktty_src="${cjktty_url}/files/cjktty-for-linux-3.x/cjktty-for-${cjktty_kernel_version}.patch.xz"
				HOMEPAGE="${HOMEPAGE} ${cjktty_url}"
				if [ "${OVERRIDE_CJKTTY_PATCHES}" != "" ]; then
					CJKTTY_PATCHES="${OVERRIDE_CJKTTY_PATCHES}"
				else
					SRC_URI="
						${SRC_URI}
						cjktty?	( ${cjktty_src} )
					"
					CJKTTY_PATCHES="${DISTDIR}/cjktty-for-${cjktty_kernel_version}.patch.xz:1"
				fi
			;;

		ck)		ck_url="http://ck.kolivas.org/patches"
				ck_src="${ck_url}/${KMSV}/${KMV}/${KMV}-ck${ck_version}/patch-${KMV}-ck${ck_version}.bz2"
				HOMEPAGE="${HOMEPAGE} ${ck_url}"
				if [ "${OVERRIDE_CK_PATCHES}" != "" ]; then
					CK_PATCHES="${OVERRIDE_CK_PATCHES}"
				else
					SRC_URI="
						${SRC_URI}
						ck?	( ${ck_src} )
					"
					CK_PATCHES="${CK_PRE_PATCH} ${DISTDIR}/patch-${KMV}-ck${ck_version}.bz2:1 ${CK_POST_PATCH}"
				fi
			;;

		imq)		imq_url="http://www.linuximq.net"
				imq_src="${imq_url}/patches/patch-imqmq-${imq_kernel_version/.0/}.diff.xz"
				HOMEPAGE="${HOMEPAGE} ${imq_url}"
				if [ "${OVERRIDE_IMQ_PATCHES}" != "" ]; then
					IMQ_PATCHES="${OVERRIDE_IMQ_PATCHES}"
				else
					SRC_URI="
						${SRC_URI}
						imq?	( ${imq_src} )
					"
					IMQ_PATCHES="${DISTDIR}/patch-imqmq-${imq_kernel_version/.0/}.diff.xz"
				fi
			;;

		optimization)	optimization_url="https://raw.github.com/graysky2/kernel_gcc_patch"
				optimization_src="${optimization_url}/master/kernel-${KMV/./}-gcc48-${optimization_version}.patch"
				HOMEPAGE="${HOMEPAGE} ${optimization_url}"
				if [ "${OVERRIDE_OPTIMIZATION_PATCHES}" != "" ]; then
					OPTIMIZATION_PATCHES="${OVERRIDE_OPTIMIZATION_PATCHES}"
				else
					SRC_URI="
						${SRC_URI}
						optimization?		( ${optimization_src} )
					"
					OPTIMIZATION_PATCHES="${DISTDIR}/kernel-${KMV/./}-gcc48-${optimization_version}.patch"
				fi
			;;

		reiser4) 	reiser4_url="http://sourceforge.net/projects/reiser4"
				reiser4_src="${reiser4_url}/files/reiser4-for-linux-3.x/reiser4-for-${reiser4_kernel_version}.patch.gz"
				HOMEPAGE="${HOMEPAGE} ${reiser4_url}"
				if [ "${OVERRIDE_REISER4_PATCHES}" != "" ]; then
					REISER4_PATCHES="${OVERRIDE_REISER4_PATCHES}"
				else
					SRC_URI="
						${SRC_URI}
						reiser4?		( ${reiser4_src} )
					"
					REISER4_PATCHES="${DISTDIR}/reiser4-for-${reiser4_kernel_version}.patch.gz:1"
				fi
			;;

		tuxonice)	tuxonice_url="http://tuxonice.net"
				if [[ "${tuxonice_kernel_version/$KMV./}" = "0" ]]
					then tuxonice_src="${tuxonice_url}/downloads/all/tuxonice-for-linux-${tuxonice_kernel_version}-${tuxonice_version//./-}.patch.bz2"
					else tuxonice_src="${tuxonice_url}/downloads/all/tuxonice-for-linux-${KMV}-${tuxonice_kernel_version/$KMV./}-${tuxonice_version//./-}.patch.bz2"
				fi
				HOMEPAGE="${HOMEPAGE} ${tuxonice_url}"
				RDEPEND="
					${RDEPEND}
					tuxonice?	( >=sys-apps/tuxonice-userui-1.0 ( || ( >=sys-power/hibernate-script-2.0 sys-power/pm-utils ) ) )
				"
				if [ "${OVERRIDE_TUXONICE_PATCHES}" != "" ]; then
					TUXONICE_PATCHES="${OVERRIDE_TUXONICE_PATCHES}"
				else
					SRC_URI="
						${SRC_URI}
						tuxonice?	( ${tuxonice_src} )
					"
					if [[ "${tuxonice_kernel_version/$KMV./}" = "0" ]]
						then TUXONICE_PATCHES="${DISTDIR}/tuxonice-for-linux-${tuxonice_kernel_version}-${tuxonice_version//./-}.patch.bz2:1"
						else TUXONICE_PATCHES="${DISTDIR}/tuxonice-for-linux-${KMV}-${tuxonice_kernel_version/$KMV./}-${tuxonice_version//./-}.patch.bz2:1"
					fi
				fi
			;;

		uksm)		uksm_url="http://kerneldedup.org"
				uksm_src="${uksm_url}/download/uksm/${uksm_version}/uksm-${uksm_version}-for-v${KMV}.ge.${uksm_kernel_version/$KMV./}.patch"
				HOMEPAGE="${HOMEPAGE} ${uksm_url}"
				if [ "${OVERRIDE_UKSM_PATCHES}" != "" ]; then
					UKSM_PATCHES="${OVERRIDE_UKSM_PATCHES}";
				else
					SRC_URI="
						${SRC_URI}
						uksm?		( ${uksm_src} )
					"
					UKSM_PATCHES="${DISTDIR}/uksm-${uksm_version}-for-v${KMV}.ge.${uksm_kernel_version/$KMV./}.patch:1"
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
		imq)		use imq && UNIPATCH_LIST="${UNIPATCH_LIST} ${IMQ_PATCHES}" ;;
		optimization)	use optimization && UNIPATCH_LIST="${UNIPATCH_LIST} ${OPTIMIZATION_PATCHES}" ;;
		reiser4)	use reiser4 && UNIPATCH_LIST="${UNIPATCH_LIST} ${REISER4_PATCHES}" ;;
		tuxonice)	use tuxonice && UNIPATCH_LIST="${UNIPATCH_LIST} ${TUXONICE_PATCHES}" ;;
		uksm)		use uksm && UNIPATCH_LIST="${UNIPATCH_LIST} ${UKSM_PATCHES}" ;;
	esac
}

for I in ${SUPPORTED_USE}; do
	PATCH_APPEND "${I}"
done

UNIPATCH_LIST="${UNIPATCH_LIST} ${ADDITION_PATCHES}"

features cjktty && use cjktty && UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} 4200_fbcondecor-0.9.6.patch"

SRC_URI="
	${SRC_URI}
	${ARCH_URI}
	${KERNEL_URI}
"

UNIPATCH_STRICTORDER="yes"

src_unpack() {
	features aufs && use aufs && unpack ${aufs_tarball}
	kernel-2_src_unpack
}

src_prepare() {
	sed -i -e "s:^\(EXTRAVERSION =\).*: \1 ${EXTRAVERSION}:" "Makefile"
	features ck && use ck && sed -i -e 's/\(^EXTRAVERSION :=.*$\)/# \1/' "Makefile"

	features aufs && if use aufs; then
		cp -i "${WORKDIR}"/include/linux/aufs_type.h include/linux/aufs_type.h || die
		cp -i "${WORKDIR}"/include/uapi/linux/aufs_type.h include/uapi/linux/aufs_type.h || die
		cp -ri "${WORKDIR}"/{Documentation,fs} . || die
	fi

	rm -rf {a,b,Documentation/*,drivers/video/logo/*}
	touch {{Documentation,drivers/video/logo}/Makefile,drivers/video/logo/Kconfig}
}
