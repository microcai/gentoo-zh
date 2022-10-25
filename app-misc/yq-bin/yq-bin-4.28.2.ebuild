# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

MY_PN="${PN/-bin/}_linux_amd64"

DESCRIPTION="yq is a portable command-line YAML, JSON and XML processor"
HOMEPAGE="https://github.com/mikefarah/yq"

SRC_URI="https://github.com/mikefarah/yq/releases/download/v${PV}/${MY_PN}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""
REQUIRED_USE=""

RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}
	!app-misc/yq
"

S="${WORKDIR}"

QA_PREBUILT="*"

src_install() {
	doman yq.1
	newbin ${MY_PN} yq
}
