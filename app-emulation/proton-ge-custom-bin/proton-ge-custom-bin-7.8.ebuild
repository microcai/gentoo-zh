# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A fancy custom distribution of Valves Proton with various patches"
HOMEPAGE="https://github.com/GloriousEggroll/proton-ge-custom"
SRC_URI="https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton7-8/GE-Proton7-8.tar.gz -> ${PN}-${PV}.tar.gz"
_internal_name=GE-Proton7-8

LICENSE=('BSD' 'LGPL' 'zlib' 'MIT' 'MPL' 'OFL' 'Proton')
SLOT="${PV}"
KEYWORDS="~amd64"
RESTRICT="mirror strip"

QA_PREBUILT="*"

S="${WORKDIR}"

pkg_pretend() {
	einfo "Some other packages may be needed to run some games,"
	einfo "you can install them by pull-in proton-ge-custom-meta."
	einfo "However, the list of dependencies may be not complete,"
	einfo "and some of ones listed may not necessary."
	einfo "Feel free to try it on your favourite games and any"
	einfo "issue/pr is welcome."
}

src_install() {
	dodir "/usr/share/steam/compatibilitytools.d/${_internal_name}"
	mv "${S}/${_internal_name}/compatibilitytool.vdf" "${D}/usr/share/steam/compatibilitytools.d/${_internal_name}" || die
	sed -i "s%\"install_path\" \".\"%\"install_path\" \"/opt/proton-ge-custom/${_internal_name}\"%" "${D}/usr/share/steam/compatibilitytools.d/${_internal_name}/compatibilitytool.vdf" || die

	dodir "/opt/proton-ge-custom"
	mv "${S}/${_internal_name}" "${D}/opt/proton-ge-custom" || die
}
