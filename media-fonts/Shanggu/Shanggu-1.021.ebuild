# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font unpacker

DESCRIPTION="A Noto-based font for traditional Chinese characters"
HOMEPAGE="https://github.com/GuiWonder/Shanggu"

SRC_URI="
	mono? ( https://github.com/GuiWonder/${PN}/releases/download/${PV}/${PN}MonoTTFs.7z -> ${PN}Mono-${PV}.7z )
	round? ( https://github.com/GuiWonder/${PN}/releases/download/${PV}/${PN}RoundTTFs.7z -> ${PN}Round-${PV}.7z )
	sans? ( https://github.com/GuiWonder/${PN}/releases/download/${PV}/${PN}SansTTFs.7z -> ${PN}Sans-${PV}.7z )
	serif? ( https://github.com/GuiWonder/${PN}/releases/download/${PV}/${PN}SerifTTFs.7z -> ${PN}Serif-${PV}.7z )
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
	use mono && unpack_7z "${PN}Mono-${PV}.7z"
	use round && unpack_7z "${PN}Round-${PV}.7z"
	use sans && unpack_7z "${PN}Sans-${PV}.7z"
	use serif && unpack_7z "${PN}Serif-${PV}.7z"
}

src_install() {
	if use serif; then
		FONT_S=(
			"${S}/${PN}Serif"
			"${S}/${PN}SerifFANTI"
			"${S}/${PN}SerifJP"
			"${S}/${PN}SerifSC"
			"${S}/${PN}SerifTC"
		)
		font_src_install
	fi

	if use sans; then
		FONT_S=(
			"${S}/${PN}Sans"
			"${S}/${PN}SansFANTI"
			"${S}/${PN}SansJP"
			"${S}/${PN}SansSC"
			"${S}/${PN}SansTC"
		)
		font_src_install
	fi

	if use mono; then
		FONT_S=(
			"${S}/${PN}Mono"
			"${S}/${PN}MonoJP"
			"${S}/${PN}MonoSC"
			"${S}/${PN}MonoTC"
		)
		font_src_install
	fi

	if use round; then
		FONT_S=(
			"${S}/${PN}Round"
			"${S}/${PN}RoundFANTI"
			"${S}/${PN}RoundJP"
			"${S}/${PN}RoundSC"
			"${S}/${PN}RoundTC"
		)
		font_src_install
	fi
}
