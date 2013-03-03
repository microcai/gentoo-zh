# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="Tencent QQ for Linux by longine"
HOMEPAGE="http://www.longene.org/"
SRC_URI="http://www.longene.org/download/WineQQ2012-${PV}-Longene.deb"

LICENSE="Tencent"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

MLIB_DEPS="amd64? (
        >=app-emulation/emul-linux-x86-xlibs-2.1
        >=app-emulation/emul-linux-x86-soundlibs-2.1
        app-emulation/emul-linux-x86-db
        app-emulation/emul-linux-x86-sdl
        app-emulation/emul-linux-x86-opengl
        app-emulation/emul-linux-x86-medialibs
        app-emulation/emul-linux-x86-baselibs
        >=sys-kernel/linux-headers-2.6
        )"


DEPEND="${MLIB_DEPS}
                x11-proto/inputproto
                x11-proto/xextproto
                x11-proto/xf86vidmodeproto

"

RESTRICT="mirror"

QA_PRESTRIPPED="opt/linuxqq/qq"

src_install() {
	tar xzvf data.tar.gz -C ${D}/
	chmod 755 ${D}/opt
	chmod 755 ${D}/usr
}

