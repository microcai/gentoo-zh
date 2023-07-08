# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module systemd

DESCRIPTION="A rule-based tunnel in Go."
HOMEPAGE="https://github.com/Dreamacro/clash"

SRC_URI="https://github.com/Dreamacro/clash/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Linerre/gentoo-go-deps/releases/download/${P}/${P}-deps.tar.xz"

RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm ~arm64 ~mips ~ppc64 ~s390 ~x86"

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

IUSE="goamd64 geoip ${GO_CPU_FLAGS_X86[@]}"
REQUIRED_USE="!amd64? ( !goamd64 )"

BDEPEND=">=dev-lang/go-1.20:="
RDEPEND="!arm64? (
		geoip? ( net-misc/geoipupdate )
)"

pkg_setup() {
	if use goamd64; then
		# default value of GOAMD64
		GOAMD64_V="v1"
		if use cpu_flags_x86_sse3 && use cpu_flags_x86_sse4_1 && use cpu_flags_x86_sse4_2 && use cpu_flags_x86_ssse3
		then
			GOAMD64_V="v2"
			if use cpu_flags_x86_avx && use cpu_flags_x86_avx2 && use cpu_flags_x86_f16c && \
					(use cpu_flags_x86_fma4 || use cpu_flags_x86_fma3)
			then
				GOAMD64_V="v3"
			fi
			# v4 generates AVX512 instructions thus
			# GOAMD64=v4 is currently not used on go-1.18
		fi
		export GOAMD64="${GOAMD64_V}"
		einfo "building with GOAMD64=${GOAMD64_V}"
	fi
}

src_compile() {
	local Version=${PV} BuildTime=$(date -u +'%Y-%m-%dT%H:%M:%SZ')
	local ldflags="\
		-X \"github.com/Dreamacro/clash/constant.Version=v${Version}\" \
		-X \"github.com/Dreamacro/clash/constant.BuildTime=${BuildTime}\" \
		-w -buildid="
	ego build -o bin/clash -trimpath -ldflags "${ldflags}"
}

src_test() {
	ego test github.com/Dreamacro/clash/...
}

src_install() {
	dobin bin/clash

	systemd_newunit "${FILESDIR}/clash-r1.service" clash.service
	#systemd_newunit "${FILESDIR}/clash_at.service" clash@.service

	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}

	keepdir /etc/clash
}

pkg_postinst() {
	elog
	elog "Follow the instructions of https://github.com/Dreamacro/clash/wiki"
	elog
	elog "You may need to get Country.mmdb file from"
	elog "https://github.com/Dreamacro/maxmind-geoip"
	elog "or"
	elog "https://dev.maxmind.com/geoip/geoip2/geolite2"
	elog
}
