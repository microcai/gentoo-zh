# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit wget

DESCRIPTION="奔图打印机Linux驱动"
HOMEPAGE="https://www.pantum.cn/support/download/driver/"

WGET_SRC_URI="https://drivers.pantum.cn/userfiles/files/download/drive/1820/Pantum%20Ubuntu%20Driver%20V1_1_100-1.zip"
WGET_REFERER="https://www.pantum.cn"

S="${WORKDIR}/Pantum Ubuntu Driver V1.1.100-1"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
IUSE="scanner"
RESTRICT="mirror"

COMMON_DEPEND="
	net-print/cups
	sys-apps/dbus
	media-libs/libjpeg-turbo
	net-print/cups-filters
	scanner? (
		media-gfx/sane-backends
	)
"
BDEPEND="
	virtual/pkgconfig
	app-arch/unzip
"
DEPEND="
	${COMMON_DEPEND}
"
RDEPEND="
	${COMMON_DEPEND}
	app-text/ghostscript-gpl
"

src_unpack(){
	wget_src_fetch
	unpack "Pantum Ubuntu Driver V1_1_100-1.zip"
	unpack "${S}/Resources/pantum_1.1.100-1_amd64.deb"
}

src_install(){
	tar -xvf "${S}/data.tar.xz" -C "$D"
	if ! use scanner ; then
		rm -rf "${D}/usr/lib/x86_64-linux-gnu"
		rm -rf "${D}/usr/local"
	fi
	mv "${D}"/usr/lib "${D}"/usr/libexec
	mkdir "${D}/etc/ld.so.conf.d/"
	echo /opt/pantum/lib >> "${D}/etc/ld.so.conf.d/pantum.conf"
}

post_install() {
	ldconfig
}
