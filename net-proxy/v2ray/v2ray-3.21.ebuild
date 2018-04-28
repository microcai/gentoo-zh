# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_VENDOR=(
	"websocket 17ef924799bd76d2e939bb6ccf8356bdfb19671d github.com/v2ray/websocket"

	"github.com/miekg/dns 01d59357d468872339068bcd5d55a00e2463051f"
	"golang.org/x/net 5f9ae10d9af5b1c89ae6904293b14b064d4ada23 github.com/golang/net"
	"golang.org/x/crypto b49d69b5da943f7ef3c9cf91c8777c1f78a0cc3c github.com/golang/crypto"
	"github.com/golang/protobuf e09c5db296004fbe3f74490e84dcd62c3c5ddb1b"
	"golang.org/x/text 7922cc490dd5a7dbaa7fd5d6196b49db59ac042f github.com/golang/text"
	"google.golang.org/genproto 7fd901a49ba6a7f87732eb344f6e3c5b19d1b200 github.com/google/go-genproto"

	"golang.org/x/sys bb9c189858d91f42db229b04d45a4c3d23a7662a github.com/golang/sys"
	"github.com/google/go-github 29336dbceeab3a9b7e075b90d8b6d991d1bb5da2"
	"golang.org/x/oauth2 6881fee410a5daf86371371f9ad451b95e168b71 github.com/golang/oauth2"
	"github.com/gogo/protobuf 1ef32a8b9fc3f8ec940126907cedb5998f6318e4"
	"github.com/google/go-querystring 53e6ce116135b80d037921a7fdd5138cf32d7a8a"
	)
inherit golang-build golang-vcs-snapshot systemd user

DESCRIPTION="A platform for building proxies to bypass network restrictions"
HOMEPAGE="https://www.v2ray.com"
SRC_URI="https://github.com/v2ray/v2ray-core/archive/v${PV}.tar.gz -> ${PN}-core-${PV}.tar.gz
	https://github.com/v2ray/ext/archive/v${PV}.tar.gz -> ${PN}-ext-${PV}.tar.gz
	https://github.com/grpc/grpc-go/archive/fc37cf1364fafea48582b50bf6d4acf9880a980a.tar.gz -> github.com-grpc-grpc-go-fc37cf1364fafea48582b50bf6d4acf9880a980a.tar.gz
	${EGO_VENDOR_URI}"
declare -A GO_SRCS
GO_SRCS[google.golang.org/grpc]="github.com-grpc-grpc-go-fc37cf1364fafea48582b50bf6d4acf9880a980a.tar.gz"
GO_SRCS[v2ray.com/core/...]="${PN}-core-${PV}.tar.gz"
GO_SRCS[v2ray.com/ext/...]="${PN}-ext-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#DEPEND="dev-go/go-protobuf"
RDEPEND=""

QA_PRESTRIPPED="/usr/bin/v2ctl /usr/bin/v2ray"


src_unpack() {
	for x in ${!GO_SRCS[@]}; do
		EGO_PN=$x A=${GO_SRCS[$x]} golang-vcs-snapshot_src_unpack
	done
}

src_compile() {
	for x in ${!GO_SRCS[@]}; do
		EGO_PN=$x golang-build_src_compile
	done

	GOPATH="${S}:$(get_golibdir_gopath)" \
		go install -v -work -x ${EGO_BUILD_FLAGS} v2ray.com/ext/tools/build/vbuild || die

	# Cannot use full GOPATH now
	# See https://github.com/v2ray/ext/issues/11
	GOPATH="${S}" \
		${S}/bin/vbuild
	# vbuild returns 0 even on failure
	[ -f ${S}/bin/*/v2ray ] || die "Failed to build"
}

src_install() {
	gobindir=`dirname ${S}/bin/*/v2ray`
	pushd $gobindir

	dobin v2ray v2ctl

	insinto /etc/v2ray
	doins *.json

	insinto /usr/share/v2ray
	doins geoip.dat geosite.dat

	dodoc readme.md

	newinitd "${FILESDIR}/v2ray.initd" v2ray
	systemd_dounit systemd/v2ray.service
	sed '/Type=simple/a\CapabilityBoundingSet=CAP_NET_BIND_SERVICE' -i ${D}$(systemd_get_systemunitdir)/v2ray.service

	popd
}
