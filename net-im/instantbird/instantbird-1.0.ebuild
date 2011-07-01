# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit toolchain-funcs gnome2-utils mozconfig-3

DESCRIPTION=""
HOMEPAGE="http://www.instantbird.com/"
SRC_URI="http://www.${PN}.com/downloads/${PV}/${P}.src.tgz"

S="${WORKDIR}/${P}-src"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~86"
IUSE="+system-xulrunner +system-libpurple system-sqlite"

RDEPEND="
	system-libpurple? ( net-im/pidgin[gtk] )
	system-xulrunner? (  >=net-libs/xulrunner-2.0 )
	!system-xulrunner? ( 

	>=sys-devel/binutils-2.16.1
	>=dev-libs/nss-3.12.9
	>=dev-libs/nspr-4.8.7
	>=dev-libs/glib-2.26
	media-libs/libpng[apng]
	dev-libs/libffi
		system-sqlite? ( >=dev-db/sqlite-3.7.4[fts3,secure-delete,unlock-notify,debug=] )

	)


	"
# We don't use PYTHON_DEPEND/PYTHON_USE_WITH for some silly reason
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	=dev-lang/python-2*[sqlite]"

src_configure(){
	MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"
	MEXTENSIONS="default"

	####################################
	#
	# mozconfig, CFLAGS and CXXFLAGS setup
	#
	####################################

	mozconfig_init
	mozconfig_config

	# It doesn't compile on alpha without this LDFLAGS
	use alpha && append-ldflags "-Wl,--no-relax"

	mozconfig_annotate '' --enable-application="${PN}"
	mozconfig_annotate '' --prefix=/usr
	mozconfig_annotate '' --libdir=/usr/$(get_libdir)
#	mozconfig_annotate '' --enable-static
	mozconfig_annotate '' --disable-mailnews
	mozconfig_annotate '' --with-system-png
	use system-libpurple && mozconfig_annotate '' --enable-purple-plugins

	use system-xulrunner &&	mozconfig_annotate '' --with-system-libxul
	use system-xulrunner &&	mozconfig_annotate '' --with-libxul-sdk="${EPREFIX}/usr/$(get_libdir)/xulrunner-devel"

	# Other ff-specific settings
	mozconfig_annotate '' --with-default-mozilla-five-home=${MOZILLA_FIVE_HOME}

	mozconfig_use_enable system-sqlite

	# Finalize and report settings
	mozconfig_final

	if [[ $(gcc-major-version) -lt 4 ]]; then
		append-cxxflags -fno-stack-protector
	fi

	if use amd64 || use x86; then
		append-flags -mno-avx
	fi

	#CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)" PYTHON="$(PYTHON)" econf
}

src_compile(){
	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)" \
	MOZ_MAKE_FLAGS="${MAKEOPTS}" \
	emake -f client.mk build || die "emake failed"
}

src_install() {
	MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	MOZ_MAKE_FLAGS="${MAKEOPTS}" \
	emake -f client.mk DESTDIR="${D}" install || die "emake install failed" 
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	# Update mimedb for the new .desktop file
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
