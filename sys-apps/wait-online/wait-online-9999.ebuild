# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit git-r3 systemd python-r1

DESCRIPTION="Wait until we're connected to the Internet"
HOMEPAGE="https://github.com/lilydjwg/wait-online"
EGIT_REPO_URI="https://github.com/lilydjwg/wait-online"

LICENSE="GPL-3"
SLOT="0"
# KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	${PYTHON_DEPS}
	dev-python/python-systemd[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

src_install(){
	# python_fix_shebang wait-online check-online
	dobin wait-online check-online
	python_replicate_script "${ED}"/usr/bin/{wait-online,check-online}
	systemd_dounit wait-online.service wait-online-onresume.service
	insinto /usr/lib/tmpfiles.d/
	newins tmpfiles.conf ${PN}.conf
	dosym ../network-online.target /usr/lib/systemd/system/multi-user.target.wants/network-online.target
}
