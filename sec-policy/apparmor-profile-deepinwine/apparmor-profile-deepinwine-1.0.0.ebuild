# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A collection of AppArmor profiles for Deepinwine6"
HOMEPAGE="https://gitlab.com/apparmor/apparmor/wikis/home"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"

RDEPEND="sec-policy/apparmor-profiles"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_install() {
	insinto /etc/apparmor.d
	doins -r "${FILESDIR}"/opt.deepinwine6
}
