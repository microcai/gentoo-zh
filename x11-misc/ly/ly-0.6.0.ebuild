# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# Latest hash of each submodule's master branch
ARGOAT="e1844c4c94b70bb351ec2bd2ac6bb320ee793d8f"
CONFIGATOR="8cec1786196ae6f6a8b35e66181277457f2a2bb2"
DRAGONFAIL="15bd3299bf3e49bd6734bff385cb0392cd2fa502"
TERMBOX="d961a8122210010e7c2c8f201e61170c13d319b4"
TESTOASTERROR="ee7c9d031d4632a6f381a6c174a38539bac04068"

DESCRIPTION="Ly - a TUI display manager"
HOMEPAGE="https://github.com/nullgemm/ly"
SRC_URI="https://github.com/nullgemm/ly/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
https://github.com/nullgemm/argoat/archive/${ARGOAT}.tar.gz -> argoat.tar.gz
https://github.com/nullgemm/configator/archive/${CONFIGATOR}.tar.gz -> configator.tar.gz
https://github.com/nullgemm/dragonfail/archive/${DRAGONFAIL}.tar.gz -> dragonfail.tar.gz
https://github.com/nullgemm/termbox_next/archive/${TERMBOX}.tar.gz -> termbox_next.tar.gz
https://github.com/nullgemm/testoasterror/archive/${TESTOASTERROR}.tar.gz -> testoasterror.tar.gz
"
SUB="${S}/sub/"

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

	# Trim commit ids
	for _i in argoat configator dragonfail termbox_next testoasterror; do
		mv ${_i}-* ${_i} || die
	done

	# Move testoasterror to argoat/sub
	cp -r testoasterror argoat/sub/ || die

	# Move submodules to ly's sub dir
	for _i in argoat configator dragonfail termbox_next; do
		cp -r ${_i} ${SUB} || die
	done
}
