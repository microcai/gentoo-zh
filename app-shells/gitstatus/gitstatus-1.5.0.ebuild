# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake flag-o-matic git-r3

DESCRIPTION="Git status for Bash and Zsh prompt"
HOMEPAGE="https://github.com/romkatv/gitstatus"
SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
# LIBGIT2_TAG depends on pkgver. They must be updated together. See libgit2_version in:
# https://raw.githubusercontent.com/romkatv/gitstatus/v${pkgver}/build.info
LIBGIT2_TAG="tag-82cefe2b42300224ad3c148f8b1a569757cc617a"
EGIT_REPO_URI="https://github.com/romkatv/libgit2"
EGIT_COMMIT="${LIBGIT2_TAG}"
EGIT_CHECKOUT_DIR="${WORKDIR}/${P}/deps"
BUILD_DIR="${EGIT_CHECKOUT_DIR}_BUILD"
CMAKE_USE_DIR="${EGIT_CHECKOUT_DIR}"


LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
    if [[ -n ${A} ]]; then
		unpack ${A}
	fi
    git-r3_fetch
    git-r3_checkout
}

src_configure() {
	mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DZERO_NSEC=ON            
		-DTHREADSAFE=ON           
		-DUSE_BUNDLED_ZLIB=ON     
		-DREGEX_BACKEND=builtin   
		-DUSE_HTTP_PARSER=builtin 
		-DUSE_SSH=OFF             
		-DUSE_HTTPS=OFF           
		-DBUILD_CLAR=OFF          
		-DUSE_GSSAPI=OFF          
		-DUSE_NTLMCLIENT=OFF      
		-DBUILD_SHARED_LIBS=OFF   
	)
	cmake_src_configure
}

src_compile() {
	append-cflags $(test-flags-CC -fno-plt)

	cmake_src_compile

	local cxxflags=(
		"-I${EGIT_CHECKOUT_DIR}/include"
		-DGITSTATUS_ZERO_NSEC
		-D_GNU_SOURCE
	)
	local ldflags=(
		"-L${BUILD_DIR}"
		-static
	)

	append-cxxflags "${cxxflags[@]}"
	append-ldflags "${ldflags[@]}"
	emake all
	GITSTATUS_DAEMON= GITSTATUS_CACHE_DIR=${S}/usrbin ./install
	for file in *.zsh install; do
    	zsh -fc "emulate zsh -o no_aliases && zcompile -R -- $file.zwc $file" || die "Couldn't zcompile"
	done
}

src_install() {
	insinto "/usr/share/${PN}"
	exeinto "${_}"

	doins gitstatus.*.{sh,zsh{,.zwc}} *.info
	doexe install

	exeinto "/usr/libexec/${PN}"
	doexe usrbin/gitstatusd

	dosym "../../../libexec/${PN}/gitstatusd" \
		"/usr/share/${PN}/usrbin/gitstatusd"

	dodoc {README,docs/listdir}.md
}

pkg_postinst() {
	elog "The easiest way to take advantage of gitstatus from Zsh is to use a theme"
	elog "that's already integrated with it. For example: app-shells/zsh-theme-powerlevel10k"
	elog "The easiest way to take advantage of gitstatus from Bash is via gitstatus.prompt.sh."
	elog "Follow this guide: https://github.com/romkatv/gitstatus#using-from-bash"
}

