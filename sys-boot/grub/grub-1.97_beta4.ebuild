# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit mount-boot eutils flag-o-matic toolchain-funcs versionator

if [[ ${PV} == "9999" ]] ; then
	ESVN_REPO_URI="svn://svn.sv.gnu.org/grub/trunk/grub2"
	inherit subversion
	SRC_URI=""
else
	MY_P=${PN}-$(replace_version_separator 2 '~')
	SRC_URI="ftp://alpha.gnu.org/gnu/${PN}/${MY_P}.tar.gz"
	S=${WORKDIR}/${MY_P}
fi

DESCRIPTION="GNU GRUB 2 boot loader"
HOMEPAGE="http://www.gnu.org/software/grub/"

LICENSE="GPL-3"
SLOT="2"
KEYWORDS=""
IUSE="custom-cflags debug multislot static"

RDEPEND=">=sys-libs/ncurses-5.2-r5
	dev-libs/lzo"
DEPEND="${RDEPEND}
	dev-lang/ruby"
PROVIDE="virtual/bootloader"

export STRIP_MASK="*/grub/*/*.mod"
QA_EXECSTACK="
	bin/grub-fstest
	sbin/grub-emu
	sbin/grub-mkdevicemap
	sbin/grub-probe
	sbin/grub-setup"

src_unpack() {
	if [[ ${PV} == "9999" ]] ; then
		subversion_src_unpack
	else
		unpack ${A}
	fi
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.97-genkernel.patch #256335
}

src_compile() {
	use custom-cflags || unset CFLAGS CPPFLAGS LDFLAGS
	use static && append-ldflags -static

	econf \
		--sbindir=/sbin \
		--bindir=/bin \
		--libdir=/$(get_libdir) \
		--disable-efiemu \
		--disable-grub-pe2elf \
		--enable-grub-mkfont \
		$(use_enable debug mm-debug) \
		$(use_enable debug grub-emu) \
		$(use_enable debug grub-emu-usb) \
		$(use_enable debug grub-fstest)
	emake -j1 || die "making regular stuff"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	cat <<-EOF >> "${D}"/lib*/grub/grub-mkconfig_lib
	GRUB_DISTRIBUTOR="Gentoo"
	EOF
	if use multislot ; then
		sed -i s:grub-install:grub2-install: "${D}"/sbin/grub-install
		mv "${D}"/sbin/grub{,2}-install || die
		mv "${D}"/usr/share/man/man8/grub{,2}-install.8 || die
	fi
}

setup_boot_dir() {
	local boot_dir=$1
	local dir=${boot_dir}/grub

	if [[ ! -e ${dir}/grub.cfg ]] ; then
		einfo "Running: grub-mkconfig -o '${dir}/grub.cfg'"
		grub-mkconfig -o "${dir}/grub.cfg"
	fi

	#local install=grub-install
	#use multislot && install="grub2-install --grub-setup=/bin/true"
	#einfo "Running: ${install} "
	#${install}
}

pkg_postinst() {
	if use multislot ; then
		elog "You have installed grub2 with USE=multislot, so to coexist"
		elog "with grub1, the grub2 install binary is named grub2-install."
	fi
	setup_boot_dir "${ROOT}"boot
}
