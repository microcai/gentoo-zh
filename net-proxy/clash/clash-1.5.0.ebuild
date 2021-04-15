# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module systemd

DESCRIPTION="A rule-based tunnel in Go."
HOMEPAGE="https://github.com/Dreamacro/clash
	https://www.maxmind.com"

GEOIP_PV="20210412"

EGO_SUM=(
	"github.com/Dreamacro/go-shadowsocks2 v0.1.7"
	"github.com/Dreamacro/go-shadowsocks2 v0.1.7/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/go-chi/chi/v5 v5.0.2"
	"github.com/go-chi/chi/v5 v5.0.2/go.mod"
	"github.com/go-chi/cors v1.2.0"
	"github.com/go-chi/cors v1.2.0/go.mod"
	"github.com/go-chi/render v1.0.1"
	"github.com/go-chi/render v1.0.1/go.mod"
	"github.com/gofrs/uuid v4.0.0+incompatible"
	"github.com/gofrs/uuid v4.0.0+incompatible/go.mod"
	"github.com/gorilla/websocket v1.4.2"
	"github.com/gorilla/websocket v1.4.2/go.mod"
	"github.com/miekg/dns v1.1.41"
	"github.com/miekg/dns v1.1.41/go.mod"
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
	"golang.org/x/crypto v0.0.0-20210322153248-0c34fe9e7dc2"
	"golang.org/x/crypto v0.0.0-20210322153248-0c34fe9e7dc2/go.mod"
	"golang.org/x/net v0.0.0-20210226172049-e18ecbb05110/go.mod"
	"golang.org/x/net v0.0.0-20210405180319-a5a99cb37ef4"
	"golang.org/x/net v0.0.0-20210405180319-a5a99cb37ef4/go.mod"
	"golang.org/x/sync v0.0.0-20210220032951-036812b2e83c"
	"golang.org/x/sync v0.0.0-20210220032951-036812b2e83c/go.mod"
	"golang.org/x/sys v0.0.0-20191026070338-33540a1f6037/go.mod"
	"golang.org/x/sys v0.0.0-20191224085550-c709ea063b76/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210303074136-134d130e1a04/go.mod"
	"golang.org/x/sys v0.0.0-20210330210617-4fbd30eecc44/go.mod"
	"golang.org/x/sys v0.0.0-20210403161142-5e06dd20ab57"
	"golang.org/x/sys v0.0.0-20210403161142-5e06dd20ab57/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/text v0.3.3"
	"golang.org/x/text v0.3.3/go.mod"
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
	https://github.com/Dreamacro/maxmind-geoip/releases/download/${GEOIP_PV}/Country.mmdb -> ${P}-Country-${GEOIP_PV}.mmdb
	${EGO_SUM_SRC_URI}"
RESTRICT="mirror"

LICENSE="GPL-3 CC-BY-SA-4.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

src_compile() {
	local Version=${PV} BuildTime=$(date -u)
	go build -o bin/clash -trimpath -ldflags "\
	-X \"github.com/Dreamacro/clash/constant.Version=v${Version}\" \
	-X \"github.com/Dreamacro/clash/constant.BuildTime=${BuildTime}\" \
	-s -w -buildid="
}

src_install() {
	dobin bin/clash

	insinto /etc/clash
	newins "${DISTDIR}/${P}-Country-${GEOIP_PV}.mmdb" Country.mmdb

	systemd_dounit "${FILESDIR}/clash.service"
	systemd_newunit "${FILESDIR}/clash_at.service" clash@.service
}

pkg_postinst() {
	elog
	elog "Follow the instructions of https://github.com/Dreamacro/clash/wiki"
	elog
}
