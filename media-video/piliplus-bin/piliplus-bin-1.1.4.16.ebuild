# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg desktop wrapper

DESCRIPTION="BiliBili third-party client developed using Flutter"
HOMEPAGE="https://github.com/bggRGjQaUbCoE/PiliPlus"
PVER="1.1.4+4296"
SRC_URI="https://github.com/bggRGjQaUbCoE/PiliPlus/releases/download/${PV}/PiliPlus_linux_${PVER}_amd64.tar.gz"
S="${WORKDIR}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
QA_PREBUILT="*"
DEPEND="
	net-libs/webkit-gtk:4.1
	dev-libs/libayatana-appindicator
	media-video/mpv
	x11-misc/xdg-user-dirs
"
RDEPEND="${DEPEND}"

src_install() {
	local instdir="/opt/${PN}"
	insinto "${instdir}"
	doins piliplus
	fperms +x "${instdir}/piliplus"
	doins -r data
	insinto "${instdir}/lib"
	doins lib/*.so
	make_wrapper "${PN}" "${instdir}/piliplus"
	domenu "${FILESDIR}/${PN}.desktop"
}
