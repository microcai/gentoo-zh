# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Fast, disk space efficient package manager"
HOMEPAGE="https://pnpm.io"

# Use the following command to create this package
# npm install -g \
#		--cache "${PWD}/npm-cache" \
#		--prefix "${PWD}/pkgdir" \
#		pnpm@${PN}
SRC_URI="https://github.com/st0nie/gentoo-go-deps/releases/download/${P}/${P}-pkg.tar.xz -> ${P}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="net-libs/nodejs"
RDEPEND="${DEPEND}"
BDEPEND="app-misc/jq"

S="${WORKDIR}/pkgdir"

src_install(){
	mkdir "${D}/usr" || die
	cp -r * "${D}/usr" || die
	fowners -R root:root /usr
	find "${D}/usr/lib64" -depth -name "*.map" -delete || die

	local _tmp_package="$(mktemp || die)"
	local _npmdir=/usr/lib64/node_modules/${PN}
	jq '.|=with_entries(select(.key|test("_.+")|not))' "${D}/$_npmdir/package.json" > "$_tmp_package" || die
	insinto $_npmdir
	newins $_tmp_package package.json
	fperms 644 $_npmdir/package.json
}
