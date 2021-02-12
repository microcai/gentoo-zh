# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Library of unicode annotation data"
HOMEPAGE="https://github.com/fontforge/libuninameslist"
SRC_URI="https://github.com/fontforge/${PN}/archive/0.4.${PV}.tar.gz -> ${PN}-0.4.${PV}.tar.gz"

S="${WORKDIR}/${PN}-0.4.${PV}"

inherit autotools

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-solaris"
IUSE="static-libs"

src_prepare(){
	eautoreconf
}

src_configure(){
	local myeconfargs=(
		$(use_enable static-libs static)
	)
# Common args
	local econfargs=()

	_check_build_dir
	if "${ECONF_SOURCE}"/configure --help 2>&1 | grep -q '^ *--docdir='; then
		econfargs+=(
			--docdir="${EPREFIX}"/usr/share/doc/${PF}
		)
	fi

	# Handle static-libs found in IUSE, disable them by default
	if in_iuse static-libs; then
		econfargs+=(
			--enable-shared
			$(use_enable static-libs static)
		)
	fi

	# Append user args
	econfargs+=("${myeconfargs[@]}")

	mkdir -p "${BUILD_DIR}" || die
	pushd "${BUILD_DIR}" > /dev/null || die
	econf "${econfargs[@]}" "$@"
	popd > /dev/null || die
}
