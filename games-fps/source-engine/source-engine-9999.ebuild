# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_11 python3_12 )
PYTHON_REQ_USE='threads(+)'

inherit waf-utils git-r3 python-any-r1

DESCRIPTION="A 3D game engine developed by Valve"
HOMEPAGE="https://github.com/nillerusr/source-engine"
EGIT_REPO_URI="https://github.com/nillerusr/source-engine.git"

LICENSE="Source-SDK"
SLOT="0"
IUSE="debug"
BDEPEND="${PYTHON_DEPS}
		 media-libs/libsdl2
		 media-libs/freetype
		 media-libs/fontconfig
		 sys-libs/zlib
		 media-libs/libjpeg-turbo
		 media-libs/libpng
		 net-misc/curl
		 media-libs/openal"

src_configure() {
	local conf=(
		'-8'
		$(usex debug '-T debug' '-T release')
	)
	waf-utils_src_configure "${conf[@]}"
}

src_install() {
	waf-utils_src_install --destdir="${ED}/opt/source-engine"
}

pkg_postinst() {
	einfo "To play Half-Life 2,"
	einfo "you must legally own a Half-Life 2 copy,"
	einfo "then copy the 'hl2' folder into"
	einfo "/opt/source-engine/usr"
}
