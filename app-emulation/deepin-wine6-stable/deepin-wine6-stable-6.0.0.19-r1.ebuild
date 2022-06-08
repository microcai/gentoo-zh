# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

DESCRIPTION="Deepin wine6 stable"
HOMEPAGE="https://www.deepin.org"

APPSTORE_URI="https://com-store-packages.uniontech.com/appstore/pool/appstore"
COMMUNITY_URI="https://community-packages.deepin.com/deepin/pool/main"
SRC_URI="${APPSTORE_URI}/d/${PN}/${PN}_${PV}-${PR/r/}_amd64.deb
		 ${APPSTORE_URI}/d/${PN}/${PN}-i386_${PV}-${PR/r/}_i386.deb
		 ${APPSTORE_URI}/d/${PN}/${PN}-amd64_${PV}-${PR/r/}_amd64.deb
		 ${COMMUNITY_URI}/o/openldap/libldap-2.4-2_2.4.47+dfsg.4-1+eagle_i386.deb
		 ${COMMUNITY_URI}/o/openldap/libldap-2.4-2_2.4.47+dfsg.4-1+eagle_amd64.deb
		 ${COMMUNITY_URI}/c/cyrus-sasl2/libsasl2-2_2.1.27.1-1+dde_i386.deb
		 ${COMMUNITY_URI}/c/cyrus-sasl2/libsasl2-2_2.1.27.1-1+dde_amd64.deb
		 ${COMMUNITY_URI}/libp/libpcap/libpcap0.8_1.8.1.1-6+dde_i386.deb
		 ${COMMUNITY_URI}/libp/libpcap/libpcap0.8_1.8.1.1-6+dde_amd64.deb
"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="strip"

DEPEND=""
RDEPEND="${DEPEND}
	>=media-libs/alsa-lib-1.0.16[abi_x86_32(-)]
	>=media-libs/libgphoto2-2.5.10[abi_x86_32(-)]
	media-libs/gst-plugins-base[abi_x86_32(-)]
	media-libs/lcms:2[abi_x86_32(-)]
	>=net-nds/openldap-2.4.7[abi_x86_32(-)]
	>=media-sound/mpg123-1.13.7[abi_x86_32(-)]
	>=media-libs/openal-1.14[abi_x86_32(-)]
	>=net-libs/libpcap-0.9.8[abi_x86_32(-)]
	media-libs/libcanberra[pulseaudio,abi_x86_32(-)]
	virtual/libudev[abi_x86_32(-)]
	virtual/libusb:1[abi_x86_32(-)]
	>=app-emulation/vkd3d-1.0[abi_x86_32(-)]
	x11-libs/libX11[abi_x86_32(-)]
	x11-libs/libXext[abi_x86_32(-)]
	>=dev-libs/libxml2-2.9.0[abi_x86_32(-)]
	|| ( dev-libs/ocl-icd[abi_x86_32(-)]  dev-libs/opencl-icd-loader[abi_x86_32(-)] )
	app-emulation/deepin-udis86
	>=sys-libs/zlib-1.1.4[abi_x86_32(-)]
	|| ( sys-libs/ncurses[abi_x86_32(-)] sys-libs/ncurses-compat:5[abi_x86_32(-)] )
	media-libs/fontconfig[abi_x86_32(-)]
	media-libs/freetype:2[abi_x86_32(-)]
	sys-devel/gettext[abi_x86_32(-)]
	x11-libs/libXcursor[abi_x86_32(-)]
	media-libs/mesa[osmesa,abi_x86_32(-)]
	media-libs/glu[abi_x86_32(-)]
	media-libs/libjpeg-turbo[abi_x86_32(-)]
	x11-libs/libXrandr[abi_x86_32(-)]
	x11-libs/libXi[abi_x86_32(-)]
"

S=${WORKDIR}
QA_FLAGS_IGNORED=".*"
QA_PREBUILT="*"
QA_SONAME="*"
QA_TEXTRELS="*"

src_install() {
	# Fix files installing to one or more unexpected paths
	rm -rf "${S}"/usr/share || die
	# Install missing lib/lib64
	mv "${S}"/usr/lib/i386-linux-gnu/* "${S}"/opt/"${PN}"/lib/ || die
	mv "${S}"/usr/lib/x86_64-linux-gnu/* "${S}"/opt/"${PN}"/lib64/ || die

	insinto /
	doins -r usr opt

	fperms 755 -R /opt/"${PN}"/
	fperms 755 -R /usr/bin/
	fperms 644 -R /opt/"${PN}"/lib/*.a
	fperms 644 -R /opt/"${PN}"/lib64/*.a
}
