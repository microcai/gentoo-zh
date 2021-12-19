# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

DESCRIPTION="Zen monitor is monitoring software for AMD Zen-based CPUs"
HOMEPAGE="https://github.com/ocerman/zenmonitor"
KEYWORDS="~amd64"
SRC_URI="https://github.com/ocerman/${PN}/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
IUSE="policykit"
RESTRICT="mirror"

DEPEND="x11-libs/gtk+:3
	sys-kernel/zenpower"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}.patch
)

src_prepare() {
	default
	pushd data > /dev/null || die
	for i in org.pkexec.zenmonitor.policy zenmonitor-root.desktop zenmonitor.desktop; do
		mv $i.in $i || die
	done
	popd > /dev/null || die
}

src_compile() {
	make
}

src_install() {
	dobin zenmonitor
	domenu data/zenmonitor.desktop

	if use policykit; then
		mkdir -p "${D}"/usr/share/polkit-1/actions || die
		cp data/org.pkexec.zenmonitor.policy "${D}"/usr/share/polkit-1/actions/ || die
		domenu data/zenmonitor-root.desktop
	fi
}
