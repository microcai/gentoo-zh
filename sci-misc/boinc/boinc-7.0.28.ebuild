# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/boinc/boinc-6.12.42.ebuild,v 1.2 2011/11/04 19:22:44 scarabeus Exp $

EAPI=4

inherit flag-o-matic eutils wxwidgets autotools base subversion

DESCRIPTION="The Berkeley Open Infrastructure for Network Computing"
HOMEPAGE="http://boinc.berkeley.edu/"
ESVN_REPO_URI="http://boinc.berkeley.edu/svn/tags/boinc_core_release_7_0_28/"

#SRC_URI="boinc-source-${PV}.tar.bz2"
#S="${WORKDIR}/boinc-source-${PV}"
#RESTRICT="mirror fetch"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+X -cuda"

RDEPEND="
	!sci-misc/boinc-bin
	!app-admin/quickswitch
	>=app-misc/ca-certificates-20120212
	dev-libs/openssl
	net-misc/curl[curl_ssl_openssl,-curl_ssl_gnutls]
	sys-apps/util-linux
	sys-libs/zlib
	cuda? (
		>=dev-util/nvidia-cuda-toolkit-4.0
		>=x11-drivers/nvidia-drivers-270.41
	)
	X? (
		dev-db/sqlite:3
		media-libs/freeglut
		sys-libs/glibc:2.2
		virtual/jpeg
		x11-libs/gtk+:2
		>=x11-libs/libnotify-0.7
		x11-libs/wxGTK:2.8[X,opengl]
	)
"
DEPEND="${RDEPEND}
	sys-devel/gettext
	app-text/docbook-xml-dtd:4.4
	app-text/docbook2X
"

AUTOTOOLS_IN_SOURCE_BUILD=1

src_prepare() {
	mkdir -pv "$S"/curl
	# use system ssl certificates
	ln -svf /etc/ssl/certs/ca-certificates.crt "${S}"/curl/ca-bundle.crt

	base_src_prepare
	
	sed  -e  's/AC_PROG_CXX/AC_PROG_CXX\nAC_PROG_OBJCXX/g' -i  configure.ac
	sed  -e  's/BOINC_SET_COMPILE_FLAGS//g' -i  configure.ac

	eautoreconf
}

src_configure() {
	local wxconf=""

	# add gtk includes
	append-flags "$(pkg-config --cflags gtk+-2.0)"

	# look for wxGTK
	if use X; then
		WX_GTK_VER="2.8"
		need-wxwidgets unicode
		wxconf+=" --with-wx-config=${WX_CONFIG}"
	else
		wxconf+=" --without-wxdir"
	fi

	econf \
		--disable-server \
		--disable-fcgi \
		--disable-install-headers \
		--enable-client \
		--enable-optimize \
		--disable-generic-processor \
		--disable-dynamic-client-linkage \
		--disable-static \
		--enable-unicode \
		--with-ssl \
		$(use_with X x) \
		$(use_enable X manager) \
		${wxconf}
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +

	dodir /var/lib/${PN}/
	keepdir /var/lib/${PN}/

	if use X; then
		newicon "${S}"/packages/generic/sea/${PN}mgr.48x48.png ${PN}.png || die
		make_desktop_entry boincmgr "${PN}" "${PN}" "Math;Science" "Path=/var/lib/${PN}"
	fi

	# cleanup cruft
	rm -rf "${D}"/etc/
	# cleanup unused lib
	rm -rf "${D}"/usr/lib*

	newinitd "${FILESDIR}"/${PN}.init ${PN}
	newconfd "${FILESDIR}"/${PN}.conf ${PN}
}

pkg_preinst() {
	enewgroup ${PN}
	# note this works only for first install so we have to
	# elog user about the need of being in video group
	if use cuda; then
		enewuser ${PN} -1 -1 /var/lib/${PN} "${PN},video"
	else
		enewuser ${PN} -1 -1 /var/lib/${PN} "${PN}"
	fi
}

pkg_postinst() {
	echo
	elog "You are using the source compiled version of ${PN}."
	use X && elog "The graphical manager can be found at /usr/bin/${PN}mgr"
	elog
	elog "You need to attach to a project to do anything useful with ${PN}."
	elog "You can do this by running /etc/init.d/${PN} attach"
	elog "The howto for configuration is located at:"
	elog "http://boinc.berkeley.edu/wiki/Anonymous_platform"
	elog
	# Add warning about the new password for the client, bug 121896.
	if use X; then
		elog "If you need to use the graphical manager the password is in:"
		elog "/var/lib/${PN}/gui_rpc_auth.cfg"
		elog "Where /var/lib/ is default RUNTIMEDIR, that can be changed in:"
		elog "/etc/conf.d/${PN}"
		elog "You should change this password to something more memorable (can be even blank)."
		elog "Remember to launch init script before using manager. Or changing the password."
		elog
	fi
	if use cuda; then
		elog "To be able to use CUDA you should add boinc user to video group."
		elog "Run as root:"
		elog "gpasswd -a boinc video"
	fi
}
