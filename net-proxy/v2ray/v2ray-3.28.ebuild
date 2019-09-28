# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_VENDOR=(
	"websocket 17ef924799bd76d2e939bb6ccf8356bdfb19671d github.com/v2ray/websocket"

	"github.com/miekg/dns 3e6e47bc11bc7f93f9e2f1c7bd6481ba4802808b"
	"golang.org/x/net ed29d75add3d7c4bf7ca65aac0c6df3d1420216f github.com/golang/net"
	"golang.org/x/crypto a49355c7e3f8fe157a85be2f77e6e269a0f89602 github.com/golang/crypto"
	"github.com/golang/protobuf 9eb2c01ac278a5d89ce4b2be68fe4500955d8179"
	"golang.org/x/text c0fe8dde8a10c9b32154bd9bdf080b8b3d635127 github.com/golang/text"
	"google.golang.org/genproto ff3583edef7de132f219f0efc00e097cabcc0ec0 github.com/google/go-genproto"

	"golang.org/x/sys 151529c776cdc58ddbe7963ba9af779f3577b419 github.com/golang/sys"
	"github.com/google/go-github 60f2773bd99aa86164bc80bf370be6ba63b47dea"
	"golang.org/x/oauth2 ef147856a6ddbb60760db74283d2424e98c87bff github.com/golang/oauth2"
	"github.com/gogo/protobuf 30cf7ac33676b5786e78c746683f0d4cd64fa75b"
	"github.com/google/go-querystring 53e6ce116135b80d037921a7fdd5138cf32d7a8a"
	)
inherit golang-build golang-vcs-snapshot systemd user

DESCRIPTION="A platform for building proxies to bypass network restrictions"
HOMEPAGE="https://www.v2ray.com"
SRC_URI="https://github.com/v2ray/v2ray-core/archive/v${PV}.tar.gz -> ${PN}-core-${PV}.tar.gz
	https://github.com/v2ray/ext/archive/v${PV}.tar.gz -> ${PN}-ext-${PV}.tar.gz
	https://github.com/grpc/grpc-go/archive/40cd6b15e2880b88deb091b0fcb091694285fcb0.tar.gz -> github.com-grpc-grpc-go-40cd6b15e2880b88deb091b0fcb091694285fcb0.tar.gz
	${EGO_VENDOR_URI}"
declare -A GO_SRCS
GO_SRCS[google.golang.org/grpc]="github.com-grpc-grpc-go-40cd6b15e2880b88deb091b0fcb091694285fcb0.tar.gz"
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
