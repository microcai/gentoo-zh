# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module systemd

DESCRIPTION="A rule-based tunnel in Go."
HOMEPAGE="https://github.com/Dreamacro/clash"

EGO_SUM=(
	"github.com/Dreamacro/go-shadowsocks2 v0.1.7"
	"github.com/Dreamacro/go-shadowsocks2 v0.1.7/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/go-chi/chi/v5 v5.0.3"
	"github.com/go-chi/chi/v5 v5.0.3/go.mod"
	"github.com/go-chi/cors v1.2.0"
	"github.com/go-chi/cors v1.2.0/go.mod"
	"github.com/go-chi/render v1.0.1"
	"github.com/go-chi/render v1.0.1/go.mod"
	"github.com/gofrs/uuid v4.0.0+incompatible"
	"github.com/gofrs/uuid v4.0.0+incompatible/go.mod"
	"github.com/gorilla/websocket v1.4.2"
	"github.com/gorilla/websocket v1.4.2/go.mod"
	"github.com/miekg/dns v1.1.42"
	"github.com/miekg/dns v1.1.42/go.mod"
	"github.com/oschwald/geoip2-golang v1.5.0"
	"github.com/oschwald/geoip2-golang v1.5.0/go.mod"
	"github.com/oschwald/maxminddb-golang v1.8.0"
	"github.com/oschwald/maxminddb-golang v1.8.0/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/sirupsen/logrus v1.8.1"
	"github.com/sirupsen/logrus v1.8.1/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.2.2/go.mod"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"github.com/stretchr/testify v1.6.1/go.mod"
	"github.com/stretchr/testify v1.7.0"
	"github.com/stretchr/testify v1.7.0/go.mod"
	"go.uber.org/atomic v1.7.0"
	"go.uber.org/atomic v1.7.0/go.mod"
	"golang.org/x/crypto v0.0.0-20210317152858-513c2a44f670/go.mod"
	"golang.org/x/crypto v0.0.0-20210506145944-38f3c27a63bf"
	"golang.org/x/crypto v0.0.0-20210506145944-38f3c27a63bf/go.mod"
	"golang.org/x/net v0.0.0-20210226172049-e18ecbb05110/go.mod"
	"golang.org/x/net v0.0.0-20210508051633-16afe75a6701"
	"golang.org/x/net v0.0.0-20210508051633-16afe75a6701/go.mod"
	"golang.org/x/sync v0.0.0-20210220032951-036812b2e83c"
	"golang.org/x/sync v0.0.0-20210220032951-036812b2e83c/go.mod"
	"golang.org/x/sys v0.0.0-20191026070338-33540a1f6037/go.mod"
	"golang.org/x/sys v0.0.0-20191224085550-c709ea063b76/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210303074136-134d130e1a04/go.mod"
	"golang.org/x/sys v0.0.0-20210423082822-04245dca01da/go.mod"
	"golang.org/x/sys v0.0.0-20210507161434-a76c4d0a0096"
	"golang.org/x/sys v0.0.0-20210507161434-a76c4d0a0096/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/text v0.3.6"
	"golang.org/x/text v0.3.6/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
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
KEYWORDS="amd64 ~arm ~x86"
IUSE="geoip"

BDEPEND=">=dev-lang/go-1.16.2:="
RDEPEND="geoip? ( net-misc/geoipupdate )"

src_compile() {
	local Version=${PV} BuildTime=$(date -u +'%Y-%m-%dT%H:%M:%SZ')
	go build -v -work -x -o bin/clash -trimpath -ldflags "\
	-X \"github.com/Dreamacro/clash/constant.Version=v${Version}\" \
	-X \"github.com/Dreamacro/clash/constant.BuildTime=${BuildTime}\" \
	-buildid="
}

src_install() {
	dobin bin/clash

	systemd_dounit "${FILESDIR}/clash.service"
	systemd_newunit "${FILESDIR}/clash_at.service" clash@.service

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
