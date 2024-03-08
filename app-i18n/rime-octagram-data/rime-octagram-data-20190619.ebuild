# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Language model of the 「八股文」語法"
HOMEPAGE="https://github.com/lotem/rime-octagram-data"

_HANS_COMMIT="9c482c6660fa9e3268bd1d1a9341ef26aa90f94d"
_HANT_COMMIT="bb8e1313552f0f27f2f968031dfaf4563e55d982"

SRC_URI="
	hans? ( https://github.com/lotem/rime-octagram-data/archive/$_HANS_COMMIT.tar.gz -> $PN-hans-$PV.tar.gz )
	hant? ( https://github.com/lotem/rime-octagram-data/archive/$_HANT_COMMIT.tar.gz -> $PN-hant-$PV.tar.gz )
"

IUSE="+hans +hant"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

DEPEND="app-i18n/librime[octagram]"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	local dir="/usr/share/rime-data"
	insinto "$dir"

	if use hans ;then
		mv "${WORKDIR}/${PN}-${_HANS_COMMIT}"/* ./ || die
	fi

	if use hant ;then
		mv "${WORKDIR}/${PN}-${_HANT_COMMIT}"/* ./ || die
	fi

	doins *.gram
}
