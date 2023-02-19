# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop

DESCRIPTION="Typora will give you a seamless experience as both a reader and a writer."
HOMEPAGE="https://typora.io"
SRC_URI="https://hougearch.litterhougelangley.club/src/typora_${PV}_amd64.deb"

#TODO : update license
LICENSE="typora"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="mirror"

DEPEND=""
RDEPEND="
	x11-libs/libXScrnSaver
	${DEPEND}"
BDEPEND=""

QA_PREBUILT="*"

src_unpack() {
	default
	unpack "${WORKDIR}"/data.tar.xz
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
	dosym "../../opt/typora/bin/typora" "usr/bin/typora"

	domenu share/applications/typora.desktop
}

pkg_postinst() {
	update-desktop-database
}
