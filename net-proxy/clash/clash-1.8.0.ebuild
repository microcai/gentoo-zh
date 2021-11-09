# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module systemd

DESCRIPTION="A rule-based tunnel in Go."
HOMEPAGE="https://github.com/Dreamacro/clash"

EGO_SUM=(
	"github.com/Dreamacro/go-shadowsocks2 v0.1.7"
	"github.com/Dreamacro/go-shadowsocks2 v0.1.7/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/fanliao/go-promise v0.0.0-20141029170127-1890db352a72/go.mod"
	"github.com/go-chi/chi/v5 v5.0.5"
	"github.com/go-chi/chi/v5 v5.0.5/go.mod"
	"github.com/go-chi/cors v1.2.0"
	"github.com/go-chi/cors v1.2.0/go.mod"
	"github.com/go-chi/render v1.0.1"
	"github.com/go-chi/render v1.0.1/go.mod"
	"github.com/gofrs/uuid v4.1.0+incompatible"
	"github.com/gofrs/uuid v4.1.0+incompatible/go.mod"
	"github.com/google/go-cmp v0.2.0/go.mod"
	"github.com/google/go-cmp v0.3.0/go.mod"
	"github.com/google/go-cmp v0.3.1/go.mod"
	"github.com/google/go-cmp v0.4.0/go.mod"
	"github.com/google/go-cmp v0.5.2/go.mod"
	"github.com/gopherjs/gopherjs v0.0.0-20181017120253-0766667cb4d1/go.mod"
	"github.com/gorilla/websocket v1.4.2"
	"github.com/gorilla/websocket v1.4.2/go.mod"
	"github.com/hugelgupf/socketpair v0.0.0-20190730060125-05d35a94e714/go.mod"
	"github.com/insomniacslk/dhcp v0.0.0-20211026125128-ad197bcd36fd"
	"github.com/insomniacslk/dhcp v0.0.0-20211026125128-ad197bcd36fd/go.mod"
	"github.com/jsimonetti/rtnetlink v0.0.0-20190606172950-9527aa82566a/go.mod"
	"github.com/jsimonetti/rtnetlink v0.0.0-20200117123717-f846d4f6c1f4/go.mod"
	"github.com/jsimonetti/rtnetlink v0.0.0-20201009170750-9c6f07d100c1/go.mod"
	"github.com/jsimonetti/rtnetlink v0.0.0-20201110080708-d2c240429e6c/go.mod"
	"github.com/jtolds/gls v4.20.0+incompatible/go.mod"
	"github.com/kr/pretty v0.1.0"
	"github.com/kr/pretty v0.1.0/go.mod"
	"github.com/kr/pty v1.1.1/go.mod"
	"github.com/kr/text v0.1.0"
	"github.com/kr/text v0.1.0/go.mod"
	"github.com/mdlayher/ethernet v0.0.0-20190606142754-0394541c37b7/go.mod"
	"github.com/mdlayher/netlink v0.0.0-20190409211403-11939a169225/go.mod"
	"github.com/mdlayher/netlink v1.0.0/go.mod"
	"github.com/mdlayher/netlink v1.1.0/go.mod"
	"github.com/mdlayher/netlink v1.1.1/go.mod"
	"github.com/mdlayher/raw v0.0.0-20190606142536-fef19f00fc18/go.mod"
	"github.com/mdlayher/raw v0.0.0-20191009151244-50f2db8cc065/go.mod"
	"github.com/miekg/dns v1.1.43"
	"github.com/miekg/dns v1.1.43/go.mod"
	"github.com/oschwald/geoip2-golang v1.5.0"
	"github.com/oschwald/geoip2-golang v1.5.0/go.mod"
	"github.com/oschwald/maxminddb-golang v1.8.0"
	"github.com/oschwald/maxminddb-golang v1.8.0/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/sirupsen/logrus v1.8.1"
	"github.com/sirupsen/logrus v1.8.1/go.mod"
	"github.com/smartystreets/assertions v0.0.0-20180927180507-b2de0cb4f26d/go.mod"
	"github.com/smartystreets/goconvey v1.6.4/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.2.2/go.mod"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"github.com/stretchr/testify v1.4.0/go.mod"
	"github.com/stretchr/testify v1.6.1/go.mod"
	"github.com/stretchr/testify v1.7.0"
	"github.com/stretchr/testify v1.7.0/go.mod"
	"github.com/u-root/uio v0.0.0-20210528114334-82958018845c"
	"github.com/u-root/uio v0.0.0-20210528114334-82958018845c/go.mod"
	"go.etcd.io/bbolt v1.3.6"
	"go.etcd.io/bbolt v1.3.6/go.mod"
	"go.uber.org/atomic v1.9.0"
	"go.uber.org/atomic v1.9.0/go.mod"
	"go.uber.org/automaxprocs v1.4.0"
	"go.uber.org/automaxprocs v1.4.0/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9/go.mod"
	"golang.org/x/crypto v0.0.0-20210317152858-513c2a44f670/go.mod"
	"golang.org/x/crypto v0.0.0-20210921155107-089bfa567519"
	"golang.org/x/crypto v0.0.0-20210921155107-089bfa567519/go.mod"
	"golang.org/x/net v0.0.0-20190311183353-d8887717615a/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20190419010253-1f3472d942ba/go.mod"
	"golang.org/x/net v0.0.0-20190603091049-60506f45cf65/go.mod"
	"golang.org/x/net v0.0.0-20190827160401-ba9fcec4b297/go.mod"
	"golang.org/x/net v0.0.0-20191007182048-72f939374954/go.mod"
	"golang.org/x/net v0.0.0-20200202094626-16171245cfb2/go.mod"
	"golang.org/x/net v0.0.0-20201010224723-4f7140c49acb/go.mod"
	"golang.org/x/net v0.0.0-20201110031124-69a78807bb2b/go.mod"
	"golang.org/x/net v0.0.0-20210226172049-e18ecbb05110/go.mod"
	"golang.org/x/net v0.0.0-20211105192438-b53810dc28af"
	"golang.org/x/net v0.0.0-20211105192438-b53810dc28af/go.mod"
	"golang.org/x/sync v0.0.0-20210220032951-036812b2e83c"
	"golang.org/x/sync v0.0.0-20210220032951-036812b2e83c/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190312061237-fead79001313/go.mod"
	"golang.org/x/sys v0.0.0-20190411185658-b44545bcd369/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20190418153312-f0ce4c0180be/go.mod"
	"golang.org/x/sys v0.0.0-20190606122018-79a91cf218c4/go.mod"
	"golang.org/x/sys v0.0.0-20190826190057-c7b8b68b1456/go.mod"
	"golang.org/x/sys v0.0.0-20191008105621-543471e840be/go.mod"
	"golang.org/x/sys v0.0.0-20191026070338-33540a1f6037/go.mod"
	"golang.org/x/sys v0.0.0-20191224085550-c709ea063b76/go.mod"
	"golang.org/x/sys v0.0.0-20200202164722-d101bd2416d5/go.mod"
	"golang.org/x/sys v0.0.0-20200923182605-d9f96fdee20d/go.mod"
	"golang.org/x/sys v0.0.0-20200930185726-fdedc70b468f/go.mod"
	"golang.org/x/sys v0.0.0-20201009025420-dfb3f7c4e634/go.mod"
	"golang.org/x/sys v0.0.0-20201101102859-da207088b7d1/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210303074136-134d130e1a04/go.mod"
	"golang.org/x/sys v0.0.0-20210423082822-04245dca01da/go.mod"
	"golang.org/x/sys v0.0.0-20210525143221-35b2ab0089ea/go.mod"
	"golang.org/x/sys v0.0.0-20210615035016-665e8c7367d1/go.mod"
	"golang.org/x/sys v0.0.0-20211107104306-e0b2ad06fe42"
	"golang.org/x/sys v0.0.0-20211107104306-e0b2ad06fe42/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/text v0.3.6"
	"golang.org/x/text v0.3.6/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/tools v0.0.0-20190328211700-ab21143f2384/go.mod"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127/go.mod"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"gopkg.in/yaml.v2 v2.4.0"
	"gopkg.in/yaml.v2 v2.4.0/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
)
go-module_set_globals

SRC_URI="https://github.com/Dreamacro/clash/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"
RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm ~arm64 ~mips ~ppc64 ~s390 ~x86"
IUSE="geoip systemd"

BDEPEND=">=dev-lang/go-1.16.2:="
RDEPEND="!arm64? (
		geoip? ( net-misc/geoipupdate )
)"

src_compile() {
	local Version=${PV} BuildTime=$(date -u +'%Y-%m-%dT%H:%M:%SZ')
	go build -v -work -x -o bin/clash -trimpath -ldflags "\
	-X \"github.com/Dreamacro/clash/constant.Version=v${Version}\" \
	-X \"github.com/Dreamacro/clash/constant.BuildTime=${BuildTime}\" \
	-buildid="
}

src_install() {
	dobin bin/clash

	if use systemd; then
		systemd_dounit "${FILESDIR}/clash.service"
		systemd_newunit "${FILESDIR}/clash_at.service" clash@.service
	fi

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
