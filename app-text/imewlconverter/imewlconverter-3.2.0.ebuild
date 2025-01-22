# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOTNET_PKG_COMPAT="8.0"
NUGETS="
	sharpziplib@1.4.2
	utf.unknown@2.5.1
"

inherit dotnet-pkg

DESCRIPTION="An open source and free input method dictionary conversion program"
HOMEPAGE="https://github.com/studyzy/imewlconverter"

if [[ "${PV}" == 9999 ]] ; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/studyzy/imewlconverter.git"
else
	SRC_URI="https://github.com/studyzy/imewlconverter/archive/v${PV}.tar.gz -> ${P}.tar.gz"

	KEYWORDS="~amd64"
fi

SRC_URI+=" ${NUGET_URIS} "

LICENSE="GPL-3+"
SLOT="0"

DOTNET_PKG_PROJECTS=( src/ImeWlConverterCmd/ImeWlConverterCmd.csproj )

src_unpack() {
	dotnet-pkg_src_unpack

	if [[ "${PV}" == 9999 ]] ; then
		git-r3_src_unpack
	fi
}

src_prepare() {
	sed -i -E "s|<Version>.+</Version>|<Version>${PV}</Version>|" src/ImeWlConverterCmd/ImeWlConverterCmd.csproj || die
	sed -i -e 's/dotnet ImeWlConverterCmd.dll/ImeWlConverterCmd/g' src/ImeWlConverterCmd/Program.cs || die

	dotnet-pkg_src_prepare
}

src_install() {
	mv "${DOTNET_PKG_OUTPUT}/Readme.txt" CHANGELOG || die

	dotnet-pkg-base_install
	dotnet-pkg-base_dolauncher "/usr/share/${P}/ImeWlConverterCmd"

	einstalldocs
}
