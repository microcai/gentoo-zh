# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit git-2

DESCRIPTION="A runtime for javascript applictions built on google v8 JS"
HOMEPAGE="http://fibjs.org"
SRC_URI=""

EGIT_REPO_URI="https://github.com/xicilion/fibjs.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	./build Release
}

src_install() {
	dobin bin/Linux_Release/fibjs
}
