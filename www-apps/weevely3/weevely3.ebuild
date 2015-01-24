# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Weaponized web shell"
HOMEPAGE="https://github.com/epinna/weevely"
EGIT_REPO_URI="https://github.com/epinna/${PN}.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/tempita
		dev-python/mako
		dev-python/prettytable
		dev-python/pyyaml
		dev-python/python-dateutil""
RDEPEND="${DEPEND}"

PYTHON_COMPAT={python_2}

src_install(){
	dodir /opt/weevely3/
	insinto /opt/weevely3/ 
	elog "Install successful"
}
