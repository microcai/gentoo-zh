# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils multilib rpm

DESCRIPTION="SafeNet (Aladdin) eTokens Middleware (PRO, NG OTP, Flash, Java)"

MY_PN="SafenetAuthenticationClient"
MY_PV="${PV/_p/-}"

MY_P_STD="${MY_PN}-${MY_PV}"
SRC_URI="http://repositorio.serpro.gov.br/drivers/safenet/linux/SafenetAuthenticationClient-BR-10.3_Linux_Ubuntu-RedHat(32-64bits).zip"

HOMEPAGE="http://aladdin-rd.ru"
LICENSE="EULA"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ssl"

RDEPEND="
	dev-libs/atk
	dev-libs/glib:2
	dev-libs/openssl
	media-libs/fontconfig
	media-libs/freetype
	sys-apps/dbus
	sys-apps/pcsc-lite
	virtual/libusb:0
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/pango
	ssl? ( dev-libs/libp11 )
	!app-crypt/pkiclient
"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_unpack() {
	default

	cd "$S";

	if use amd64 ; then
		unpack "$S/SafenetAuthenticationClient-BR-10.0.37-0_amd64.deb"
	elif use x86 ; then
		unpack "$S/SafenetAuthenticationClient-BR-10.0.37-0_i386.deb"
	fi

	unpack "$S/data.tar.xz"

	rm -rf usr/lib

	mv lib usr/$(get_libdir)
}

src_prepare() {
	default

	cp "${FILESDIR}/SACSrv.init" etc/init.d/SACSrv

}

src_install() {
	local usb_readers_dir="usr/$(get_libdir)/readers/usb"

	mkdir -p "${usb_readers_dir}"
	ln -s "../../../share/eToken/drivers/aks-ifdh.bundle" "${usb_readers_dir}/aks-ifdh.bundle"

	pushd usr/share/eToken/drivers/aks-ifdh.bundle/Contents/Linux
		# TODO glob
		ln -s libAksIfdh.so{.$(ver_cut 1-2),}
	popd

	mkdir -p etc/conf.d/
	touch etc/conf.d/SACSrv

	mv etc "${D}/"
	mv usr "${D}/"
	mv var "${D}/"
}

pkg_postinst() {
	einfo "usermod -aG usb pcscd"
	einfo ""
	einfo "rc-update add SACSrv default"
	einfo ""
	einfo "If you need some help, you can ask the help in that article:"
	einfo "http://www.it-lines.ru/blogs/linux/nastrojka-etoken-v-gentoo-linux"
}
