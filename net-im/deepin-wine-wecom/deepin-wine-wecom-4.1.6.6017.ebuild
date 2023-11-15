# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

WECHAT_INSTALLER="WeChatSetup"
DP_WECHAT_VER="${PV}deepin10"
DEB_PN="com.qq.weixin.work.deepin"

DESCRIPTION="Tencent Weixin Work on Deepin Wine(${DEB_PN}) For Gentoo"
HOMEPAGE="https://aur.archlinux.org/packages/com.qq.weixin.work.deepin-x11"

SRC_URI="
	https://mirrors.sdu.edu.cn/spark-store-repository/store/chat/${DEB_PN}/${DEB_PN}_${PV}deepin5.1_all.deb
"

LICENSE="Tencent"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=app-emulation/deepin-wine-helper-5.1.45
	>=app-emulation/deepin-wine6-stable-6.0.0.52
	media-fonts/noto-cjk
	media-fonts/wqy-microhei
	media-libs/alsa-lib[abi_x86_32]
	media-libs/libpulse[abi_x86_32]
	media-libs/openal[abi_x86_32]
	media-plugins/alsa-plugins[abi_x86_32]
	media-sound/mpg123[abi_x86_32]
	>=net-nds/openldap-2.4.0[abi_x86_32]
	x11-apps/xwininfo
"

DEPEND="${RDEPEND}"

S="${WORKDIR}"
QA_PREBUILT="*"

src_install() {
	local OPN="opt/apps/${DEB_PN}"

	cp "${FILESDIR}"/"${P}"-run.sh "${S}"/"${OPN}"/files/run.sh || die
	sed -i "s/Categories=.*/Categories=Chat;Network;InstantMessaging;/g" \
		"${S}"/"${OPN}"/entries/applications/"${DEB_PN}".desktop || die
	insinto "${OPN}"/files
	doins -r "${S}"/"${OPN}"/files/*
	fperms +x /"${OPN}"/files/run.sh

	# Install scalable icons
	doicon -s scalable "${S}"/"${OPN}"/entries/icons/hicolor/48x48/apps/"${DEB_PN}".svg
	domenu "${S}"/"${OPN}"/entries/applications/"${DEB_PN}".desktop
}
