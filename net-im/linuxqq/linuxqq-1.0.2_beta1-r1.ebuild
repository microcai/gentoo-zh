# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils multilib

MY_P=${PN}_v${PV/_/-}_i386
DESCRIPTION="Tencent QQ for Linux"
HOMEPAGE="http://im.qq.com/qq/linux"
SRC_URI="http://dl_dir.qq.com/linuxqq/${MY_P}.tar.gz"

LICENSE="Tencent"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE=""

# FIXME: missing something here?
# http://www.gentoo.org/proj/en/base/amd64/emul/content.xml
DEPEND=""
RDEPEND="x86? ( >=x11-libs/gtk+-2.10.8 )
	amd64? (
		>=app-emulation/emul-linux-x86-baselibs-1.0
		>=app-emulation/emul-linux-x86-gtklibs-1.0
		app-emulation/emul-linux-x86-compat
	)"

S=${WORKDIR}/${MY_P}
RESTRICT="mirror strip"

pkg_setup() {
	#XXX: x86 binary package, we need multilib?
	if use amd64 && ! has_multilib_profile ; then
		eerror "We need multilib profile to run Tencent QQ client!"
		die "We need multilib profile to run Tencent QQ client!"
	fi
}

src_install() {
	dodir /opt/${PN}
	mv "${S}"/* "${D}"/opt/${PN}

	doicon "${FILESDIR}"/linuxqq.png
	domenu "${FILESDIR}"/linuxqq.desktop
	make_wrapper qq ./qq "/opt/${PN}"
}

pkg_postinst() {
	ewarn "This package is very experimental."
	echo
	elog "Please report your bugs to:"
	elog "http://support.qq.com/beta2/simple/index.html?fid=361"
	echo
}
