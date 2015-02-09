# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit git-2 eutils

DESCRIPTION="Weaponized web shell"
HOMEPAGE="https://github.com/epinna/weevely3"
SRC_URL=""

EGIT_REPO_URI="https://git@github.com/epinna/weevely3.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

PYTHON_COMPAT=( python2_7 )
DEPEND=""
RDEPEND="${DEPEND}
		dev-python/tempita
		dev-python/mako
		dev-python/prettytable
		dev-python/pyyaml
		dev-python/python-dateutil"

src_install(){
	dodir /opt/${PN}
	mv "$S"/* "$D"/opt/${PN}
}
