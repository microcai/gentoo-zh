# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg

WECHAT_INSTALLER="WeChatSetup"
DP_WECHAT_VER="3.2.1.154deepin13"
DEB_PN="com.qq.weixin.deepin"

DESCRIPTION="Tencent WeChat on Deepin Wine(${DEB_PN}) For Gentoo"
HOMEPAGE="https://aur.archlinux.org/packages/deepin-wine-wechat"

_MIRROR="https://com-store-packages.uniontech.com"
SRC_URI="${_MIRROR}/appstore/pool/appstore/c/${DEB_PN}/${DEB_PN}_${DP_WECHAT_VER}_i386.deb
		 https://github.com/oatiz/lyraile-overlay/releases/download/tempfile/${WECHAT_INSTALLER}-${PV}.exe -> ${P}-${WECHAT_INSTALLER}.exe
"

LICENSE="Tencent"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	app-arch/p7zip
	x11-apps/xwininfo
	media-fonts/wqy-microhei
	media-fonts/noto-cjk
	app-emulation/deepin-wine6-stable
	app-emulation/deepin-wine-helper
"

S=${WORKDIR}

src_prepare() {
	default

	local app_file="${S}/opt/apps/${DEB_PN}/entries/applications/${DEB_PN}.desktop"
	sed -i "s/\(Categories.*$\)/\1Network;/" ${app_file}
	sed -i "13s/WeChat.exe/wechat.exe/" ${app_file}
	sed -i "s/run.sh\".*/run.sh\"/" ${app_file}

	7z x -aoa "${S}/opt/apps/${DEB_PN}/files/files.7z" -o"${S}/deepinwechatdir"
	rm -r "${S}/deepinwechatdir/drive_c/Program Files/Tencent/WeChat"
	patch -p1 -d "${S}/deepinwechatdir/" < "${FILESDIR}/reg.patch"
	ln -sf "/usr/share/fonts/wqy-microhei/wqy-microhei.ttc" "${S}/deepinwechatdir/drive_c/windows/Fonts/wqy-microhei.ttc"
	install -m644 "${DISTDIR}/${P}-${WECHAT_INSTALLER}.exe" "${S}/deepinwechatdir/drive_c/Program Files/Tencent/${WECHAT_INSTALLER}-${PV}.exe"
	7z a -t7z -r "${S}"/files.7z "${S}"/deepinwechatdir/*
}

src_install() {
	local OPN="opt/apps/${DEB_PN}"

	insinto "${OPN}"/files
	exeinto "${OPN}"/files

	doins -r "${OPN}"/files/dlls "${S}"/files.7z
	doexe "${FILESDIR}"/run.sh

	insinto /usr/share/icons
	doins -r opt/apps/"${DEB_PN}"/entries/icons/hicolor
	#local size
	#for size in 16 24 32 48 64 128 256 ; do
	#	newicon -s ${size}  ${OPN}/entries/icons/hicolor/${size}x${size}/${DEB_PN}.svg
	#done

	domenu "${OPN}"/entries/applications/"${DEB_PN}".desktop
}
