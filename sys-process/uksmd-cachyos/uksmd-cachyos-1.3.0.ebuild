# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit linux-info meson systemd

DESCRIPTION="Userspace KSM helper daemon (CachyOS version)"
HOMEPAGE="https://github.com/CachyOS/uksmd"
SRC_URI="https://github.com/CachyOS/uksmd/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/uksmd-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd"

DEPEND="
	sys-libs/libcap-ng
	>=sys-process/procps-4.0.5:=
	systemd? ( sys-apps/systemd:= )
"
RDEPEND="
	${DEPEND}
	!sys-process/uksmd
"

CONFIG_CHECK="~KSM"

src_configure() {
	local emesonargs=(
		$(meson_feature systemd)
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	newinitd "${FILESDIR}/uksmd.init" uksmd
	use systemd && systemd_dounit uksmd.service
}
