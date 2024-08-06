# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

DESCRIPTION="The GUI for MongoDB"
HOMEPAGE="https://mongodb.com/compass https://github.com/mongodb-js/compass"
SRC_URI="https://downloads.mongodb.com/compass/mongodb-compass_${PV}_amd64.deb"

S="${WORKDIR}"
LICENSE="SSPL-1"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	default

	insinto /usr/lib/mongodb-compass
	doins -r usr/lib/mongodb-compass/.

	domenu usr/share/applications/mongodb-compass.desktop
	doicon usr/share/pixmaps/mongodb-compass.png

	fperms +x "/usr/lib/mongodb-compass/MongoDB Compass"
	fperms 4755 /usr/lib/mongodb-compass/chrome-sandbox
	fperms 4755 /usr/lib/mongodb-compass/chrome_crashpad_handler

	# Included binary doesn't work, make a symlink instead
	rm usr/bin/mongodb-compass || die
	dosym "../lib/mongodb-compass/MongoDB Compass" "usr/bin/mongodb-compass"
}
