# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/dnsmasq/dnsmasq-2.60.ebuild,v 1.1 2012/03/07 21:59:18 chutzpah Exp $

EAPI=4

inherit eutils toolchain-funcs flag-o-matic systemd

MY_P="${P/_/}"
MY_PV="${PV/_/}"
DESCRIPTION="Small forwarding DNS server"
HOMEPAGE="http://www.thekelleys.org.uk/dnsmasq/"
SRC_URI="http://www.thekelleys.org.uk/dnsmasq/${MY_P}.tar.xz"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="conntrack dbus +dhcp idn ipv6 lua nls script tftp systemd"

RDEPEND="dbus? ( sys-apps/dbus )
	idn? ( net-dns/libidn )
	lua? ( dev-lang/lua )
	conntrack? ( net-libs/libnetfilter_conntrack )
	nls? (
		sys-devel/gettext
		net-dns/libidn
	)"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	|| ( app-arch/xz-utils app-arch/lzma )
	systemd? ( >=sys-apps/systemd-184 )"

S="${WORKDIR}/${PN}-${MY_PV}"

REQUIRED_USE="lua? ( script )"

use_have() {
	local NO_ONLY=""
	if [ $1 == '-n' ]; then
		NO_ONLY=1
		shift
	fi

	local UWORD=${2:-$1}
	UWORD=${UWORD^^*}

	if ! use ${1}; then
		echo " -DNO_${UWORD}"
	elif [ -z "${NO_ONLY}" ]; then
		echo " -DHAVE_${UWORD}"
	fi
}

pkg_setup() {
	enewgroup dnsmasq
	enewuser dnsmasq -1 -1 /dev/null dnsmasq
}

src_prepare() {
	# dnsmasq on FreeBSD wants the config file in a silly location, this fixes
	epatch "${FILESDIR}/${PN}-2.47-fbsd-config.patch"
	sed -i -r 's:lua5.[0-9]+:lua:' Makefile

	# apply systemd patch
	use systemd && epatch "${FILESDIR}/${P}-systemd.patch"
}

src_configure() {
	COPTS="$(use_have conntrack)"
	COPTS+="$(use_have dbus)"
	COPTS+="$(use_have -n dhcp)"
	COPTS+="$(use_have idn)"
	COPTS+="$(use_have -n ipv6)"
	COPTS+="$(use_have lua luascript)"
	COPTS+="$(use_have -n script)"
	COPTS+="$(use_have -n tftp)"
	COPTS+="$(use ipv6 && use dhcp || echo " -DNO_DHCP6")"
}

src_compile() {
	emake \
		PREFIX=/usr \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		COPTS="${COPTS}" \
		LDFLAGS="${LDFLAGS}" \
		all$(use nls && echo "-i18n")
}

src_install() {
	emake \
		PREFIX=/usr \
		MANDIR=/usr/share/man \
		DESTDIR="${D}" \
		install$(use nls && echo "-i18n")

	dodoc CHANGELOG CHANGELOG.archive FAQ
	dodoc -r logo

	dodoc CHANGELOG FAQ
	dohtml *.html

	newinitd "${FILESDIR}"/dnsmasq-init-r2 dnsmasq
	newconfd "${FILESDIR}"/dnsmasq.confd-r1 dnsmasq

	insinto /etc
	newins dnsmasq.conf.example dnsmasq.conf

	if use dbus ; then
		insinto /etc/dbus-1/system.d
		doins dbus/dnsmasq.conf
	fi

	systemd_dounit "${FILESDIR}/dnsmasq.service"
	systemd_dounit "${FILESDIR}/dnsmasq.socket"
	use dhcp &&	systemd_dounit "${FILESDIR}/dnsmasq-dhcp.socket"
	use tftp &&	systemd_dounit "${FILESDIR}/dnsmasq-tftp.socket"
}

pkg_postinst(){
	einfo "We have installed systemd unit files.If you're using systemd, enable dnsmasq with"
	einfo "systemctl enable ${PN}.socket"
	if use dhcp || use tftp ; then
		einfo "If you want to enable dhcp and ftp support in ${PN}, don't forget to run "
		einfo "systemctl enable ${PN}-dhcp.socket "
		einfo "and"
		einfo "systemctl enable ${PN}-tftp.socket"
		einfo "when you enable it in the ${PN} configure file"
	fi
}

