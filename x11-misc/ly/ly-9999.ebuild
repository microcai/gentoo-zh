# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="Ly - a TUI display manager"
HOMEPAGE="https://github.com/nullgemm/ly"

if [ "${PV}" = "9999" ]; then
	EGIT_REPO_URI="https://github.com/nullgemm/ly.git"
	EGIT_CLONE_TYPE="shallow"
	inherit git-r3
else
	KEYWORDS="~amd64"

	# Latest hash of each submodule's master branch
	ARGOAT="e1844c4c94b70bb351ec2bd2ac6bb320ee793d8f"
	CONFIGATOR="8cec1786196ae6f6a8b35e66181277457f2a2bb2"
	DRAGONFAIL="15bd3299bf3e49bd6734bff385cb0392cd2fa502"
	TERMBOX="d961a8122210010e7c2c8f201e61170c13d319b4"
	# This is a submodule for a submodule(argoat)
	TESTOASTERROR="ee7c9d031d4632a6f381a6c174a38539bac04068"

	SRC_URI="https://github.com/nullgemm/ly/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/nullgemm/argoat/archive/${ARGOAT}.tar.gz -> argoat.tar.gz
	https://github.com/nullgemm/configator/archive/${CONFIGATOR}.tar.gz -> configator.tar.gz
	https://github.com/nullgemm/dragonfail/archive/${DRAGONFAIL}.tar.gz -> dragonfail.tar.gz
	https://github.com/nullgemm/termbox_next/archive/${TERMBOX}.tar.gz -> termbox_next.tar.gz
	https://github.com/nullgemm/testoasterror/archive/${TESTOASTERROR}.tar.gz -> testoasterror.tar.gz
	"
fi

SUB="${S}/sub"
RES="${S}/res"

LICENSE="WTFPL-2"
SLOT="0"

DEPEND="sys-libs/pam
x11-libs/libxcb
x11-base/xorg-server
x11-apps/xauth"

RDEPEND="${DEPEND}"

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
	else
		default

		mv "argoat-${ARGOAT}/"* "${SUB}/argoat" || die
		mv "testoasterror-${TESTOASTERROR}/"* "${SUB}/argoat/sub/testoasterror" || die
		mv "configator-${CONFIGATOR}/"* "${SUB}/configator" || die
		mv "dragonfail-${DRAGONFAIL}/"* "${SUB}/dragonfail" || die
		mv "termbox_next-${TERMBOX}/"* "${SUB}/termbox_next" || die
	fi
}

src_install(){
	default

	newinitd "${RES}/${PN}-openrc" ly
	systemd_dounit "${RES}/${PN}.service"
}

pkg_postinst() {
	systemd_reenable "${PN}.service"

	ewarn
	ewarn "The init scripts are installed only for systemd/openrc"
	ewarn "If you are using something else like runit etc."
	ewarn "Please check upstream for get some help"
	ewarn "If you are using a window manager as DWM"
	ewarn "Please make sure there is a .desktop file in /usr/share/xsessions for it"
}
