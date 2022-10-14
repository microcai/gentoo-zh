# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg desktop

DESCRIPTION="The Unity Hub is a standalone application that streamlines the way you find, download, and manage your Unity Projects and installation"
HOMEPAGE="https://unity.com/"
SRC_URI="https://hub.unity3d.com/linux/repos/deb/pool/main/u/unity/unityhub_amd64/${PN}-amd64-${PV}.deb"

LICENSE="unity-EULA"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror strip"

IUSE="+appindicator"

DEPEND="
	appindicator? (
		dev-libs/libdbusmenu
		dev-libs/libappindicator
	)
	app-arch/cpio
	dev-libs/nss
	x11-libs/gtk+
"
RDEPEND="${DEPEND}"
BDEPEND=""
S=${WORKDIR}
src_unpack(){
	unpack ${PN}-amd64-${PV}.deb
}
src_install(){
	tar -xf "${WORKDIR}/data.tar.bz2" || die
	mkdir  usr/bin || die
	ln -s /opt/unityhub/unityhub usr/bin/unityhub || die
	insinto "/opt"
	doins -r "${S}/opt/unityhub"
	insinto "/bin"
	doins -r "${S}/usr/bin/unityhub"
	for si in 16 32 48 64 128 256 512; do
        doicon -s ${si}  usr/share/icons/hicolor/${si}x${si}/apps/${PN}.png
    done
	domenu "${WORKDIR}/usr/share/applications/unityhub.desktop"
	fperms 0755 -R "/opt/unityhub"
}
