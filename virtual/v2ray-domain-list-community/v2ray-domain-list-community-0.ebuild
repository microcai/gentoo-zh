# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Virtual for v2ray-domain-list-community"

SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~loong ~riscv ~x86"

RDEPEND="|| ( dev-libs/v2ray-domain-list-community dev-libs/v2ray-domain-list-community-bin )"
