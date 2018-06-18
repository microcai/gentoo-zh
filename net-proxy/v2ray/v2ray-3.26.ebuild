# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_VENDOR=(
	"websocket 17ef924799bd76d2e939bb6ccf8356bdfb19671d github.com/v2ray/websocket"

	"github.com/miekg/dns f90eb8fb4590a3c81327ccca86ed4c4ca898c73d"
	"golang.org/x/net db08ff08e8622530d9ed3a0e8ac279f6d4c02196 github.com/golang/net"
	"golang.org/x/crypto 027cca12c2d63e3d62b670d901e8a2c95854feec github.com/golang/crypto"
	"github.com/golang/protobuf 9f81198da99b79e14d70ca2c3cc1bbe44c6e69b6"
	"golang.org/x/text 5cec4b58c438bd98288aeb248bab2c1840713d21 github.com/golang/text"
	"google.golang.org/genproto 32ee49c4dd805befd833990acba36cb75042378c github.com/google/go-genproto"

	"golang.org/x/sys 6c888cc515d3ed83fc103cf1d84468aad274b0a7 github.com/golang/sys"
	"github.com/google/go-github a83ae98ad5d09188c49d6056edb60ec9bdf202bd"
	"golang.org/x/oauth2 1e0a3fa8ba9a5c9eb35c271780101fdaf1b205d7 github.com/golang/oauth2"
	"github.com/gogo/protobuf 30cf7ac33676b5786e78c746683f0d4cd64fa75b"
	"github.com/google/go-querystring 53e6ce116135b80d037921a7fdd5138cf32d7a8a"
	)
inherit golang-build golang-vcs-snapshot systemd user

DESCRIPTION="A platform for building proxies to bypass network restrictions"
HOMEPAGE="https://www.v2ray.com"
SRC_URI="https://github.com/v2ray/v2ray-core/archive/v${PV}.tar.gz -> ${PN}-core-${PV}.tar.gz
	https://github.com/v2ray/ext/archive/v${PV}.tar.gz -> ${PN}-ext-${PV}.tar.gz
	https://github.com/grpc/grpc-go/archive/7e6dc36bea3004a439649320dd630c9919537261.tar.gz -> github.com-grpc-grpc-go-7e6dc36bea3004a439649320dd630c9919537261.tar.gz
	${EGO_VENDOR_URI}"
declare -A GO_SRCS
GO_SRCS[google.golang.org/grpc]="github.com-grpc-grpc-go-7e6dc36bea3004a439649320dd630c9919537261.tar.gz"
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

	popd
}

pkg_postinst() {
	elog "You may need to add v2ray User&Group for security concerns."
	elog "Then you need to modify the /lib/systemd/system/v2ray.service for systemd user"
	elog "and /etc/init.d/v2ray for openRC user"
}
