# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools udev

MY_P1=$( ver_cut 1 )
MY_P2=$( ver_cut 2- )
MY_PN="${PN}${MY_P1}"
MY_P="${MY_PN}-source-${MY_P2}-1"

DESCRIPTION="Driver and utility package for Canon scanners"
HOMEPAGE="https://www.canon.com"
SRC_URI="https://gdlp01.c-wss.com/gds/4/0100010924/01/${MY_P}.tar.gz"

S="${WORKDIR}/${MY_P}/${MY_PN}"

LICENSE="Canon-IJ"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=x11-libs/gtk+-2.16:2
virtual/libusb:1"
RDEPEND="${DEPEND}"

QA_PREBUILT="
	/usr/lib64/libcncpnet30.so.1.0.0
	/usr/lib64/libcncpnet20.so.1.0.0
	/usr/lib64/libcncpnet2.so.1.2.4
	/usr/lib64/libcncpmslld2.so.3.0.0
	/usr/bin/scangearmp2
	/usr/lib64/libcncpmslld2.so.3.0.0
	/usr/lib64/libcncpnet2.so.1.2.4
	/usr/lib64/libcncpnet20.so.1.0.0
	/usr/lib64/libcncpnet30.so.1.0.0
"

src_prepare()
{
	sed -i -e '/^CFLAGS/d' configure.in || die
	sed -i -e '/AC_INIT/s/in/ac/' configure.in || die
	mv configure.{in,ac} || die

	eapply_user

	eautoreconf
}

src_compile()
{
	SHIPPED_LIBS="${WORKDIR}/${MY_P}/com/libs_bin$(usex amd64 64 32)"
	emake LDFLAGS="-L${SHIPPED_LIBS}"
}

src_install()
{
	SHIPPED_LIBS="${WORKDIR}/${MY_P}/com/libs_bin$(usex amd64 64 32)"

	dodir /usr/lib/bjlib
	dodir /lib/udev/rules.d

	dolib.so "${SHIPPED_LIBS}/"*.so*
	insinto /usr/lib/bjlib
	doins "${WORKDIR}/${MY_P}/com/ini/canon_mfp2_net.ini"

	insinto /lib/udev/rules.d
	doins "${S}/etc/"*.rules

	emake DESTDIR="${D}" install
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
