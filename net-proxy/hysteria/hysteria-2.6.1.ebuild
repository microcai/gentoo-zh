# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module systemd

DESCRIPTION="A powerful, lightning fast and censorship resistant proxy."
HOMEPAGE="https://github.com/apernet/hysteria"

SRC_URI="
	https://github.com/apernet/${PN}/archive/refs/tags/app/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/peeweep/gentoo-go-deps/releases/download/${P}/${P}-deps.tar.xz
"

S="${WORKDIR}/${PN}-app-v${PV}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

GO_CPU_FLAGS_X86="
	cpu_flags_x86_avx2
	cpu_flags_x86_fma4
	cpu_flags_x86_fma3
	cpu_flags_x86_f16c
	cpu_flags_x86_avx
	cpu_flags_x86_sse4_2
	cpu_flags_x86_sse4_1
	cpu_flags_x86_ssse3
	cpu_flags_x86_sse3
"

IUSE="+goamd64 ${GO_CPU_FLAGS_X86[@]}"

DEPEND="
	acct-user/hysteria
	acct-group/hysteria
	>=dev-lang/go-1.21.1
"
RDEPEND="${DEPEND}"

ego() {
	set -- go "$@"
	echo "$@" >&2
	"$@" || die -n "${*} failed"
}

pkg_setup() {
	if use goamd64; then
		GOAMD64_V="v1"
		if use cpu_flags_x86_sse3 && use cpu_flags_x86_sse4_1 && use cpu_flags_x86_sse4_2 && use cpu_flags_x86_ssse3
		then
			GOAMD64_V="v2"
			if use cpu_flags_x86_avx && use cpu_flags_x86_avx2 && use cpu_flags_x86_f16c && \
					(use cpu_flags_x86_fma4 || use cpu_flags_x86_fma3)
			then
				GOAMD64_V="v3"
			fi
		fi
		export GOAMD64="${GOAMD64_V}"
		einfo "building with GOAMD64=${GOAMD64_V}"
	fi
}

src_compile() {
	local APP_SRC_CMD_PKG="github.com/apernet/hysteria/app/cmd"
	local APP_DATE
	APP_DATE=$(LC_ALL=C date -u +'%Y-%m-%dT%H:%M:%SZ' || die)
	local APP_ARCH="Unknown"
	if use goamd64; then
		APP_ARCH="amd64-${GOAMD64}"
	fi

	CGO_ENABLED=1 ego build \
				  -trimpath \
				  -ldflags "-s -w -extldflags \"${LDFLAGS}\" \
				  -X \"${APP_SRC_CMD_PKG}.appVersion=${PV}\" \
				  -X \"${APP_SRC_CMD_PKG}.appDate=${APP_DATE}\" \
				  -X \"${APP_SRC_CMD_PKG}.appType=release\" \
				  -X \"${APP_SRC_CMD_PKG}.appPlatform=linux\" \
				  -X \"${APP_SRC_CMD_PKG}.appArch=${APP_ARCH}\" \
				  " \
				  -o "${PN}" "./app"
}

src_install() {
	insinto "/etc/${PN}"
	doins "${FILESDIR}/server.yaml.example"
	doins "${FILESDIR}/client.yaml.example"

	dobin "${PN}"

	systemd_dounit "${FILESDIR}/${PN}-server.service"
	systemd_dounit "${FILESDIR}/${PN}-client.service"
	newinitd "${FILESDIR}/${PN}-server.initd" "${PN}-server"
	newinitd "${FILESDIR}/${PN}-client.initd" "${PN}-client"

	keepdir /etc/${PN}
}
