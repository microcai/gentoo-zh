EAPI=8
inherit git-r3

DESCRIPTION="Ori theme for Fcitx5"
HOMEPAGE="https://github.com/Reverier-Xu/Ori-fcitx5"
EGIT_REPO_URI="https://github.com/Reverier-Xu/Ori-fcitx5.git"
EGIT_BRANCH="master"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="app-i18n/fcitx:5"
DEPEND="${RDEPEND}"

src_install() {
	insinto /usr/share/fcitx5/themes/
	doins -r "${S}"/OriLight
	doins -r "${S}"/OriDark
}
