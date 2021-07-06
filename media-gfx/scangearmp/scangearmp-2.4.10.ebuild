# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

MY_P1=$( ver_cut 1 )
MY_P2=$( ver_cut 2- )
MY_PN="${PN}${MY_P1}"
MY_P="${MY_PN}-source-${MY_P2}-1"

DESCRIPTION="Driver and utility package for Canon scanners"
HOMEPAGE="https://www.canon.com"
SRC_URI="https://gdlp01.c-wss.com/gds/4/0100010924/01/${MY_P}.tar.gz"

LICENSE="Canon-IJ"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.16:2
virtual/libusb:1"
RDEPEND="${DEPEND}"

S="${PORTAGE_BUILDDIR}/work/${MY_P}/${MY_PN}"

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
	SHIPPED_LIBS="${PORTAGE_BUILDDIR}/work/${MY_P}/com/libs_bin$(usex amd64 64 32)"
	emake LDFLAGS="-L${SHIPPED_LIBS}"
}

src_install()
{
	SHIPPED_LIBS="${PORTAGE_BUILDDIR}/work/${MY_P}/com/libs_bin$(usex amd64 64 32)"

	dodir /usr/lib/bjlib
	dodir /lib/udev/rules.d

	dolib.so "${SHIPPED_LIBS}/"*.so*
	insinto /usr/lib/bjlib
	doins "${PORTAGE_BUILDDIR}/work/${MY_P}/com/ini/canon_mfp2_net.ini"

	insinto /lib/udev/rules.d
	doins "${S}/etc/"*.rules

	emake DESTDIR="${D}" install
}
