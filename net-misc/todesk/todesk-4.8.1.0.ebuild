# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker systemd

DESCRIPTION="ToDesk不一样的远控体验，轻松打破物理限制，随时随地高效使用所有计算终端"
HOMEPAGE="https://www.todesk.com/"
SRC_URI="https://dl.todesk.com/linux/todesk-v${PV}-amd64.deb"

S="${WORKDIR}"
LICENSE="todesk"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip mirror"

DEPEND="
	dev-libs/libayatana-appindicator
	sys-apps/systemd"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	sed -i '/^Version=/d' usr/share/applications/todesk.desktop
}

src_install() {
	insinto /opt/todesk
	doins -r opt/todesk/bin
	doins -r opt/todesk/res
	fperms 0755 /opt/todesk/bin/{ToDesk,ToDesk_Service,ToDesk_Session,CrashReport}

	systemd_dounit etc/systemd/system/todeskd.service

	for size in 16 24 32 48 64 128 256 512; do
		doicon -s "${size}" usr/share/icons/hicolor/"${size}"x"${size}"/apps/todesk.png
	done

	domenu usr/share/applications/todesk.desktop

	dosym -r /usr/$(get_libdir)/libayatana-appindicator3.so /opt/todesk/bin/libappindicator3.so.1
}
