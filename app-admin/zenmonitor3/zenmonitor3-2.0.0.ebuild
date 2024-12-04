# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg

DESCRIPTION="Zen monitor is monitoring software for AMD Zen-based CPUs"
HOMEPAGE="https://git.exozy.me/a/zenmonitor3"

if [[ ${PV} == 9999 ]] ; then
	EGIT_REPO_URI="https://git.exozy.me/a/zenpower3.git"
	inherit git-r3
else
	SRC_URI="https://git.exozy.me/a/zenmonitor3/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+polkit"

DEPEND="
	x11-libs/gtk+:3
	sys-kernel/zenpower3
	polkit? ( sys-auth/polkit )
"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${ED}" PREFIX=/usr install
	sed -i "s#${ED}##" "${ED}/usr/share/applications/zenmonitor.desktop" || die

	if use polkit; then
		mkdir -p "${ED}/usr/share/polkit-1/actions" || die
		emake DESTDIR="${ED}" PREFIX=/usr install-polkit
		sed -i "s#${ED}##" "${ED}/usr/share/applications/zenmonitor-root.desktop" || die
		sed -i "s#${ED}##" "${ED}/usr/share/polkit-1/actions/org.pkexec.zenmonitor.policy" || die
	fi

	local DOCS=( README.md )
	einstalldocs
}
