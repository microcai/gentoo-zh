EAPI=8

MY_PN="moegirl.dict"
MY_PV="20220714"

DESCRIPTION="Fcitx 5 Pinyin Dictionary from zh.moegirl.org.cn"
HOMEPAGE="https://github.com/outloudvi/mw2fcitx"
SRC_URI="${HOMEPAGE}/releases/download/${MY_PV}/${MY_PN}"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="app-i18n/fcitx"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${DISTDIR}"

src_install(){
	DICT_PATH="/usr/share/fcitx5/pinyin/dictionaries"
	insinto ${DICT_PATH}
	doins ${MY_PN}
	fperms 0644 "${DICT_PATH}/${MY_PN}"
}

