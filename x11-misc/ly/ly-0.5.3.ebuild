# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Ly - a TUI display manager"
HOMEPAGE="https://github.com/nullgemm/ly"
SRC_URI="https://github.com/nullgemm/ly/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
EGIT_CHECKOUT_DIR="${S}/sub"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="sys-libs/pam
		x11-libs/libxcb
		x11-base/xorg-server
		x11-apps/xauth"
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	if [[ -n ${A} ]]; then
		unpack ${A} || die
	fi
		for _i in argoat configator dragonfail termbox_next; do
			git-r3_fetch ${HOMEPAGE%ly}${_i} || die
			git-r3_checkout ${HOMEPAGE%ly}${_i} ${EGIT_CHECKOUT_DIR}/${_i} || die
	done
}
