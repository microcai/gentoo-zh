# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg desktop unpacker

DESCRIPTION="The official unity tool for manager Unity Engines and projects"
HOMEPAGE="https://unity.com/"
SRC_URI="https://hub.unity3d.com/linux/repos/deb/pool/main/u/unity/unityhub_amd64/${PN}-amd64-${PV}.deb"

LICENSE="unity-EULA"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror strip"

IUSE="+appindicator legacy"

DEPEND="
	appindicator? (
		dev-libs/libdbusmenu
		legacy? (
			dev-libs/libappindicator
			gnome-base/gconf
			x11-themes/gtk-engines-murrine
			x11-misc/appmenu-gtk-module[gtk2]
		)
	)
	app-arch/cpio
	dev-libs/nss
	x11-libs/gtk+
	app-crypt/libsecret
	|| ( <dev-libs/openssl-3 dev-libs/openssl-compat )
"
RDEPEND="${DEPEND}"
BDEPEND=""
S=${WORKDIR}
src_unpack(){
	unpack_deb ${PN}-amd64-${PV}.deb
}
src_install(){
	insinto "/opt"
	doins -r "${S}/opt/unityhub"
	dosym -r /opt/unityhub/unityhub /usr/bin/unityhub
	for si in 16 32 48 64 128 256 512; do
		doicon -s ${si} usr/share/icons/hicolor/${si}x${si}/apps/${PN}.png
	done
	domenu "${WORKDIR}/usr/share/applications/unityhub.desktop"
	fperms 0755 -R "/opt/unityhub"
}
