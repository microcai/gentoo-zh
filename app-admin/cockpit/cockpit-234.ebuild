# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

RESTRICT="mirror"

DESCRIPTION="A systemd web based user interface for Linux server"
HOMEPAGE="https://cockpit-project.org/"
SRC_URI="https://github.com/cockpit-project/cockpit/releases/download/${PV}/cockpit-${PV}.tar.xz
	https://github.com/cockpit-project/cockpit/releases/download/${PV}/cockpit-cache-${PV}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="virtual/krb5
	net-libs/libssh[server]
	sys-apps/accountsservice
	dev-perl/JSON
	dev-perl/Locale-PO
	dev-libs/json-glib
	net-libs/glib-networking
	acct-user/cockpit-ws"

RDEPEND="${DEPEND}"

BDEPEND="${DEPEND}
	dev-util/gtk-doc
	dev-libs/gobject-introspection
	net-misc/networkmanager
	app-text/xmlto"

# libgsystem npm pcp

src_configure(){
	econf \
	--libexecdir=/usr/lib/${PN} \
	--with-nfs-client-package='"nfs-utils"' \
	--with-cockpit-user=cockpit-ws \
	--with-cockpit-ws-instance-user=cockpit-ws \
	--disable-pcp
}

src_install() {
	emake DESTDIR="${D}" install

	insinto /etc/pam.d/
	newins "${FILESDIR}/cockpit.pam" cockpit
}
