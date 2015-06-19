# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MY_PN="360safeforlinux"

DESCRIPTION="360safe for Linux"
HOMEPAGE="http://linux.360.cn/index.html"
SRC_URI="
 amd64? ( http://down.360safe.com/linuxsafe/deepin64/${MY_PN}-${PV}-stripped.deb -> ${P}-amd64.deb )
 x86? ( http://down.360safe.com/linuxsafe/deepin32/${MY_PN}-${PV}-stripped.deb -> ${P}-x86.deb )
"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"

DEPEND="app-arch/tar"

RDEPEND=">=dev-libs/openssl-1.0
        sys-auth/polkit[pam]
        net-misc/curl
        dev-qt/qtsql:4
        dev-qt/qtcore:4[glib]
        dev-qt/qtgui:4[glib]"

src_install(){
  tar -xvf ${WORKDIR}/data.tar.xz -C "${D}"
  
  cat << EOF > ${D}/opt/360safeforlinux/start360.sh
#! /bin/sh
exec pkexec "/opt/360safeforlinux/s360SafeForLinux" --user="\$USER" "\$@"
EOF

}
