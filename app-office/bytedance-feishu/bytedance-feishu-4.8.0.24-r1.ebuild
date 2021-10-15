# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MULTILIB_COMPAT=( abi_mips_n64 )

inherit desktop xdg-utils unpacker

DESCRIPTION="feishu - ByteDance's enterprise collaboration platform"
HOMEPAGE="https://www.feishu.cn/"
SRC_URI="
	amd64?	( https://sf3-cn.feishucdn.com/obj/suite-public-file-cn/b4f6bd/${PN}-beta_4.8.0-24_amd64.deb )
	arm64?	( https://sf3-cn.feishucdn.com/obj/suite-public-file-cn/b4f6bd/${PN}-beta_4.8.0-24_arm64.deb )
	mips?	( https://sf3-cn.feishucdn.com/obj/suite-public-file-cn/b4f6bd/${PN}-beta_4.8.0-24_mips64el.deb )
"

LICENSE="bytedance-feishu"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64 ~mips"
IUSE="big-endian"
REQUIRED_USE="mips? ( !big-endian )"

DEPEND="
	dev-libs/nss
	dev-util/desktop-file-utils
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libxcb
	x11-misc/xdg-utils
"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"
QA_PREBUILT="opt/bytedance/*"

src_prepare() {
	eapply_user
	sed -i 's/Application;//g' usr/share/applications/bytedance-feishu.desktop || die
	rm -r usr/share/menu || die
	gzip -d "usr/share/man/man1/${PN}-beta.1.gz" || die
	gzip -d "usr/share/doc/${PN}-beta/changelog.gz" || die
}

src_install() {
	insinto "/opt/bytedance"
	doins -r "opt/bytedance/feishu"
	fperms +x "/opt/bytedance/feishu/"{bytedance-feishu,chrome-sandbox,lark}
	fperms +x "/opt/bytedance/feishu/vulcan/vulcan"

	local size
	for size in 16 24 32 48 64 128 256 ; do
		newicon -s ${size} "opt/bytedance/feishu/product_logo_${size}.png" ${PN}.png
	done

	dosym "../../opt/bytedance/feishu/${PN}" "/usr/bin/${PN}-beta"
	domenu "usr/share/applications/${PN}.desktop"
	doman "usr/share/man/man1/${PN}-beta.1"
	dodoc "usr/share/doc/${PN}-beta/changelog"
}
