# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

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

src_install(){
	insinto /
	doins -r opt/
	doins -r etc/
	insinto /usr
	doins -r usr/share
	dobin usr/local/bin/todesk

	fperms 0755 /usr/bin/todesk
	fperms 0755 /opt/todesk/bin/{ToDesk,ToDesk_Service,ToDesk_Session,CrashReport}

	dosym -r /usr/$(get_libdir)/libayatana-appindicator3.so /opt/todesk/bin/libappindicator3.so.1
}
