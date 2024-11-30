# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font unpacker

DESCRIPTION="A Noto-based font for traditional Chinese characters"
HOMEPAGE="https://github.com/GuiWonder/Shanggu"

MY_PN="Shanggu"

SRC_URI="
	mono? ( https://github.com/GuiWonder/${MY_PN}/releases/download/${PV}/${MY_PN}MonoTTFs.7z -> ${MY_PN}Mono-${PV}.7z )
	round? ( https://github.com/GuiWonder/${MY_PN}/releases/download/${PV}/${MY_PN}RoundTTFs.7z -> ${MY_PN}Round-${PV}.7z )
	sans? ( https://github.com/GuiWonder/${MY_PN}/releases/download/${PV}/${MY_PN}SansTTFs.7z -> ${MY_PN}Sans-${PV}.7z )
	serif? ( https://github.com/GuiWonder/${MY_PN}/releases/download/${PV}/${MY_PN}SerifTTFs.7z -> ${MY_PN}Serif-${PV}.7z )
"

S="${WORKDIR}"
LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="round sans +serif mono"
REQUIRED_USE="|| ( round sans serif mono )"
BDEPEND="
	app-arch/p7zip
"
FONT_CONF=( "${FILESDIR}/70-shanggu.conf" )
FONT_SUFFIX="ttf"
FONT_S=""

src_unpack() {
	use mono && unpack_7z "${MY_PN}Mono-${PV}.7z"
	use round && unpack_7z "${MY_PN}Round-${PV}.7z"
	use sans && unpack_7z "${MY_PN}Sans-${PV}.7z"
	use serif && unpack_7z "${MY_PN}Serif-${PV}.7z"
}

src_install() {
	FONT_S=()

	if use serif; then
		FONT_S+=(
			"${S}/${MY_PN}Serif"
			"${S}/${MY_PN}SerifFANTI"
			"${S}/${MY_PN}SerifJP"
			"${S}/${MY_PN}SerifSC"
			"${S}/${MY_PN}SerifTC"
		)
	fi

	if use sans; then
		FONT_S+=(
			"${S}/${MY_PN}Sans"
			"${S}/${MY_PN}SansFANTI"
			"${S}/${MY_PN}SansJP"
			"${S}/${MY_PN}SansSC"
			"${S}/${MY_PN}SansTC"
		)
	fi

	if use mono; then
		FONT_S+=(
			"${S}/${MY_PN}Mono"
			"${S}/${MY_PN}MonoJP"
			"${S}/${MY_PN}MonoSC"
			"${S}/${MY_PN}MonoTC"
		)
	fi

	if use round; then
		FONT_S+=(
			"${S}/${MY_PN}Round"
			"${S}/${MY_PN}RoundFANTI"
			"${S}/${MY_PN}RoundJP"
			"${S}/${MY_PN}RoundSC"
			"${S}/${MY_PN}RoundTC"
		)
	fi

	font_src_install
}
