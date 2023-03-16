# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg

MY_PN="biliup-app"

DESCRIPTION="A Tool for Upload video to bilibili"

HOMEPAGE="https://github.com/ForgQi/biliup-app"
SRC_URI="https://github.com/ForgQi/${MY_PN}/releases/download/app-v${PV}/${MY_PN}_${PV}_amd64.deb"

RESTRICT="mirror strip"

LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD Boost-1.0 CC0-1.0 ISC MIT MIT-0 MPL-2.0 Unicode-DFS-2016 Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="
	${DEPEND}
	net-libs/webkit-gtk:4
	x11-libs/gtk+:3
	!net-misc/biliup-app
"

S="${WORKDIR}"

MY_PREFIX="opt/apps/${MY_PN}"

src_install()
{
	insinto /
	doins -r .
	fperms 0755 /usr/bin/biliup-app
}
