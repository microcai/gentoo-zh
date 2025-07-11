EAPI=8

DESCRIPTION="A violent, sexy, multiplayer first person shooter based on the ioquake3 engine"
HOMEPAGE="http://openarena.ws/"

SRC_URI="https://psychz.dl.sourceforge.net/project/oarena/openarena-${PV}.zip?viasf=1 -> openarena-${PV}.zip"

S="${WORKDIR}/openarena-${PV}"

LICENSE="GPL-3"

SLOT="0"

KEYWORDS="amd64 x86"

BDEPEND="
	app-arch/unzip
"

DEPEND="
	${COMMON_DEPENDS}
	media-libs/libvorbis
	net-misc/curl
	media-libs/openal
	media-libs/libxmp
	media-libs/libsdl
"
RDEPEND="${DEPEND}"

src_configure(){
	rm *.dll *.exe
	rm -rf __MACOSX *.app
}

src_install() {
	install -dm 755 "${D}/opt" "${D}/usr/share/pixmaps/" "${D}/usr/share/applications/" "${D}/usr/bin"
	mv "${S}" "${D}/opt/openarena"
	find "${D}/opt/openarena" -type f -exec chmod 644 {} \;
	find "${D}/opt/openarena" -type d -exec chmod 755 {} \;
	chmod 755 "${D}/opt/openarena/openarena.x86_64" "${D}/opt/openarena/openarena.i386"

	install -Dm 644 "${FILESDIR}/openarena.png" "${D}/usr/share/pixmaps/"
	install -Dm 644 "${FILESDIR}/openarena-server.png" "${D}/usr/share/pixmaps/"
	install -Dm 644 "${FILESDIR}/openarena.desktop" "${D}/usr/share/applications/"
	install -Dm 644 "${FILESDIR}/openarena-server.desktop" "${D}/usr/share/applications/"

	install -Dm 755 "${FILESDIR}/openarena-runner.sh" "${D}/opt/openarena/openarena-runner.sh"
	ln -s /opt/openarena/openarena-runner.sh "${D}/usr/bin/openarena"
	ln -s /opt/openarena/openarena-runner.sh "${D}/usr/bin/openarena-server"
}
