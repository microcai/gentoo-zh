# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit eutils flag-o-matic git-r3

# gphoto and v4l are handled by their usual USE flags.
# The pint backend was disabled because I could not get it to compile.
# The mustek_usb2 backend would force us to use --enable-pthreads which is off
# by default for linux. Let's keep this one out until we find a way how to
# handle this cleanly.
IUSE_SANE_BACKENDS="
	abaton
	agfafocus
	apple
	artec
	artec_eplus48u
	as6e
	avision
	bh
	canon
	canon630u
	canon_dr
	canon_pp
	cardscan
	coolscan
	coolscan2
	coolscan3
	dc25
	dc210
	dc240
	dell1600n_net
	dmc
	epjitsu
	epson
	epson2
	fujitsu
	genesys
	gt68xx
	hp
	hp3500
	hp3900
	hp4200
	hp5400
	hp5590
	hpsj5s
	hpljm1005
	hs2p
	ibm
	kodak
	kvs1025
	leo
	lexmark
	ma1509
	matsushita
	microtek
	microtek2
	mustek
	mustek_pp
	mustek_usb
	nec
	net
	niash
	p5
	pie
	pixma
	plustek
	plustek_pp
	qcam
	ricoh
	rts8891
	s9036
	sceptre
	sharp
	sm3600
	sm3840
	snapscan
	sp15c
	st400
	stv680
	tamarack
	teco1
	teco2
	teco3
	test
	u12
	umax
	umax_pp
	umax1220u
	xerox_mfp"

IUSE="avahi usb gphoto2 ipv6 v4l doc"

for backend in ${IUSE_SANE_BACKENDS}; do
	IUSE="${IUSE} +sane_backends_${backend}"
done

EGIT_REPO_URI="http://git.debian.org/git/sane/sane-backends.git"

DESCRIPTION="Scanner Access Now Easy - Backends"
HOMEPAGE="http://www.sane-project.org/"

RDEPEND="
	sane_backends_dc210? ( virtual/jpeg  )
	sane_backends_dc240? ( virtual/jpeg )
	sane_backends_dell1600n_net? ( virtual/jpeg  )
	avahi? ( >=net-dns/avahi-0.6.24 )
	sane_backends_canon_pp? ( sys-libs/libieee1284 )
	sane_backends_hpsj5s? ( sys-libs/libieee1284 )
	sane_backends_mustek_pp? ( sys-libs/libieee1284 )
	usb? ( virtual/libusb:0 )
	gphoto2? (
				media-libs/libgphoto2
				virtual/jpeg
			)
	v4l? ( media-libs/libv4l )"

DEPEND="${RDEPEND}
	v4l? ( sys-kernel/linux-headers )
	doc? (
		virtual/latex-base
		|| ( dev-texlive/texlive-latexextra app-text/tetex app-text/ptex )
	)
	>=sys-apps/sed-4"

# We now use new syntax construct (SUBSYSTEMS!="usb|usb_device)
RDEPEND="${RDEPEND}
	!<sys-fs/udev-114"

# Could not access via ftp on 2006-07-20
SRC_URI=""
SLOT="0"
LICENSE="GPL-2 public-domain"

#mask by keywords
KEYWORDS=""
#"~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

# the blank is intended - an empty string would result in building ALL backends.
BACKENDS=" "

pkg_setup() {
	enewgroup scanner

	use gphoto2 && BACKENDS="gphoto2"
	use v4l && BACKENDS="${BACKENDS} v4l"
	for backend in ${IUSE_SANE_BACKENDS}; do
		if use "sane_backends_${backend}"; then
			BACKENDS="${BACKENDS} ${backend}"
		fi
	done
}

#src_unpack() {
#	unpack ${A}
#	cd "${S}"
#
#	cat >> backend/dll.conf.in <<-EOF
#	# Add support for the HP-specific backend.  Needs net-print/hplip installed.
#	hpaio
#	EOF
#	epatch "${DISTDIR}/${P}-i18n.patch"
#	epatch "${FILESDIR}/xerox-grey.patch"
#}

src_compile() {
	append-flags -fno-strict-aliasing

	myconf=$(use_enable usb libusb)
	if ! use doc; then
		myconf="${myconf} --disable-latex"
	fi
	if use sane_backends_mustek_pp; then
		myconf="${myconf} --enable-parport-directio"
	fi
	if ! ( use sane_backends_canon_pp || use sane_backends_hpsj5s || use sane_backends_mustek_pp ); then
		myconf="${myconf} sane_cv_use_libieee1284=no"
	fi
	SANEI_JPEG="sanei_jpeg.o" SANEI_JPEG_LO="sanei_jpeg.lo" \
	BACKENDS="${BACKENDS}" econf \
		$(use_with gphoto2) \
		$(use_enable ipv6) \
		$(use_enable avahi) \
		${myconf} || die "econf failed"

	emake VARTEXFONTS="${T}/fonts" || die

	if use usb; then
		cd tools/hotplug
		grep -v '^$' libsane.usermap > libsane.usermap.new
		mv libsane.usermap.new libsane.usermap
	fi
}

src_install () {
	make INSTALL_LOCKPATH="" DESTDIR="${D}" install \
		docdir=/usr/share/doc/${PF}
	keepdir /var/lib/lock/sane
	fowners root:scanner /var/lib/lock/sane
	fperms g+w /var/lib/lock/sane
	dodir /etc/env.d
	if use usb; then
		cd tools/hotplug
		insinto /etc/hotplug/usb
		exeinto /etc/hotplug/usb
		doins libsane.usermap
		doexe libusbscanner
		newdoc README README.hotplug
		echo >> "${D}"/etc/env.d/30sane "USB_DEVFS_PATH=/dev/bus/usb"
		cd ../..
	fi
	cd tools/udev
	dodir /etc/udev/rules.d
	insinto /etc/udev/rules.d
	newins libsane.rules 41-libsane.rules
	cd ../..
	dodoc NEWS AUTHORS ChangeLog* README README.linux
	echo "SANE_CONFIG_DIR=/etc/sane.d" >> "${D}"/etc/env.d/30sane
}
