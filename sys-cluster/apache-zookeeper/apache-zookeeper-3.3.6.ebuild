# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils java-utils-2

MY_PN="${PN/apache-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="ZooKeeper is a high-performance coordination service for
distributed applications."
HOMEPAGE="http://hadoop.apache.org/"
SRC_URI="mirror://apache/${MY_PN}/${MY_P}/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror binchecks"
IUSE=""

DEPEND=""
RDEPEND=">=virtual/jre-1.6"

S="${WORKDIR}/${MY_P}"
INSTALL_DIR=/opt/"${PN}"
DATA_DIR=/var/db/"${PN}"
export CONFIG_PROTECT="${CONFIG_PROTECT} ${INSTALL_DIR}/conf"

src_install() {
	dodir "${DATA_DIR}"
	sed "s:^dataDir=.*:dataDir=${DATA_DIR}:" conf/zoo_sample.cfg > conf/zoo.cfg || die "sed failed"

	dodir "${INSTALL_DIR}"
	mv "${S}"/* "${D}${INSTALL_DIR}" || die "install failed"

	# env file
	cat > 99"${PN}" <<-EOF
		PATH=${INSTALL_DIR}/bin
		CONFIG_PROTECT=${INSTALL_DIR}/conf
	EOF
	doenvd 99"${PN}" || die "doenvd failed"

	cat > "${PN}" <<-EOF
		#!/sbin/runscript

		opts="start stop restart"

		start() {
			${INSTALL_DIR}/bin/zkServer.sh start > /dev/null
				}

		stop() {
			${INSTALL_DIR}/bin/zkServer.sh stop
				}

		restart() {
			${INSTALL_DIR}/bin/zkServer.sh restart > /dev/null
				}

		status() {
			${INSTALL_DIR}/bin/zkServer.sh status
				}
	EOF
	doinitd "${PN}" || die "doinitd failed"
}

pkg_postinst() {
	elog "For info on configuration see http://hadoop.apache.org/${MY_PN}/docs/r${PV}"
}
