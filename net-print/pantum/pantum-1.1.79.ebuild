# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="奔图打印机Linux驱动"
HOMEPAGE="https://www.pantum.cn/support/download/driver/"

IUSE="+cm1100dn cm1100adw scanner"

SRC_URI="cm1100dn? ( https://drivers.pantum.cn/userfiles/files/download/PantumUbuntuDriverV1.1.79-1_1644319790337.zip )
cm1100adw? ( https://drivers.pantum.cn/userfiles/files/download/PantumUbuntuDriverV1.1.79-1_1644319935381.zip )
"

LICENSE="AS-IS"
SLOT="0"
KEYWORDS="~amd64"

COMMON_DEPEND="
        media-libs/libjpeg8
        net-print/cups
        sys-apps/dbus
        virtual/jpeg:0
        net-print/cups-filters
        scanner? (
                media-gfx/sane-backends
        )
"
BDEPEND="
        virtual/pkgconfig
"
DEPEND="
        ${COMMON_DEPEND}
"
RDEPEND="
        ${COMMON_DEPEND}
        app-text/ghostscript-gpl
"
S="${WORKDIR}/Pantum Ubuntu Driver V1.1.79-1"

src_prepare(){
        eapply_user
        unpack "${S}/Resources/pantum_1.1.79-1_amd64.deb"
}

src_install(){
        tar -xvf "${S}/data.tar.xz" -C "$D"
        mkdir "${D}/etc/ld.so.conf.d/"
        echo /opt/pantum/lib >> "${D}/etc/ld.so.conf.d/pantum.conf"
        if ! use scanner ; then
                rm ${D}/usr/lib/x86_64-linux-gnu/ -rf
                rm ${D}/usr/local/lib
                rm ${D}/etc/sane.d
        fi
}

post_install(){
        ldconfig
}
