# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit nsplugins

DESCRIPTION="115.com big file upload control"
HOMEPAGE="http://115.com/"
SRC_URI="x86? ( http://115.com/static/install/${PN}_v${PV}_x86.tar.gz )
	amd64? ( http://115.com/static/install/${PN}_v${PV}_x64.tar.gz )"

LICENSE="Other"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	insinto /opt/115upload/nsplugins/
	doins 115upload.so
	inst_plugin /opt/115upload/nsplugins/115upload.so
}
