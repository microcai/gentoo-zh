# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

DESCRIPTION="The GUI for MongoDB"
HOMEPAGE="https://mongodb.com/compass https://github.com/mongodb-js/compass"
SRC_URI="https://github.com/mongodb-js/compass/releases/download/v${PV}/mongodb-compass_${PV}_amd64.deb"

LICENSE="SSPL-1"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}"

src_install() {
	default

	insinto /usr/lib/mongodb-compass
	doins -r usr/lib/mongodb-compass/.

	domenu usr/share/applications/mongodb-compass.desktop
	doicon usr/share/pixmaps/mongodb-compass.png

	fperms +x "/usr/lib/mongodb-compass/MongoDB Compass"
	fperms 4755 /usr/lib/mongodb-compass/chrome-sandbox

	# Included binary doesn't work, make a symlink instead
	rm usr/bin/mongodb-compass || die
	dosym "../lib/mongodb-compass/MongoDB Compass" "usr/bin/mongodb-compass"
}
