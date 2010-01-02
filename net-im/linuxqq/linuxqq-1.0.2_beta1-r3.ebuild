# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

MY_P=${PN}_v${PV/_/-}_i386
DESCRIPTION="Tencent QQ for Linux"
HOMEPAGE="http://im.qq.com/qq/linux"
SRC_URI="http://dl_dir.qq.com/linuxqq/${MY_P}.tar.gz"

LICENSE="Tencent"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-compat
		app-emulation/emul-linux-x86-gtklibs )
	x86? ( >=x11-libs/gtk+-2 )"

S=${WORKDIR}/${MY_P}
RESTRICT="mirror"

QA_PRESTRIPPED="opt/linuxqq/qq"

src_install() {
	dodir /opt/${PN}
	mv "${S}"/* "${D}"/opt/${PN}

	doicon "${FILESDIR}"/${PN}.png
	domenu "${FILESDIR}"/${PN}.desktop
	if use amd64; then
		dodir /usr/bin
		cat <<EOF >"${D}"/usr/bin/qq
#!/bin/sh
export GDK_PIXBUF_MODULE_FILE=/etc/gtk-2.0/i686-pc-linux-gnu/gdk-pixbuf.loaders
export GTK_IM_MODULE_FILE=/etc/gtk-2.0/i686-pc-linux-gnu/gtk.immodules
cd "/opt/${PN}"
exec /opt/linuxqq/qq "\$@"
EOF
		fperms 0755 /usr/bin/qq
	elif use x86; then
		make_wrapper qq ./qq /opt/${PN}
	fi
}

pkg_postinst() {
	ewarn "This package is very experimental, please report your bugs to:"
	ewarn "http://support.qq.com/beta2/simple/index.html?fid=361"
}
