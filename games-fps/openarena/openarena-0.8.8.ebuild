EAPI=8
inherit desktop

DESCRIPTION="A violent, sexy, multiplayer first person shooter based on the ioquake3 engine"
HOMEPAGE="http://openarena.ws/"
SRC_URI="https://psychz.dl.sourceforge.net/project/oarena/${P}.zip?viasf=1 -> ${P}.zip"
inherit git-r3
EGIT_REPO_URI="https://github.com/OpenArena/legacy"

LICENSE="GPL-2+"

SLOT="0"

KEYWORDS="amd64 x86"

BDEPEND="
	app-arch/unzip
"

DEPEND="
	media-libs/libvorbis
	net-misc/curl
	media-libs/openal
	media-libs/libxmp
	media-libs/libsdl
	!games-fps/openarena-bin
"
RDEPEND="${DEPEND}"

src_unpack() {
	git-r3_src_unpack
	mkdir -p "${S}"
	unzip "${DISTDIR}/${P}.zip" -d "${S}"
}

src_compile() {
	if use amd64; then
		COMPILE_ARCH=x86_64
		ARCH=x86_64
	fi
	cd "${S}/engine/openarena-engine-source-0.8.8"
	emake || die "Compilation of engine failed"
}

src_install() {
	mkdir -p "${D}/opt/openarena/{baseoa,missionpack}"
	cp -r "${S}/engine/openarena-engine-source-0.8.8/build/*/*" "${D}/opt/openarena/"

	install -Dm644 "${S}/${P}/baseoa/*.pk3" -t "${D}/opt/openarena/baseoa/"
	install -Dm644 "${S}/${P}/missionpack/*.pk3" -t "${D}/opt/openarena/missionpack/"

	domenu "${FILESDIR}/openarena.desktop"
	domenu "${FILESDIR}/openarena-server.desktop"
	doicon "${FILESDIR}/openarena.png"
	doicon "${FILESDIR}/openarena-server.png"

	install -Dm755 "${FILESDIR}/openarena-runner.sh" "${D}/opt/openarena/openarena-runner.sh"
	dosym /opt/openarena/openarena-runner.sh /usr/bin/openarena
	dosym /opt/openarena/openarena-runner.sh /usr/bin/openarena-server
}
