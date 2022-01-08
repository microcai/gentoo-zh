# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker xdg

DESCRIPTION="wechat"
HOMEPAGE="https://web.wechat.com"
SRC_URI="https://home-store-packages.uniontech.com/appstore/pool/appstore/c/com.tencent.weixin/com.tencent.weixin_${PV}_amd64.deb"

LICENSE="MIT"
KEYWORDS="~amd64"
SLOT="0"

RESTRICT="strip mirror bindist"
IUSE=""

RDEPEND="
sys-apps/lsb-release
sys-apps/bubblewrap
"

DEPEND="${RDEPEND}"

QA_PREBUILT="*"

S="${WORKDIR}"

src_install() {
	mkdir -p "${S}/usr/share/wechat" || die
	mkdir -p "${S}/usr/bin" || die
	mkdir -p "${S}/usr/share/wechat/var/uos/" || die
	mkdir -p "${S}/usr/share/wechat/var/lib/uos-license/" || die

	cp "${FILESDIR}/license.key" "${S}/usr/share/wechat/var/uos/.license.key" || die
	cp "${FILESDIR}/license.json" "${S}/usr/share/wechat/var/lib/uos-license/.license.json" || die
	cp "${FILESDIR}/lsb-release" "${S}/usr/share/wechat/"
	cp "${FILESDIR}/os-release" "${S}/usr/share/wechat/"

	mv "${S}/usr/share/applications/weixin.desktop"  "${S}/usr/share/applications/wechat.desktop"
	sed -i  's#Name=微信#Name=wechat#' "${S}/usr/share/applications/wechat.desktop" || die
	sed -i  's#/opt/apps/com.tencent.weixin/files/weixin/weixin#/usr/bin/wechat#' "${S}/usr/share/applications/wechat.desktop" || die

	doins -r "${S}/opt"
	doins -r "${S}/usr"

	exeinto /opt/apps/com.tencent.weixin/files/weixin
	exeopts -m0755
	doexe "${S}/opt/apps/com.tencent.weixin/files/weixin/weixin"

	exeinto /usr/bin
	exeopts -m0755
	doexe "${FILESDIR}/wechat"
}
