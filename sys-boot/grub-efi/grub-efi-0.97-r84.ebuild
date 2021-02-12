# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# XXX: we need to review menu.lst vs grub.conf handling.  We've been converting
#      all systems to grub.conf (and symlinking menu.lst to grub.conf), but
#      we never updated any of the source code (it still all wants menu.lst),
#      and there is no indication that upstream is making the transition.

# If you need to roll a new grub-static distfile, here is how.
# - Robin H. Johnson <robbat2@gentoo.org> - 29 Nov 2010
# FEATURES='-noauto -noinfo -nodoc -noman -splitdebug nostrip' \
# USE='static -ncurses -netboot -custom-cflags' \
# PORTAGE_COMPRESS=true GRUB_STATIC_PACKAGE_BUILDING=1 ebuild \
# grub-${PVR}.ebuild clean package && \
# qtbz2 -s -j ${PKGDIR}/${CAT}/${PF}.tbz2 && \
# mv ${PF}.tar.bz2 ${DISTDIR}/grub-static-${PVR}.tar.bz2

EAPI=7

inherit eutils toolchain-funcs linux-info flag-o-matic autotools pax-utils

MY_PN=grub

MY_P=grub-${PV}

DESCRIPTION="GNU GRUB Legacy boot loader"
HOMEPAGE="http://www.gnu.org/software/grub/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz
		mirror://gentoo/splash.xpm.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

IUSE="custom-cflags"

RDEPEND=""

DEPEND="!<sys-boot/grub-2
	!sys-boot/grub-static
	sys-boot/gnu-efi"

S=${WORKDIR}/grub-${PV}

pkg_setup() {
	case $(tc-arch) in
	amd64) CONFIG_CHECK='~IA32_EMULATION' check_extra_config ;;
	esac
}

src_prepare() {
	# Grub will not handle a kernel larger than EXTENDED_MEMSIZE Mb as
	# discovered in bug 160801. We can change this, however, using larger values
	# for this variable means that Grub needs more memory to run and boot. For a
	# kernel of size N, Grub needs (N+1)*2.  Advanced users should set a custom
	# value in make.conf, it is possible to make kernels ~16Mb in size, but it
	# needs the kitchen sink built-in.
	local t="custom"
	if [[ -z ${GRUB_MAX_KERNEL_SIZE} ]] ; then
		case $(tc-arch) in
		amd64) GRUB_MAX_KERNEL_SIZE=9 ;;
		x86)   GRUB_MAX_KERNEL_SIZE=5 ;;
		esac
		t="default"
	fi
	einfo "Grub will support the ${t} maximum kernel size of ${GRUB_MAX_KERNEL_SIZE} Mb (GRUB_MAX_KERNEL_SIZE)"

	sed -i \
		-e "/^#define.*EXTENDED_MEMSIZE/s,3,${GRUB_MAX_KERNEL_SIZE},g" \
		"${S}"/grub/asmstub.c \
		|| die

	epatch "${FILESDIR}/grub-fedora-16.patch"
	epatch "${FILESDIR}/0001-Fall-back-to-old-efi-GOP-detection-behavior.patch"
	epatch "${FILESDIR}/0001-Fix-strange-compilation-problem.patch"

	eautoreconf

	sed -i 's/0\.97/0.97-84/' configure.in
}

src_configure() {
	filter-flags -fPIE #168834

	unset BLOCK_SIZE #73499

	### i686-specific code in the boot loader is a bad idea; disabling to ensure
	### at least some compatibility if the hard drive is moved to an older or
	### incompatible system.

	# grub-0.95 added -fno-stack-protector detection, to disable ssp for stage2,
	# but the objcopy's (faulty) test fails if -fstack-protector is default.
	# create a cache telling configure that objcopy is ok, and add -C to econf
	# to make use of the cache.
	#
	# CFLAGS has to be undefined running econf, else -fno-stack-protector detection fails.
	# STAGE2_CFLAGS is not allowed to be used on emake command-line, it overwrites
	# -fno-stack-protector detected by configure, removed from netboot's emake.
	use custom-cflags || CFLAGS="-O0 -g -fno-strict-aliasing -Wall -Wno-shadow -Wno-unused -Wno-pointer-sign -fno-stack-protector"

	export CFLAGS

	export grub_cv_prog_objcopy_absolute=yes #79734

	sed -i 's/LIBGNUEFI=/LIBGNUEFI=\/usr/' configure

	# Now build the regular grub
	# Note that FFS and UFS2 support are broken for now - stage1_5 files too big
	econf \
		--libdir=/lib \
		--datadir=/usr/lib/grub \
		--exec-prefix=/ \
		--disable-auto-linux-mem-opt \
		--with-platform=efi \
		--without-curses

}

src_compile() {
	emake
}

src_test() {
	# non-default block size also give false pass/fails.
	unset BLOCK_SIZE
	emake -j1 check
}

src_install() {
	insinto /usr/lib/grub/
	doins efi/grub.efi

	insinto /usr/share/grub
	doins "${DISTDIR}"/splash.xpm.gz
}

pkg_postinst() {
	elog "copy /usr/lib/grub/grub.efi to EFI partition and use efibootmgr to set boot entry for grub"
}
