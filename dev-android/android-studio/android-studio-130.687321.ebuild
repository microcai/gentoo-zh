# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit eutils user

DESCRIPTION="a new Android development environment based on IntelliJ IDEA"
HOMEPAGE="https://developer.android.com/sdk/installing/studio.html"
SRC_URI="http://dl.google.com/android/studio/android-studio-bundle-${PV}-linux.tgz -> ${P}.tgz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
virtual/jdk"

RESTRICT="strip test"

STUDIO_DIR="/opt/${PN}"

QA_PREBUILT="*"


S="${WORKDIR}/${PN}"

pkg_setup() {
	enewgroup android
}

src_install() {
	local dest=/opt/${PN}
	rm bin/studio.sh
	cp "${FILESDIR}"/studio.sh bin # remove the read command

	dodir "${STUDIO_DIR}"
	cp -pPR ./* ${ED}/"${STUDIO_DIR}"

	fperms 0775 "${STUDIO_DIR}"/{,bin,bin/studio.sh,lib,sdk}
	fowners root:android "${dest}"/{,sdk,bin,lib,license,plugins}

	make_desktop_entry "${dest}/bin/studio.sh" " Android Studio" "${dest}/bin/idea.png"
}

