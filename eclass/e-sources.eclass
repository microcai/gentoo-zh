
RESTRICT="mirror"

features() {
	if [ "${SUPPORTED_USE/$1/}" != "$SUPPORTED_USE" ];
		then return 0; else return 1;
	fi
}

if features gentoo; then
	K_GENPATCHES_VER="$gentoo_version"
	K_WANT_GENPATCHES="base extras"
fi

K_NOSETEXTRAVERSION="yes"
K_SECURITY_UNSUPPORTED="1"

ETYPE="sources"
inherit kernel-2 eutils
detect_version
detect_arch

KMV="$(get_version_component_range 1-2)"
KMSV="$(get_version_component_range 1).0"

SLOT="${KMV}"
RDEPEND=">=sys-devel/gcc-4.5"

if features gentoo; then
	HOMEPAGE="http://dev.gentoo.org/~mpagano/genpatches"
	SRC_URI="${GENPATCHES_URI}"
fi

DESCRIPTION="Full sources for the Linux kernel including: gentoo, ck, bfq and other patches"

KNOWN_FEATURES="aufs bfq cjktty ck fbcondecor gentoo imq reiser4 tuxonice uksm"

USE_ENABLE() {
	local USE=$1
	[ "${USE}" == "" ] && die "Feature not defined!"

	expr index "${KNOWN_FEATURES}" "${USE}" > /dev/null || die "${USE} is not known"
	IUSE="${IUSE} ${USE}" USE="${USE/+/}" USE="${USE/-/}"

	case ${USE} in

		aufs)		aufs_url="http://aufs.sourceforge.net"
				aufs_tarball="aufs-sources-${aufs_kernel_version}.tar.xz"
				aufs_src="http://dev.gentoo.org/~jlec/distfiles/aufs-sources-${aufs_kernel_version}.tar.xz"
				HOMEPAGE="${HOMEPAGE} ${aufs_url}"
				SRC_URI="
					${SRC_URI}
					aufs?	( ${aufs_src} )
				"
				RDEPEND="
					${RDEPEND}
					aufs?	( >=sys-fs/aufs-util-3.8 )
				"
				AUFS_PATCHES="${WORKDIR}/aufs3-base.patch ${WORKDIR}/aufs3-proc_map.patch ${WORKDIR}/aufs3-kbuild.patch ${WORKDIR}/aufs3-standalone.patch"
			;;

		bfq)		bfq_url="http://algo.ing.unimo.it/people/paolo/disk_sched"
				bfq_src="${bfq_url}/patches/${bfq_kernel_version}-v${bfq_version}/0001-block-cgroups-kconfig-build-bits-for-BFQ-v${bfq_version}-${KMV}.patch ${bfq_url}/patches/${bfq_kernel_version}-v${bfq_version}/0002-block-introduce-the-BFQ-v${bfq_version}-I-O-sched-for-${KMV}.patch"
				HOMEPAGE="${HOMEPAGE} ${bfq_url}"
				SRC_URI="
					${SRC_URI}
					bfq?	( ${bfq_src} )
				"
				BFQ_PATCHES="${DISTDIR}/0001-block-cgroups-kconfig-build-bits-for-BFQ-v${bfq_version}-${KMV}.patch:1 ${DISTDIR}/0002-block-introduce-the-BFQ-v${bfq_version}-I-O-sched-for-${KMV}.patch:1"
			;;

		cjktty)		cjktty_url="http://sourceforge.net/projects/cjktty"
				cjktty_src="${cjktty_url}/files/cjktty-for-linux-3.x/cjktty-for-${cjktty_kernel_version}.patch.xz"
				HOMEPAGE="${HOMEPAGE} ${cjktty_url}"
				SRC_URI="
					${SRC_URI}
					cjktty?	( ${cjktty_src} )
				"
				CJKTTY_PATCHES="${DISTDIR}/cjktty-for-${cjktty_kernel_version}.patch.xz:1"
			;;

		ck)		ck_url="http://ck.kolivas.org/patches"
				ck_src="${ck_url}/${KMSV}/${KMV}/${KMV}-ck${ck_version}/patch-${KMV}-ck${ck_version}.bz2"
				HOMEPAGE="${HOMEPAGE} ${ck_url}"
				SRC_URI="
					${SRC_URI}
					ck?	( ${ck_src} )
				"
				CK_PATCHES="${CK_PRE_PATCH} ${DISTDIR}/patch-${KMV}-ck${ck_version}.bz2:1 ${CK_POST_PATCH}"
			;;

		fbcondecor) 	fbcondecor_url="http://sources.gentoo.org/cgi-bin/viewvc.cgi/linux-patches/genpatches-2.6"
				fbcondecor_src="${fbcondecor_url}/trunk/${KMV}/4200_fbcondecor-${fbcondecor_version}.patch -> 4200_fbcondecor-${KMV}-${fbcondecor_version}.patch"
				HOMEPAGE="${HOMEPAGE} ${fbcondecor_url}"
				SRC_URI="
					${SRC_URI}
					fbcondecor?		( ${fbcondecor_src} )
				"
				FBCONDECOR_PATCHES="${DISTDIR}/4200_fbcondecor-${KMV}-${fbcondecor_version}.patch:1"
			;;

		imq)		imq_url="http://www.linuximq.net"
				imq_src="${imq_url}/patches/patch-imqmq-${imq_kernel_version/.0/}.diff.xz"
				HOMEPAGE="${HOMEPAGE} ${imq_url}"
				SRC_URI="
					${SRC_URI}
					imq?	( ${imq_src} )
				"
				IMQ_PATCHES="${DISTDIR}/patch-imqmq-${imq_kernel_version/.0/}.diff.xz"
			;;

		reiser4) 	reiser4_url="http://sourceforge.net/projects/reiser4"
				reiser4_src="${reiser4_url}/files/reiser4-for-linux-3.x/reiser4-for-${reiser4_kernel_version}.patch.gz"
				HOMEPAGE="${HOMEPAGE} ${reiser4_url}"
				SRC_URI="
					${SRC_URI}
					reiser4?		( ${reiser4_src} )
				"
				REISER4_PATCHES="${DISTDIR}/reiser4-for-${reiser4_kernel_version}.patch.gz:1"
			;;

		tuxonice)		tuxonice_url="http://tuxonice.net"
				if [[ "${tuxonice_kernel_version/$KMV./}" = "0" ]]
					then tuxonice_src="${tuxonice_url}/downloads/all/tuxonice-for-linux-${tuxonice_kernel_version}-${tuxonice_version//./-}.patch.bz2"
					else tuxonice_src="${tuxonice_url}/downloads/all/tuxonice-for-linux-${KMV}-${tuxonice_kernel_version/$KMV./}-${tuxonice_version//./-}.patch.bz2"
				fi
				HOMEPAGE="${HOMEPAGE} ${tuxonice_url}"
				SRC_URI="
					${SRC_URI}
					tuxonice?	( ${tuxonice_src} )
				"
				RDEPEND="
					${RDEPEND}
					tuxonice?	( >=sys-apps/tuxonice-userui-1.0 ( || ( >=sys-power/hibernate-script-2.0 sys-power/pm-utils ) ) )
				"
				if [[ "${tuxonice_kernel_version/$KMV./}" = "0" ]]
					then TUXONICE_PATCHES="${DISTDIR}/tuxonice-for-linux-${tuxonice_kernel_version}-${tuxonice_version//./-}.patch.bz2:1"
					else TUXONICE_PATCHES="${DISTDIR}/tuxonice-for-linux-${KMV}-${tuxonice_kernel_version/$KMV./}-${tuxonice_version//./-}.patch.bz2:1"
				fi
			;;

		uksm)		uksm_url="http://kerneldedup.org"
				uksm_src="${uksm_url}/download/uksm/${uksm_version}/uksm-${uksm_version}-for-v${KMV}.ge.${uksm_kernel_version/$KMV./}.patch"
				HOMEPAGE="${HOMEPAGE} ${uksm_url}"
				SRC_URI="
					${SRC_URI}
					uksm?		( ${uksm_src} )
				"
				UKSM_PATCHES="${DISTDIR}/uksm-${uksm_version}-for-v${KMV}.ge.${uksm_kernel_version/$KMV./}.patch:1"
			;;

	esac
}

for I in ${SUPPORTED_USE}; do
	USE_ENABLE "${I}"
done

UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} 4200_fbcondecor-0.9.6.patch"

PATCH_APPEND() {
	local PATCH=$1
	PATCH="${PATCH/+/}" PATCH="${PATCH/-/}"

	case ${PATCH} in
		aufs)		use aufs && UNIPATCH_LIST="${UNIPATCH_LIST} ${AUFS_PATCHES}" ;;
		bfq)		use bfq && UNIPATCH_LIST="${UNIPATCH_LIST} ${BFQ_PATCHES}" ;;
		cjktty)		use cjktty && UNIPATCH_LIST="${UNIPATCH_LIST} ${CJKTTY_PATCHES}" ;;
		ck)		use ck && UNIPATCH_LIST="${UNIPATCH_LIST} ${CK_PATCHES}" ;;
		fbcondecor)	use fbcondecor && UNIPATCH_LIST="${UNIPATCH_LIST} ${FBCONDECOR_PATCHES}" ;;
		imq)		use imq && UNIPATCH_LIST="${UNIPATCH_LIST} ${IMQ_PATCHES}" ;;
		reiser4)	use reiser4 && UNIPATCH_LIST="${UNIPATCH_LIST} ${REISER4_PATCHES}" ;;
		tuxonice)	use tuxonice && UNIPATCH_LIST="${UNIPATCH_LIST} ${TUXONICE_PATCHES}" ;;
		uksm)		use uksm && UNIPATCH_LIST="${UNIPATCH_LIST} ${UKSM_PATCHES}" ;;
	esac
}

for I in ${SUPPORTED_USE}; do
	PATCH_APPEND "${I}"
done

if features cjktty && features fbcondecor;
	then REQUIRED_USE="cjktty? ( !fbcondecor )";
fi

SRC_URI="
	${SRC_URI}
	${ARCH_URI}
	${KERNEL_URI}
"

UNIPATCH_STRICTORDER="yes"

src_unpack() {
	features aufs && use aufs && unpack ${aufs_tarball}
	kernel-2_src_unpack
	sed -i -e "s:^\(EXTRAVERSION =\).*:\1 ${EXTRAVERSION}:" Makefile
	features ck && use ck && sed -i -e 's/\(^EXTRAVERSION :=.*$\)/# \1/' "Makefile"

}

src_prepare() {
	features aufs && if use aufs; then
		cp -i "${WORKDIR}"/include/linux/aufs_type.h include/linux/aufs_type.h || die
		cp -i "${WORKDIR}"/include/uapi/linux/aufs_type.h include/uapi/linux/aufs_type.h || die
		cp -ri "${WORKDIR}"/{Documentation,fs} . || die
	fi
}