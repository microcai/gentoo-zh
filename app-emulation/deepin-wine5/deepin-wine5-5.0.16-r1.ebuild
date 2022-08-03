# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

DESCRIPTION="Deepin wine5"
HOMEPAGE="https://www.deepin.org"

APPSTORE_URI="https://community-store-packages.deepin.com/appstore/pool/appstore"
COMMUNITY_URI="https://community-packages.deepin.com/deepin/pool/main"
SRC_URI="${APPSTORE_URI}/d/${PN}/${PN}_${PV}-${PR/r/}_i386.deb
		 ${APPSTORE_URI}/d/${PN}/${PN}-i386_${PV}-${PR/r/}_i386.deb

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

BDEPEND="dev-util/patchelf"

S=${WORKDIR}
QA_FLAGS_IGNORED=".*"
QA_PREBUILT="*"
QA_SONAME="*"
QA_TEXTRELS="*"

src_install() {
	# Fix files installing to one or more unexpected paths
	mkdir -p "${S}"/opt/"${PN}"/share/ || die
	mv "${S}"/usr/share/* "${S}"/opt/"${PN}"/share/ || die
	# Install missing lib/lib64
	mkdir -p "${S}"/opt/"${PN}"/lib/ || die
	mv "${S}"/usr/lib/i386-linux-gnu/* "${S}"/opt/"${PN}"/lib/ || die
	mv "${S}"/opt/"${PN}"/lib/"${PN}"/* "${S}"/opt/"${PN}"/lib/ || die
	rm -r "${S}"/opt/"${PN}"/lib/"${PN}"

	# Set RPATH for libs handling
	pushd "${S}"/opt/"${PN}"/lib || die
	local x
	for x in $(find) ; do
		# Use \x7fELF header to separate ELF executables and libraries
		[[ -f ${x} && $(od -t x1 -N 4 "${x}") == *"7f 45 4c 46"* ]] || continue
		local RPATH_ROOT="${EPREFIX}"/opt/"${PN}"/lib
		local RPATH_S="${RPATH_ROOT}/"
		[[ ${x} != *"wine-preloader" ]] || continue
		patchelf --set-rpath "${RPATH_S}" "${x}" || \
			die "patchelf failed on ${x}"
	done
	popd || die

	# Set RPATH for binaries handlings
	pushd "${S}"/usr/lib/"${PN}" || die
	local x
	for x in $(find) ; do
		# Use \x7fELF header to separate ELF executables and libraries
		[[ -f ${x} && $(od -t x1 -N 4 "${x}") == *"7f 45 4c 46"* ]] || continue
		local RPATH_ROOT="${EPREFIX}"/opt/"${PN}"/lib
		local RPATH_S="${RPATH_ROOT}/"
		[[ ${x} != *"wine-preloader" ]] || continue
		patchelf --set-rpath "${RPATH_S}" "${x}" || \
			die "patchelf failed on ${x}"
	done
	popd || die

	insinto /
	doins -r usr opt

	fperms 755 -R /opt/"${PN}"/
	fperms 755 -R /usr/bin/
	chmod 755 "${ED}"/usr/lib/"${PN}"/*
	find "${ED}"/opt/${PN}/lib* -name '*.a' -exec chmod 644 '{}' + || die
}
