# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit autotools eutils flag-o-matic wxwidgets user git-r3


DESCRIPTION="aMule with DLP patch, the all-platform eMule p2p client"
HOMEPAGE="https://github.com/persmule/amule-dlp"
EGIT_REPO_URI="https://github.com/persmule/amule-dlp.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="daemon debug +dynamic geoip +gtk nls remote stats unicode upnp"
REQUIRED_USE="|| ( gtk remote daemon )"

DEPEND="
	=x11-libs/wxGTK-3.0*
	>=dev-libs/boost-1.57[nls,threads,context]
	>=dev-libs/crypto++-5
	>=sys-libs/zlib-1.2.1
	stats? ( >=media-libs/gd-2.0.26[jpeg] )
	geoip? ( dev-libs/geoip )
	upnp? ( >=net-libs/libupnp-1.6.6 )
	remote? ( >=media-libs/libpng-1.2.0
	unicode? ( >=media-libs/gd-2.0.26 ) )
	!net-p2p/amule
"
RDEPEND="${DEPEND} dynamic? ( net-p2p/amule-dlp-antileech )"

S=${WORKDIR}/${PN}
DOCS=( docs/{amulesig.txt,AUTHORS,ChangeLog,EC_Protocol.txt,ED2K-Links.HOWTO,INSTALL,README,TODO} )

pkg_setup() {
	if use stats && ! use gtk; then
		einfo "Note: You would need both the gtk and stats USE flags"
		einfo "to compile aMule Statistics GUI."
		einfo "I will now compile console versions only."
	fi
}

pkg_preinst() {
	if use daemon || use remote; then
		enewgroup p2p
		enewuser p2p -1 -1 /home/p2p p2p
	fi
}

src_prepare() {
	# fix the missing amule.xpm
	cp "${FILESDIR}/amule.xpm" ./

	# hack because of non-standard generation
	cd src/pixmaps/flags_xpm
	./makeflags.sh
	cd "$OLDPWD"

	WANT_AUTOCONF="2.5" eautoreconf
	WANT_AUTOMAKE="1.7" eautomake

	epatch "${FILESDIR}/amule-dlp-scanner-header.patch"
}

src_configure() {
	local myconf

	WX_GTK_VER="3.0"

	if use gtk; then
		einfo "wxGTK with X / GTK support will be used"
		need-wxwidgets unicode
	else
		einfo "wxGTK without X support will be used"
		need-wxwidgets base-unicode
	fi

	if use gtk ; then
		use stats && myconf="${myconf}
			--enable-wxcas
			--enable-alc"
		use remote && myconf="${myconf}
			--enable-amule-gui"
	else
		myconf="
			--disable-monolithic
			--disable-amule-gui
			--disable-wxcas
			--disable-alc"
	fi

	econf \
		--with-wx-config=${WX_CONFIG} \
		--with-boost \
		--enable-amulecmd \
		$(use_enable debug) \
		$(use_enable !debug optimize) \
		$(use_enable daemon amule-daemon) \
		$(use_enable geoip) \
		$(use_enable nls) \
		$(use_enable remote webserver) \
		$(use_enable stats cas) \
		$(use_enable stats alcc) \
		$(use_enable upnp) \
		${myconf} || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	if use daemon; then
		newconfd "${FILESDIR}"/amuled.confd amuled
		newinitd "${FILESDIR}"/amuled.initd amuled
	fi
	if use remote; then
		newconfd "${FILESDIR}"/amuleweb.confd amuleweb
		newinitd "${FILESDIR}"/amuleweb.initd amuleweb
	fi
}
