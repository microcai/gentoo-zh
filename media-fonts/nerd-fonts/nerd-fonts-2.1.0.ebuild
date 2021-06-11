# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font check-reqs

DESCRIPTION="Nerd Fonts is a project that patches developer targeted fonts with glyphs"
HOMEPAGE="https://github.com/ryanoasis/nerd-fonts"
COMMON_URI="https://github.com/ryanoasis/${PN}/releases/download/v${PV}"

FONTS=(
	3270
	Agave
	AnonymousPro
	Arimo
	AurulentSansMono
	BigBlueTerminal
	BitstreamVeraSansMono
	CascadiaCode
	CodeNewRoman
	Cousine
	DaddyTimeMono
	DejaVuSansMono
	DroidSansMono
	FantasqueSansMono
	FiraCode
	FiraMono
	Go-Mono
	Gohu
	Hack
	Hasklig
	HeavyData
	Hermit
	iA-Writer
	IBMPlexMono
	Inconsolata
	InconsolataGo
	InconsolataLGC
	Iosevka
	JetBrainsMono
	Lekton
	LiberationMono
	Meslo
	Monofur
	Monoid
	Mononoki
	MPlus
	Noto
	OpenDyslexic
	Overpass
	ProFont
	ProggyClean
	RobotoMono
	ShareTechMono
	SourceCodePro
	SpaceMono
	Terminus
	Tinos
	Ubuntu
	UbuntuMono
	VictorMono
)

SRC_URI="
	3270?					( "${COMMON_URI}/3270.zip" )
	agave?                  ( "${COMMON_URI}/Agave.zip" )
	anonymouspro?           ( "${COMMON_URI}/AnonymousPro.zip" )
	arimo?                  ( "${COMMON_URI}/Arimo.zip" )
	aurulentsansmono?       ( "${COMMON_URI}/AurulentSansMono.zip" )
	bigblueterminal?        ( "${COMMON_URI}/BigBlueTerminal.zip" )
	bitstreamverasansmono?  ( "${COMMON_URI}/BitstreamVeraSansMono.zip" )
	cascadiacode?           ( "${COMMON_URI}/CascadiaCode.zip" )
	codenewroman?           ( "${COMMON_URI}/CodeNewRoman.zip" )
	cousine?                ( "${COMMON_URI}/Cousine.zip" )
	daddytimemono?          ( "${COMMON_URI}/DaddyTimeMono.zip" )
	dejavusansmono?         ( "${COMMON_URI}/DejaVuSansMono.zip" )
	droidsansmono?          ( "${COMMON_URI}/DroidSansMono.zip" )
	fantasquesansmono?      ( "${COMMON_URI}/FantasqueSansMono.zip" )
	firacode?               ( "${COMMON_URI}/FiraCode.zip" )
	firamono?               ( "${COMMON_URI}/FiraMono.zip" )
	go-mono?                ( "${COMMON_URI}/Go-Mono.zip" )
	gohu?                   ( "${COMMON_URI}/Gohu.zip" )
	hack?                   ( "${COMMON_URI}/Hack.zip" )
	hasklig?                ( "${COMMON_URI}/Hasklig.zip" )
	heavydata?              ( "${COMMON_URI}/HeavyData.zip" )
	hermit?                 ( "${COMMON_URI}/Hermit.zip" )
	ia-writer?              ( "${COMMON_URI}/iA-Writer.zip" )
	ibmplexmono?            ( "${COMMON_URI}/IBMPlexMono.zip" )
	inconsolata?            ( "${COMMON_URI}/Inconsolata.zip" )
	inconsolatago?          ( "${COMMON_URI}/InconsolataGo.zip" )
	inconsolatalgc?         ( "${COMMON_URI}/InconsolataLGC.zip" )
	iosevka?                ( "${COMMON_URI}/Iosevka.zip" )
	jetbrainsmono?          ( "${COMMON_URI}/JetBrainsMono.zip" )
	lekton?                 ( "${COMMON_URI}/Lekton.zip" )
	liberationmono?         ( "${COMMON_URI}/LiberationMono.zip" )
	meslo?                  ( "${COMMON_URI}/Meslo.zip" )
	monofur?                ( "${COMMON_URI}/Monofur.zip" )
	monoid?                 ( "${COMMON_URI}/Monoid.zip" )
	mononoki?               ( "${COMMON_URI}/Mononoki.zip" )
	mplus?                  ( "${COMMON_URI}/MPlus.zip" )
	noto?                   ( "${COMMON_URI}/Noto.zip" )
	opendyslexic?           ( "${COMMON_URI}/OpenDyslexic.zip" )
	overpass?               ( "${COMMON_URI}/Overpass.zip" )
	profont?                ( "${COMMON_URI}/ProFont.zip" )
	proggyclean?            ( "${COMMON_URI}/ProggyClean.zip" )
	robotomono?             ( "${COMMON_URI}/RobotoMono.zip" )
	sharetechmono?          ( "${COMMON_URI}/ShareTechMono.zip" )
	sourcecodepro?          ( "${COMMON_URI}/SourceCodePro.zip" )
	spacemono?              ( "${COMMON_URI}/SpaceMono.zip" )
	terminus?               ( "${COMMON_URI}/Terminus.zip" )
	tinos?                  ( "${COMMON_URI}/Tinos.zip" )
	ubuntu?                 ( "${COMMON_URI}/Ubuntu.zip" )
	ubuntumono?             ( "${COMMON_URI}/UbuntuMono.zip" )
	victormono?             ( "${COMMON_URI}/VictorMono.zip" )
"

LICENSE="MIT
		OFL-1.1
		Apache-2.0
		CC-BY-SA-4.0
		BitstreamVera
		BSD
		WTFPL-2
		Vic-Fieger-License
		UbuntuFontLicense-1.0"
SLOT="0"
KEYWORDS="amd64 ~x86"

DEPEND="app-arch/unzip"
RDEPEND="media-libs/fontconfig"

CHECKREQS_DISK_BUILD="3G"
CHECKREQS_DISK_USR="4G"

IUSE_FLAGS=(${FONTS[*],,})
IUSE="${IUSE_FLAGS[*]}"
REQUIRED_USE="X || ( ${IUSE_FLAGS[*]} )"

S="${WORKDIR}"
FONT_CONF=(
	"${FILESDIR}"/10-nerd-font-symbols.conf
)
FONT_S=${S}

pkg_pretend() {
	check-reqs_pkg_setup
}

src_install() {
	declare -A font_filetypes
	local otf_file_number ttf_file_number

	otf_file_number=$(ls ${S} | grep -i otf | wc -l)
	ttf_file_number=$(ls ${S} | grep -i ttf | wc -l)

	if [[ ${otf_file_number} != 0 ]]; then
		font_filetypes[otf]=
	fi

	if [[ ${ttf_file_number} != 0 ]]; then
		font_filetypes[ttf]=
	fi

	FONT_SUFFIX="${!font_filetypes[@]}"

	font_src_install
}

pkg_postinst() {
	einfo "Installing font-patcher via an ebuild is hard, because paths are hardcoded differently"
	einfo "in .sh files. You can still get it and use it by git cloning the nerd-font project and"
	einfo "running it from the cloned directory."
	einfo "https://github.com/ryanoasis/nerd-fonts"

	elog "You might have to enable 50-user.conf and 10-nerd-font-symbols.conf by using"
	elog "eselect fontconfig"
}
