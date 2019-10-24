# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="7"

TAR_SUFFIX=tar.gz

inherit eutils autotools

HOMEPAGE="https://github.com/osdlyrics/osdlyrics"

DESCRIPTION="An OSD lyric show supporting multiple media players and downloading."
MY_PV=$(ver_rs 3 '-')
TEMP_SRC_DIR=${WORKDIR}/${PN}-${MY_PV}
SRC_URI="https://github.com/osdlyrics/osdlyrics/archive/${MY_PV}.${TAR_SUFFIX}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-python/future"
DEPEND="${RDEPEND}"

use_disable() {
	[[ -z $2 ]] && $2=$1
	use $1 || echo "--disable-$2"
}

src_unpack() {
	if [ "${A}" != "" ]; then
		unpack ${A}
	    mv ${TEMP_SRC_DIR} ${S} || die
	fi
}

src_prepare() {
	if declare -p PATCHES | grep -q "^declare -a "; then
        [[ -n ${PATCHES[@]} ]] && eapply "${PATCHES[@]}"
    else
        [[ -n ${PATCHES} ]] && eapply ${PATCHES}
    fi
    eapply_user
}

src_configure() {
	${S}/autogen.sh || die	
	econf
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc README*
}
