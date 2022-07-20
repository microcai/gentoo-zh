# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module systemd

DESCRIPTION="A rule-based tunnel in Go."
HOMEPAGE="https://github.com/Dreamacro/clash"

EGO_SUM=(
	"github.com/creack/pty v1.1.9/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/fanliao/go-promise v0.0.0-20141029170127-1890db352a72/go.mod"
	"github.com/go-chi/chi/v5 v5.0.7"
	"github.com/go-chi/chi/v5 v5.0.7/go.mod"
	"github.com/go-chi/cors v1.2.1"
	"github.com/go-chi/cors v1.2.1/go.mod"
	"github.com/go-chi/render v1.0.1"
	"github.com/go-chi/render v1.0.1/go.mod"
	"github.com/gofrs/uuid v4.2.0+incompatible"
	"github.com/gofrs/uuid v4.2.0+incompatible/go.mod"
	"github.com/google/go-cmp v0.2.0/go.mod"
	"github.com/google/go-cmp v0.3.0/go.mod"
	"github.com/google/go-cmp v0.3.1/go.mod"
	"github.com/google/go-cmp v0.4.0/go.mod"
	"github.com/google/go-cmp v0.5.2/go.mod"
	"github.com/gopherjs/gopherjs v0.0.0-20181017120253-0766667cb4d1/go.mod"
	"github.com/gorilla/websocket v1.5.0"
	"github.com/gorilla/websocket v1.5.0/go.mod"
	"github.com/hugelgupf/socketpair v0.0.0-20190730060125-05d35a94e714/go.mod"
	"github.com/insomniacslk/dhcp v0.0.0-20220504074936-1ca156eafb9f"
	"github.com/insomniacslk/dhcp v0.0.0-20220504074936-1ca156eafb9f/go.mod"
	"github.com/jsimonetti/rtnetlink v0.0.0-20190606172950-9527aa82566a/go.mod"
	"github.com/jsimonetti/rtnetlink v0.0.0-20200117123717-f846d4f6c1f4/go.mod"
	"github.com/jsimonetti/rtnetlink v0.0.0-20201009170750-9c6f07d100c1/go.mod"
	"github.com/jsimonetti/rtnetlink v0.0.0-20201110080708-d2c240429e6c/go.mod"
	"github.com/jtolds/gls v4.20.0+incompatible/go.mod"
	"github.com/kr/pretty v0.1.0"
	"github.com/kr/text v0.2.0"
	"github.com/kr/text v0.2.0/go.mod"
	"github.com/mdlayher/ethernet v0.0.0-20190606142754-0394541c37b7/go.mod"
	"github.com/mdlayher/netlink v0.0.0-20190409211403-11939a169225/go.mod"
	"github.com/mdlayher/netlink v1.0.0/go.mod"
	"github.com/mdlayher/netlink v1.1.0/go.mod"
	"github.com/mdlayher/netlink v1.1.1/go.mod"
	"github.com/mdlayher/raw v0.0.0-20190606142536-fef19f00fc18/go.mod"
	"github.com/mdlayher/raw v0.0.0-20191009151244-50f2db8cc065/go.mod"
	"github.com/miekg/dns v1.1.50"
	"github.com/miekg/dns v1.1.50/go.mod"
	"github.com/oschwald/geoip2-golang v1.7.0"
	"github.com/oschwald/geoip2-golang v1.7.0/go.mod"
	"github.com/oschwald/maxminddb-golang v1.9.0"
	"github.com/oschwald/maxminddb-golang v1.9.0/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/prashantv/gostub v1.1.0"
	"github.com/sirupsen/logrus v1.8.1"
	"github.com/sirupsen/logrus v1.8.1/go.mod"
	"github.com/smartystreets/assertions v0.0.0-20180927180507-b2de0cb4f26d/go.mod"
	"github.com/smartystreets/goconvey v1.6.4/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/objx v0.4.0/go.mod"
	"github.com/stretchr/testify v1.2.2/go.mod"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"github.com/stretchr/testify v1.6.1/go.mod"
	"github.com/stretchr/testify v1.7.1/go.mod"
	"github.com/stretchr/testify v1.8.0"
	"github.com/stretchr/testify v1.8.0/go.mod"
	"github.com/u-root/uio v0.0.0-20210528114334-82958018845c"
	"github.com/u-root/uio v0.0.0-20210528114334-82958018845c/go.mod"
	"github.com/yuin/goldmark v1.3.5/go.mod"
	"go.etcd.io/bbolt v1.3.6"
	"go.etcd.io/bbolt v1.3.6/go.mod"
	"go.uber.org/atomic v1.9.0"
	"go.uber.org/atomic v1.9.0/go.mod"
	"go.uber.org/automaxprocs v1.5.1"
	"go.uber.org/automaxprocs v1.5.1/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20191011191535-87dc89f01550/go.mod"
	"golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9/go.mod"
	"golang.org/x/crypto v0.0.0-20220622213112-05595931fe9d"
	"golang.org/x/crypto v0.0.0-20220622213112-05595931fe9d/go.mod"
	"golang.org/x/mod v0.4.2"
	"golang.org/x/mod v0.4.2/go.mod"
	"golang.org/x/net v0.0.0-20190311183353-d8887717615a/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20190419010253-1f3472d942ba/go.mod"
	"golang.org/x/net v0.0.0-20190603091049-60506f45cf65/go.mod"
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
	"golang.org/x/net v0.0.0-20190827160401-ba9fcec4b297/go.mod"
	"golang.org/x/net v0.0.0-20191007182048-72f939374954/go.mod"
	"golang.org/x/net v0.0.0-20200202094626-16171245cfb2/go.mod"
	"golang.org/x/net v0.0.0-20201010224723-4f7140c49acb/go.mod"
	"golang.org/x/net v0.0.0-20201110031124-69a78807bb2b/go.mod"
	"golang.org/x/net v0.0.0-20210405180319-a5a99cb37ef4/go.mod"
	"golang.org/x/net v0.0.0-20210726213435-c6fcb2dbf985/go.mod"
	"golang.org/x/net v0.0.0-20220706163947-c90051bbdb60"
	"golang.org/x/net v0.0.0-20220706163947-c90051bbdb60/go.mod"
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
	"golang.org/x/sync v0.0.0-20210220032951-036812b2e83c/go.mod"
	"golang.org/x/sync v0.0.0-20220601150217-0de741cfad7f"
	"golang.org/x/sync v0.0.0-20220601150217-0de741cfad7f/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190312061237-fead79001313/go.mod"
	"golang.org/x/sys v0.0.0-20190411185658-b44545bcd369/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20190418153312-f0ce4c0180be/go.mod"
	"golang.org/x/sys v0.0.0-20190606122018-79a91cf218c4/go.mod"
	"golang.org/x/sys v0.0.0-20190826190057-c7b8b68b1456/go.mod"
	"golang.org/x/sys v0.0.0-20191008105621-543471e840be/go.mod"
	"golang.org/x/sys v0.0.0-20191026070338-33540a1f6037/go.mod"
	"golang.org/x/sys v0.0.0-20200202164722-d101bd2416d5/go.mod"
	"golang.org/x/sys v0.0.0-20200923182605-d9f96fdee20d/go.mod"
	"golang.org/x/sys v0.0.0-20200930185726-fdedc70b468f/go.mod"
	"golang.org/x/sys v0.0.0-20201009025420-dfb3f7c4e634/go.mod"
	"golang.org/x/sys v0.0.0-20201101102859-da207088b7d1/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210330210617-4fbd30eecc44/go.mod"
	"golang.org/x/sys v0.0.0-20210423082822-04245dca01da/go.mod"
	"golang.org/x/sys v0.0.0-20210510120138-977fb7262007/go.mod"
	"golang.org/x/sys v0.0.0-20210525143221-35b2ab0089ea/go.mod"
	"golang.org/x/sys v0.0.0-20210630005230-0f9fa26af87c/go.mod"
	"golang.org/x/sys v0.0.0-20220704084225-05e143d24a9e"
	"golang.org/x/sys v0.0.0-20220704084225-05e143d24a9e/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/text v0.3.6/go.mod"
	"golang.org/x/text v0.3.7"
	"golang.org/x/text v0.3.7/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/tools v0.0.0-20190328211700-ab21143f2384/go.mod"
	"golang.org/x/tools v0.0.0-20191119224855-298f0cb1881e/go.mod"
	"golang.org/x/tools v0.1.6-0.20210726203631-07bc1bf47fb2"
	"golang.org/x/tools v0.1.6-0.20210726203631-07bc1bf47fb2/go.mod"
	"golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod"
	"golang.org/x/xerrors v0.0.0-20191011141410-1b5146add898/go.mod"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
	"golang.org/x/xerrors v0.0.0-20200804184101-5ec99f83aff1"
	"golang.org/x/xerrors v0.0.0-20200804184101-5ec99f83aff1/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
)
go-module_set_globals

SRC_URI="https://github.com/Dreamacro/clash/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"
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

BDEPEND=">=dev-lang/go-1.18:="
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
			if use cpu_flags_x86_avx && use cpu_flags_x86_avx2 && use cpu_flags_x86_f16c && (use cpu_flags_x86_fma4 || use cpu_flags_x86_fma3)
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
	go build -o bin/clash -trimpath -ldflags "${ldflags}" || die
}

src_install() {
	dobin bin/clash

	systemd_newunit "${FILESDIR}/clash-r1.service" clash.service
	#systemd_newunit "${FILESDIR}/clash_at.service" clash@.service

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
