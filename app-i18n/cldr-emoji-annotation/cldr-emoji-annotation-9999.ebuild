# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3
DESCRIPTION="Emoji annotation files in CLDR"
HOMEPAGE="https://github.com/fujiwarat/cldr-emoji-annotation"
EGIT_REPO_URI="https://github.com/fujiwarat/cldr-emoji-annotation.git"

LICENSE="Unicode_License"
SLOT="0"
KEYWORDS="~amd64"
SRC_URI=""

DEPEND=""
RDEPEND="
	${DEPEND}
	!app-i18n/unicode-cldr
"
BDEPEND=""

TAG=${PV}_${PR/r/}

if [[ "${PV}" != 9999 ]]; then
	EGIT_COMMIT=${TAG}
else
	KEYWORDS=""
fi

src_prepare() {
	./autogen.sh --prefix=/usr || die
	if declare -p PATCHES | grep -q "^declare -a "; then
		[[ -n ${PATCHES[@]} ]] && eapply "${PATCHES[@]}"
	else
		[[ -n ${PATCHES} ]] && eapply ${PATCHES}
	fi
	eapply_user
}
