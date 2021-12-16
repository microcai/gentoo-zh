# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MULTILIB_COMPAT=( abi_mips_n64 )

inherit desktop unpacker xdg

CDNVER="v5x9pa"

DESCRIPTION="feishu - ByteDance's enterprise collaboration platform"
HOMEPAGE="https://www.feishu.cn/"
SRC_URI="
	amd64?	( https://sf3-cn.feishucdn.com/obj/suite-public-file-cn/${CDNVER}/${PN}-beta_4.11.6-2_amd64.deb )
	arm64?	( https://sf3-cn.feishucdn.com/obj/suite-public-file-cn/${CDNVER}/${PN}-beta_4.11.6-2_arm64.deb )
	mips?	( https://sf3-cn.feishucdn.com/obj/suite-public-file-cn/${CDNVER}/${PN}-beta_4.11.6-2_mips64el.deb )
"

LICENSE="bytedance-feishu"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64 ~mips"
IUSE="big-endian"
REQUIRED_USE="mips? ( !big-endian )"

RDEPEND="
	dev-libs/nss
	dev-util/desktop-file-utils
	media-libs/alsa-lib
	net-print/cups
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-misc/xdg-utils
"

S="${WORKDIR}"
QA_PREBUILT="*"

src_prepare() {
	eapply_user
	sed -i 's/Application;//g' usr/share/applications/bytedance-feishu.desktop || die
	rm -r usr/share/appdata || die
	gzip -d "usr/share/man/man1/${PN}-beta.1.gz" || die
	gzip -d "usr/share/doc/${PN}-beta/changelog.gz" || die
}

src_install() {

	insinto "/"
	doins -r "opt"
	insinto "/usr/bin"
	doins "usr/bin/bytedance-feishu-beta"

	domenu "usr/share/applications/${PN}.desktop"
	doman "usr/share/man/man1/${PN}-beta.1"
	dodoc "usr/share/doc/${PN}-beta/changelog"

	local size
	for size in 16 24 32 48 64 128 256 ; do
		newicon -s ${size} "opt/bytedance/feishu/product_logo_${size}.png" ${PN}.png
	done

	fperms +x "/opt/bytedance/feishu/"{bytedance-feishu,lark}
	fperms +x "/opt/bytedance/feishu/vulcan/vulcan"

}

pkg_postinst(){
	xdg_pkg_postinst
}
