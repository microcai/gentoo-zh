# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font check-reqs

DESCRIPTION="Nerd Fonts is a project that patches developer targeted fonts with glyphs"
HOMEPAGE="https://github.com/ryanoasis/nerd-fonts"
COMMON_URI="https://github.com/ryanoasis/${PN}/releases/download/v${PV}"
TAG_URI="https://github.com/ryanoasis/nerd-fonts/raw/v${PV}"

FONTS=(
	0xProto
	3270
	AdwaitaMono
	Agave
	AnonymousPro
	Arimo
	AtkinsonHyperlegibleMono
	AurulentSansMono
	BigBlueTerminal
	BitstreamVeraSansMono
	CascadiaCode
	CascadiaMono
	CodeNewRoman
	ComicShannsMono
	CommitMono
	Cousine
	D2Coding
	DaddyTimeMono
	DejaVuSansMono
	DepartureMono
	DroidSansMono
	EnvyCodeR
	FantasqueSansMono
	FiraCode
	FiraMono
	GeistMono
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
	IntelOneMono
	Iosevka
	IosevkaTerm
	IosevkaTermSlab
	JetBrainsMono
	Lekton
	LiberationMono
	Lilex
	MartianMono
	Meslo
	Monaspace
	Monofur
	Monoid
	Mononoki
	MPlus
	NerdFontsSymbolsOnly
	Noto
	OpenDyslexic
	Overpass
	ProFont
	ProggyClean
	Recursive
	RobotoMono
	ShareTechMono
	SourceCodePro
	SpaceMono
	Terminus
	Tinos
	Ubuntu
	UbuntuMono
	UbuntuSans
	VictorMono
	ZedMono
)

SRC_URI="
	0xproto? ( ${COMMON_URI}/0xProto.zip -> 0xProto-nf-${PV}.zip )
	3270? ( ${COMMON_URI}/3270.zip -> 3270-nf-${PV}.zip )
	adwaitamono? ( ${COMMON_URI}/AdwaitaMono.zip -> AdwaitaMono-nf-${PV}.zip )
	agave? ( ${COMMON_URI}/Agave.zip -> Agave-nf-${PV}.zip )
	anonymouspro? ( ${COMMON_URI}/AnonymousPro.zip -> AnonymousPro-nf-${PV}.zip )
	arimo? ( ${COMMON_URI}/Arimo.zip -> Arimo-nf-${PV}.zip )
	atkinsonhyperlegiblemono? ( ${COMMON_URI}/AtkinsonHyperlegibleMono.zip -> AtkinsonHyperlegibleMono-nf-${PV}.zip )
	aurulentsansmono? ( ${COMMON_URI}/AurulentSansMono.zip -> AurulentSansMono-nf-${PV}.zip )
	bigblueterminal? ( ${COMMON_URI}/BigBlueTerminal.zip -> BigBlueTerminal-nf-${PV}.zip )
	bitstreamverasansmono? ( ${COMMON_URI}/BitstreamVeraSansMono.zip -> BitstreamVeraSansMono-nf-${PV}.zip )
	cascadiacode? ( ${COMMON_URI}/CascadiaCode.zip -> CascadiaCode-nf-${PV}.zip )
	cascadiamono? ( ${COMMON_URI}/CascadiaMono.zip -> CascadiaMono-nf-${PV}.zip )
	codenewroman? ( ${COMMON_URI}/CodeNewRoman.zip -> CodeNewRoman-nf-${PV}.zip )
	comicshannsmono? ( ${COMMON_URI}/ComicShannsMono.zip -> ComicShannsMono-nf-${PV}.zip )
	commitmono? ( ${COMMON_URI}/CommitMono.zip -> CommitMono-nf-${PV}.zip )
	cousine? ( ${COMMON_URI}/Cousine.zip -> Cousine-nf-${PV}.zip )
	d2coding? ( ${COMMON_URI}/D2Coding.zip -> D2Coding-nf-${PV}.zip )
	daddytimemono? ( ${COMMON_URI}/DaddyTimeMono.zip -> DaddyTimeMono-nf-${PV}.zip )
	dejavusansmono? ( ${COMMON_URI}/DejaVuSansMono.zip -> DejaVuSansMono-nf-${PV}.zip )
	departuremono? ( ${COMMON_URI}/DepartureMono.zip -> DepartureMono-nf-${PV}.zip )
	droidsansmono? ( ${COMMON_URI}/DroidSansMono.zip -> DroidSansMono-nf-${PV}.zip )
	envycoder? ( ${COMMON_URI}/EnvyCodeR.zip -> EnvyCodeR-nf-${PV}.zip )
	fantasquesansmono? ( ${COMMON_URI}/FantasqueSansMono.zip -> FantasqueSansMono-nf-${PV}.zip )
	firacode? ( ${COMMON_URI}/FiraCode.zip -> FiraCode-nf-${PV}.zip )
	firamono? ( ${COMMON_URI}/FiraMono.zip -> FiraMono-nf-${PV}.zip )
	geistmono? ( ${COMMON_URI}/GeistMono.zip -> GeistMono-nf-${PV}.zip )
	go-mono? ( ${COMMON_URI}/Go-Mono.zip -> Go-Mono-nf-${PV}.zip )
	gohu? ( ${COMMON_URI}/Gohu.zip -> Gohu-nf-${PV}.zip )
	hack? ( ${COMMON_URI}/Hack.zip -> Hack-nf-${PV}.zip )
	hasklig? ( ${COMMON_URI}/Hasklig.zip -> Hasklig-nf-${PV}.zip )
	heavydata? ( ${COMMON_URI}/HeavyData.zip -> HeavyData-nf-${PV}.zip )
	hermit? ( ${COMMON_URI}/Hermit.zip -> Hermit-nf-${PV}.zip )
	ia-writer? ( ${COMMON_URI}/iA-Writer.zip -> iA-Writer-nf-${PV}.zip )
	ibmplexmono? ( ${COMMON_URI}/IBMPlexMono.zip -> IBMPlexMono-nf-${PV}.zip )
	inconsolata? ( ${COMMON_URI}/Inconsolata.zip -> Inconsolata-nf-${PV}.zip )
	inconsolatago? ( ${COMMON_URI}/InconsolataGo.zip -> InconsolataGo-nf-${PV}.zip )
	inconsolatalgc? ( ${COMMON_URI}/InconsolataLGC.zip -> InconsolataLGC-nf-${PV}.zip )
	intelonemono? ( ${COMMON_URI}/IntelOneMono.zip -> IntelOneMono-nf-${PV}.zip )
	iosevka? ( ${COMMON_URI}/Iosevka.zip -> Iosevka-nf-${PV}.zip )
	iosevkaterm? ( ${COMMON_URI}/IosevkaTerm.zip -> IosevkaTerm-nf-${PV}.zip )
	iosevkatermslab? ( ${COMMON_URI}/IosevkaTermSlab.zip -> IosevkaTermSlab-nf-${PV}.zip )
	jetbrainsmono? ( ${COMMON_URI}/JetBrainsMono.zip -> JetBrainsMono-nf-${PV}.zip )
	lekton? ( ${COMMON_URI}/Lekton.zip -> Lekton-nf-${PV}.zip )
	liberationmono? ( ${COMMON_URI}/LiberationMono.zip -> LiberationMono-nf-${PV}.zip )
	lilex? ( ${COMMON_URI}/Lilex.zip -> Lilex-nf-${PV}.zip )
	martianmono? ( ${COMMON_URI}/MartianMono.zip -> MartianMono-nf-${PV}.zip )
	meslo? ( ${COMMON_URI}/Meslo.zip -> Meslo-nf-${PV}.zip )
	monaspace? ( ${COMMON_URI}/Monaspace.zip -> Monaspace-nf-${PV}.zip )
	monofur? ( ${COMMON_URI}/Monofur.zip -> Monofur-nf-${PV}.zip )
	monoid? ( ${COMMON_URI}/Monoid.zip -> Monoid-nf-${PV}.zip )
	mononoki? ( ${COMMON_URI}/Mononoki.zip -> Mononoki-nf-${PV}.zip )
	mplus? ( ${COMMON_URI}/MPlus.zip -> MPlus-nf-${PV}.zip )
	nerdfontssymbolsonly? ( ${COMMON_URI}/NerdFontsSymbolsOnly.zip -> NerdFontsSymbolsOnly-nf-${PV}.zip )
	noto? ( ${COMMON_URI}/Noto.zip -> Noto-nf-${PV}.zip )
	opendyslexic? ( ${COMMON_URI}/OpenDyslexic.zip -> OpenDyslexic-nf-${PV}.zip )
	overpass? ( ${COMMON_URI}/Overpass.zip -> Overpass-nf-${PV}.zip )
	profont? ( ${COMMON_URI}/ProFont.zip -> ProFont-nf-${PV}.zip )
	proggyclean? ( ${COMMON_URI}/ProggyClean.zip -> ProggyClean-nf-${PV}.zip )
	recursive? ( ${COMMON_URI}/Recursive.zip -> Recursive-nf-${PV}.zip )
	robotomono? ( ${COMMON_URI}/RobotoMono.zip -> RobotoMono-nf-${PV}.zip )
	sharetechmono? ( ${COMMON_URI}/ShareTechMono.zip -> ShareTechMono-nf-${PV}.zip )
	sourcecodepro? ( ${COMMON_URI}/SourceCodePro.zip -> SourceCodePro-nf-${PV}.zip )
	spacemono? ( ${COMMON_URI}/SpaceMono.zip -> SpaceMono-nf-${PV}.zip )
	terminus? ( ${COMMON_URI}/Terminus.zip -> Terminus-nf-${PV}.zip )
	tinos? ( ${COMMON_URI}/Tinos.zip -> Tinos-nf-${PV}.zip )
	ubuntu? ( ${COMMON_URI}/Ubuntu.zip -> Ubuntu-nf-${PV}.zip )
	ubuntumono? ( ${COMMON_URI}/UbuntuMono.zip -> UbuntuMono-nf-${PV}.zip )
	ubuntusans? ( ${COMMON_URI}/UbuntuSans.zip -> UbuntuSans-nf-${PV}.zip )
	victormono? ( ${COMMON_URI}/VictorMono.zip -> VictorMono-nf-${PV}.zip )
	zedmono? ( ${COMMON_URI}/ZedMono.zip -> ZedMono-nf-${PV}.zip )
"
S="${WORKDIR}"
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
KEYWORDS="~amd64 ~loong ~x86"

DEPEND="app-arch/unzip"
RDEPEND="media-libs/fontconfig"

CHECKREQS_DISK_BUILD="3G"
CHECKREQS_DISK_USR="4G"

IUSE_FLAGS=(${FONTS[*],,})
IUSE="+nerdfontssymbolsonly ${IUSE_FLAGS[*]}"
REQUIRED_USE="|| ( nerdfontssymbolsonly ${IUSE_FLAGS[*]} )"

FONT_S=${S}

pkg_pretend() {
	check-reqs_pkg_setup
}

src_install() {
	declare -A font_filetypes
	local otf_file_number ttf_file_number

	otf_file_number=$(ls "${S}" | grep -i otf | wc -l)
	ttf_file_number=$(ls "${S}" | grep -i ttf | wc -l)

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

	elog "You might have to enable 50-user.conf by using"
	elog "eselect fontconfig"
}
