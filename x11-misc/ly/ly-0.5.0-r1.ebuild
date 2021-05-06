# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LYPV=${PV%-r*}

DESCRIPTION="Ly - a TUI display manager"
HOMEPAGE="https://github.com/nullgemm/ly"
SRC_URI="${HOMEPAGE}/archive/${LYPV}.tar.gz -> ${P}.tar.gz
        https://github.com/nullgemm/argoat/archive/master.tar.gz -> argoat.tar.gz
        https://github.com/nullgemm/configator/archive/master.tar.gz -> configator.tar.gz
        https://github.com/nullgemm/ctypes/archive/master.tar.gz -> ctypes.tar.gz
        https://github.com/nullgemm/dragonfail/archive/master.tar.gz -> dragonfail.tar.gz
        https://github.com/nullgemm/termbox_next/archive/master.tar.gz -> termbox_next.tar.gz"

LICENSE="WTFPL"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="sys-libs/pam
        x11-libs/libxcb
        x11-base/xorg-server
        x11-apps/xauth"
RDEPEND="${DEPEND}"
BDEPEND=""


src_prepare(){
        default
        for _i in argoat configator ctypes dragonfail termbox_next; do
                # rm -rf ${S}/sub/${_i}
                cp -r ${WORKDIR}/${_i}-master/* ${S}/sub/${_i}
	done
}