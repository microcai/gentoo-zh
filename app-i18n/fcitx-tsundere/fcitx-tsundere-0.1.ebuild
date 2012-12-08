# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit cmake-utils
DESCRIPTION="Fcitx Tsundere Addon"
HOMEPAGE="https://github.com/felixonmars/fcitx-tsundere"
SRC_URI="https://github.com/felixonmars/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
>=app-i18n/fcitx-4.2.0"

