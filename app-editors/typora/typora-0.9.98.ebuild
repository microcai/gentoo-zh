# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Typora will give you a seamless experience as both a reader and a writer."
HOMEPAGE="https://typora.io"
SRC_URI="https://www.typora.io/linux/typora_${PV}_amd64.deb"

#TODO : update license
LICENSE="EULA"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="mirror"

DEPEND=""
RDEPEND="
	x11-libs/libXScrnSaver
	${DEPEND}"
BDEPEND=""

QA_PRESTRIPPED="
	/opt/${PN}/share/typora/Typora
	/opt/${PN}/share/typora/chrome-sandbox
	/opt/${PN}/share/typora/.*\.so
	/opt/${PN}/share/typora/.*/.*\.so
	/opt/${PN}/share/typora/resources/app/node_modules/vscode-ripgrep/bin/rg
	/opt/${PN}/share/typora/resources/app/node_modules/pathwatcher/build/Release/pathwatcher.node
	/opt/${PN}/share/typora/resources/app/node_modules/spellchecker/build/Release/spellchecker.node
	/opt/${PN}/share/typora/resources/app/node_modules/spellchecker/node_modules/cld/build/Release/cld.node
"

src_unpack() {
	default
	unpack ${WORKDIR}/data.tar.xz
	S="${WORKDIR}/usr"
}

src_install() {
	local dir="/opt/${PN}"

	insinto "${dir}"
	rm -rf share/lintian
	sed -i '/Change Log/d' share/applications/typora.desktop
	doins -r bin share

	fperms 0755 "${dir}/bin/typora"
	fperms 4755 "${dir}/share/typora/chrome-sandbox"
	dosym /opt/typora/bin/typora /usr/bin/typora

	insinto /usr/share/applications/
	doins share/applications/typora.desktop
}

pkg_postinst() {
	update-desktop-database
}
