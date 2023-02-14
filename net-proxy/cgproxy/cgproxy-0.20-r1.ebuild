# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Transparent Proxy with cgroup v2"
HOMEPAGE="https://github.com/springzfx/cgproxy"
SRC_URI="https://github.com/springzfx/cgproxy/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

DEPEND="
	net-firewall/iptables
	dev-util/bcc
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-cpp/nlohmann_json
	dev-libs/libbpf
	dev-util/bpftool
"
