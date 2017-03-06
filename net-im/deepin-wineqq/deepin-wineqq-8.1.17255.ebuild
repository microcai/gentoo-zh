# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit unpacker

DESCRIPTION="Tencent QQ for Linux by Deepin"
HOMEPAGE="https://www.deepin.org"

COMMON_URI="http://packages.deepin.com/deepin/pool/non-free/d"
QQPN="deepin.com.qq.im"
DWV="1.9-17"

SRC_URI="${COMMON_URI}/${QQPN}/${QQPN}_${PV}deepin9_i386.deb
	${COMMON_URI}/deepin-wine/deepin-fonts-wine_${DWV}_all.deb
	${COMMON_URI}/deepin-wine/deepin-libwine_${DWV}_i386.deb
	${COMMON_URI}/deepin-wine/deepin-wine32_${DWV}_i386.deb
	${COMMON_URI}/deepin-wine/deepin-wine_${DWV}_all.deb
	${COMMON_URI}/deepin-wine-helper/deepin-wine-helper_1.0deepin6_i386.deb"


LICENSE="Tencent"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=media-libs/alsa-lib-1.0.16
	>=media-libs/lcms-2.2
	>=net-nds/openldap-2.4.7
	>=media-sound/mpg123-1.13.7
	>=media-libs/openal-1.14
	>=net-libs/libpcap-0.9.8
	media-sound/pulseaudio
	media-libs/glu
	media-libs/mesa
	dev-libs/udis86
	sys-libs/zlib
	media-libs/libv4l"

S=${WORKDIR}

src_install() {
	mv ${S}/usr/local/share/* ${S}/usr/share
	rm -r ${S}/usr/local
	
	insinto /lib/udev/rules.d
	doins etc/udev/rules.d/ukeys.rules
	
	insinto /
	doins -r opt usr
	
	fperms 755 /usr/bin/deepin-wine
	fperms 755 -R /usr/lib/
	fperms 755 /opt/deepinwine/apps/Deepin-QQ/run.sh
	fperms 755 -R /opt/deepinwine/tools/
}
