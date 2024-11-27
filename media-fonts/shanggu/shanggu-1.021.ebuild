# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font unpacker

DESCRIPTION="A Noto-based font for traditional Chinese characters"
HOMEPAGE="https://github.com/GuiWonder/Shanggu"

FONTNAME="Shanggu"

SRC_URI="
	mono? ( https://github.com/GuiWonder/${FONTNAME}/releases/download/${PV}/${FONTNAME}MonoTTFs.7z -> ${FONTNAME}Mono-${PV}.7z )
	round? ( https://github.com/GuiWonder/${FONTNAME}/releases/download/${PV}/${FONTNAME}RoundTTFs.7z -> ${FONTNAME}Round-${PV}.7z )
	sans? ( https://github.com/GuiWonder/${FONTNAME}/releases/download/${PV}/${FONTNAME}SansTTFs.7z -> ${FONTNAME}Sans-${PV}.7z )
	serif? ( https://github.com/GuiWonder/${FONTNAME}/releases/download/${PV}/${FONTNAME}SerifTTFs.7z -> ${FONTNAME}Serif-${PV}.7z )
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

FONT_SUFFIX="ttf"

src_unpack() {
	use mono && unpack_7z "${FONTNAME}Mono-${PV}.7z"
	use round && unpack_7z "${FONTNAME}Round-${PV}.7z"
	use sans && unpack_7z "${FONTNAME}Sans-${PV}.7z"
	use serif && unpack_7z "${FONTNAME}Serif-${PV}.7z"
}

src_install() {
	if use serif; then
		FONT_S=(
			"${S}/${FONTNAME}Serif"
			"${S}/${FONTNAME}SerifFANTI"
			"${S}/${FONTNAME}SerifJP"
			"${S}/${FONTNAME}SerifSC"
			"${S}/${FONTNAME}SerifTC"
		)
		font_src_install
	fi

	if use sans; then
		FONT_S=(
			"${S}/${FONTNAME}Sans"
			"${S}/${FONTNAME}SansFANTI"
			"${S}/${FONTNAME}SansJP"
			"${S}/${FONTNAME}SansSC"
			"${S}/${FONTNAME}SansTC"
		)
		font_src_install
	fi

	if use mono; then
		FONT_S=(
			"${S}/${FONTNAME}Mono"
			"${S}/${FONTNAME}MonoJP"
			"${S}/${FONTNAME}MonoSC"
			"${S}/${FONTNAME}MonoTC"
		)
		font_src_install
	fi

	if use round; then
		FONT_S=(
			"${S}/${FONTNAME}Round"
			"${S}/${FONTNAME}RoundFANTI"
			"${S}/${FONTNAME}RoundJP"
			"${S}/${FONTNAME}RoundSC"
			"${S}/${FONTNAME}RoundTC"
		)
		font_src_install
	fi
}
