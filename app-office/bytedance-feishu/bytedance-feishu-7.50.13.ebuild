# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop unpacker xdg
DESCRIPTION="
飞书（Feishu）
飞书整合即时消息、日历、音视频会议、云文档、工作台等功能于一体，成就团队和个人，更高效、更愉悦。 "
HOMEPAGE="https://www.feishu.cn/download"
SRC_URI="
	amd64? ( https://sf3-cn.feishucdn.com/obj/ee-appcenter/1d078929/Feishu-linux_x64-${PV}.deb )
	arm64? ( https://sf3-cn.feishucdn.com/obj/ee-appcenter/05ade0ea/Feishu-linux_arm64-${PV}.deb )
"

S="${WORKDIR}"
LICENSE="Feishu-EULA"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RESTRICT="strip mirror bindist"

DEPEND="
	app-misc/ca-certificates
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/libpulse
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXext
	x11-misc/xdg-utils
"
BDEPEND="
	dev-util/patchelf
	sys-apps/paxctl
"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	unpacker "${S}/usr/share/man/man1/bytedance-feishu-stable.1.gz"
	unpacker "${S}/usr/share/doc/bytedance-feishu-stable/changelog.gz"
}

src_install() {
	# fix scanelf rpath error: https://github.com/microcai/gentoo-zh/issues/7666
	for f in libbv-screen-capture.so libbyteview-bytertc.so libbyteview-record.so libuss.so; do
		patchelf --set-rpath '$ORIGIN' "${S}/opt/bytedance/feishu/${f}" || die "patchelf failed on ${f}"
	done
	# fix scanelf W^X error: https://github.com/microcai/gentoo-zh/issues/8194
	for f in libbyteview-bytertc.so video_conference_sdk; do
		paxctl -c "${S}/opt/bytedance/feishu/${f}" || die "paxctl failed on ${f}"
	done
	insinto "/"
	doins -r "${S}/opt/"
	dosym -r /opt/bytedance/feishu/bytedance-feishu /usr/bin/bytedance-feishu-stable
	domenu "${S}/usr/share/applications/bytedance-feishu.desktop"
	doman "${S}/bytedance-feishu-stable.1"
	dodoc "${S}/changelog"
	local size
	for size in 16 24 32 48 64 128 256 ; do
		newicon -s ${size} "${S}/opt/bytedance/feishu/product_logo_${size}.png" ${PN}.png
	done
	newicon -s scalable "${S}/opt/bytedance/feishu/product_logo_256.svg" ${PN}.svg

	fperms +x "/opt/bytedance/feishu/bytedance-feishu"
	fperms +x "/opt/bytedance/feishu/feishu"
	fperms +x "/opt/bytedance/feishu/vulcan/vulcan"
	fperms +x "/opt/bytedance/feishu/vulcan/vulcan_crashpad_handler"
}
