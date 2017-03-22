# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: This ebuild is from mva overlay $

EAPI="5"

inherit eutils multilib rpm

DESCRIPTION="SafeNet (Aladdin) eToken Middleware for eTokenPRO, eTokenNG OTP, eTokenNG Flash, eToken Pro (Java)"

MY_PN="SafenetAuthenticationClient"
MY_PV="${PV/_p/-}"
MY_P_86="${MY_PN}-${MY_PV}.i386.rpm"
MY_P_64="${MY_PN}-${MY_PV}.x86_64.rpm"
MY_COMPAT_P="SAC-32-CompatibilityPack-${MY_PV}.x86_64.rpm"

SRC_URI="http://www.sadvisor.com/etoken/610-011815-002_SAC_Linux_v8.1.zip"

HOMEPAGE="http://www.etokenonlinux.org"
LICENSE="EULA"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE="multilib"

REQUIRED_USE="amd64? ( multilib )"

# TODO: minimal useflag (I can't do it now, since
# it seems like I brake my token and it is uninitialized now)
RDEPEND="
	>=sys-apps/pcsc-lite-1.8.13-r1[abi_x86_32]
	|| (
		dev-libs/libusb-compat[abi_x86_32]
		dev-libs/libusb:0[abi_x86_32]
	)
	sys-apps/dbus
	media-libs/libpng:1.2
	media-libs/fontconfig
"
DEPEND="
  app-arch/unzip
  app-arch/rpm2targz
  app-arch/tar
  ${RDEPEND}
"

QA_PREBUILT="*"
QA_SONAME_NO_SYMLINK="usr/lib32/.* usr/lib64/.*"

S="${WORKDIR}/SAC 8.1 Linux/rpmcontent"

src_unpack() {
	unpack "${A}"
	
	cd "${WORKDIR}/SAC 8.1 Linux/"
	
	mkdir rpmcontent

	if use amd64 ; then
	      unzip "x86_64/SAC_8_1_0_4_Linux_RPM_64.zip"
	      unzip "x86_64/SAC_8_1_0_4_Linux_32_Compatibilty_Pack_RPM.zip"
	      
	      rpm2tar -O "SAC_8_1_0_4_Linux_RPM_64/RPM/SafenetAuthenticationClient-8.1.0-4.x86_64.rpm" | tar -xf - -C rpmcontent
	      rpm2tar -O "SAC_8_1_0_4_Linux_32_Compatibilty_Pack_RPM/SAC-32-CompatibilityPack-8.1.0-4.x86_64.rpm" | tar -xf - -C rpmcontent

	      tar -xf "${FILESDIR}/dist/libhal_amd64_lib32.txz" -C rpmcontent
	      tar -xf "${FILESDIR}/dist/libhal_amd64_lib64.txz" -C rpmcontent
	fi
	
	if use x86 ; then
	    unzip "x32/SAC_8_1_0_4_Linux_RPM_32.zip"
	    rpm2tar -O "SAC_8_1_0_4_Linux_RPM_32/RPM/SafenetAuthenticationClient-8.1.0-4.i386.rpm"  | tar -xf - -C rpmcontent
	    tar -xf ${FILESDIR}/dist/libhal_x86.txz -C rpmcontent
	fi

	cd "${S}"
}

src_prepare() {
	default
	EPATCH_SOURCE="${FILESDIR}/patches" \
	EPATCH_SUFFIX="patch" \
	EPATCH_FORCE="yes" epatch

	epatch_user

	cp "${FILESDIR}/eTSrv.init-r3" etc/init.d/eTSrv
	cp "${FILESDIR}/dist/Makefile" "${S}"
}

pkg_postinst() {
	ewarn "!!!!!!!"
	ewarn "Currently, Gentoo Dev Team has removed libusb:0 from the portage tree"
	ewarn "(although, it is still in multilib overlay)"
	ewarn "For now, I added libusb-compat (wrapper) as a dependency,"
	ewarn "but it can either work or doesn't work for you."
	echo
	ewarn "If it'll not — try to emerge libusb:0 from multilib overlay."
	ewarn "!!!!!!!"
	echo
	einfo "Run"
	einfo "rc-update add pcscd default"
	einfo "rc-update add eTSrv default"
	einfo "to add eToken support daemon to autostart"
	einfo ""
	einfo "In some cases the eToken will not work after rebooting your system."
	einfo "This can be due to the fact, that your pcscd is not running."
	einfo "This may happen if you forgot to add pcscd to default runlevel"
	einfo "(or because of crash)."
	echo
	einfo "If you need some help, you can ask the help in that article:"
	einfo "http://www.it-lines.ru/blogs/linux/nastrojka-etoken-v-gentoo-linux"
}
