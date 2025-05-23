# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="${PV/_pre/-devel}"

DESCRIPTION="A line editor written in pure Bash with enhanced features"
HOMEPAGE="https://github.com/akinomyoga/ble.sh"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/akinomyoga/ble.sh.git"
else
	GIT_COMMIT_CONTRIB=9700c79eb97b3b5f0f06f7019097dc9d3ee93404
	BLESH_CONTRIB_PV="0_pre20230403"
	SRC_URI="
		https://github.com/akinomyoga/ble.sh/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.tar.gz
		https://github.com/akinomyoga/blesh-contrib/archive/${GIT_COMMIT_CONTRIB}.tar.gz
			-> blesh-contrib-${BLESH_CONTRIB_PV}.tar.gz
	"
	S="${WORKDIR}/ble.sh-${MY_PV}"
	KEYWORDS="~amd64"
fi

LICENSE="BSD MIT"
SLOT="0"
IUSE="doc"
RDEPEND=">=app-shells/bash-3.0"

PATCHES=( "${FILESDIR}/${P}-no-git.patch" )

if [[ ${PV} != 9999 ]]; then
	PATCHES+=( "${FILESDIR}/${P}-optional-docs.patch" )
fi

src_unpack() {
	if [[ ${PV} == 9999 ]] ; then
		git-r3_src_unpack
	else
		default
		rmdir "${S}/contrib" || die
		mv "${WORKDIR}/blesh-contrib-${GIT_COMMIT_CONTRIB}" "${S}/contrib" || die
	fi
}

src_compile() {
	emake USE_DOC=$(usex doc)
}

src_install() {
	emake install \
		USE_DOC=$(usex doc) \
		DESTDIR="${D}" \
		PREFIX="${EPREFIX}/usr" \
		INSDIR_DOC="${ED}/usr/share/doc/${PF}"
	insinto /usr/share/blesh/lib
	doins "${FILESDIR}/_package.bash"
}

pkg_postinst() {
	elog "Remember to enable ble.sh in your ~/.bashrc"
	elog "by adding this line at the top of ~/.bashrc:"
	elog '[[ $- == *i* ]] && source /usr/share/blesh/ble.sh --noattach'
	elog "and add this line at the end of ~/.bashrc:"
	elog '[[ ${BLE_VERSION-} ]] && ble-attach'
}
