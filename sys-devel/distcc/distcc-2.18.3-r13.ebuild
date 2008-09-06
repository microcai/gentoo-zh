# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/distcc/distcc-2.18.3-r13.ebuild,v 1.2 2008/08/17 03:24:18 mr_bones_ Exp $

# If you change this in any way please email lisa@gentoo.org and make an
# entry in the ChangeLog (this means you spanky :P). (2004-04-11) Lisa Seelye

inherit autotools eutils flag-o-matic toolchain-funcs fdo-mime

PATCHLEVEL="2.18-r1"

DESCRIPTION="a program to distribute compilation of C code across several machines on a network"
HOMEPAGE="http://distcc.samba.org/"
SRC_URI="http://distcc.samba.org/ftp/distcc/distcc-${PV}.tar.bz2
	mirror://gentoo/${PN}-2.18-avahi.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="avahi gnome gtk selinux ipv6"

COMMON_DEP="dev-libs/popt
	avahi? ( >=net-dns/avahi-0.6.5 )"
DEPEND=">=sys-devel/gcc-config-1.3.1
	userland_GNU? ( sys-apps/shadow )
	dev-util/pkgconfig
	|| ( dev-util/unifdef sys-freebsd/freebsd-ubin )
	>=sys-devel/autoconf-2.60
	${COMMON_DEP}"
RDEPEND="
	gnome? (
		>=x11-libs/gtk+-2.0.0
		>=gnome-base/libgnome-2.0.0
		>=gnome-base/libgnomeui-2.0.0.0
		>=gnome-base/libglade-2.0.0
		x11-libs/pango
		>=gnome-base/gconf-2.0.0
	)
	gtk? (
		>=x11-libs/gtk+-2.0.0
		x11-libs/pango
	)
	selinux? ( sec-policy/selinux-distcc )
	${COMMON_DEP}"

pkg_setup() {
	if use avahi && ! built_with_use net-dns/avahi dbus; then
		eerror "${CATEGORY}/${PN} needs net-dns/avahi built with the dbus use"
		eerror "flag for avahi support."
		die "net-dns/avahi not built with dbus support"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# -Wl,--as-needed to close bug #128605
	epatch "${FILESDIR}/distcc-as-needed.patch"

	# See bug #75420 for more multilib stuff
	epatch "${FILESDIR}/distcc-gentoo-multilib-r1.patch"
	einfo "Please report to bug #75420 success or failure of this patch."

	epatch "${FILESDIR}/distcc-freedesktop.patch"
	epatch "${FILESDIR}/distcc-create-dir.patch"
	epatch "${FILESDIR}"/${PN}-march-native.patch

	rm -v popt/*.c || die
	if use avahi; then
		epatch "${DISTDIR}/${PN}-2.18-avahi.patch.bz2"
		epatch "${FILESDIR}/${PN}-avahi-configure.patch"
		epatch "${FILESDIR}/${PF}-zeroconf-multiple-gcc-registration.patch"
	fi

	eautoreconf
}

src_compile() {
	local myconf="--without-included-popt --docdir=/usr/share/doc/${PF}"

	#More legacy stuff?
	[ `gcc-major-version` -eq 2 ] && filter-lfs-flags

	if use ipv6; then
		ewarn "To use IPV6 you must have IPV6 compiled into your kernel"
		ewarn "either via a module or compiled code"
		ewarn "You can recompile without ipv6 with: USE='-ipv6' emerge distcc"
		myconf=" ${myconf} --enable-rfc2553 "
		epause 5
	fi
	econf ${myconf} $(use_enable avahi) $(use_with gnome) $(use_with gtk) || die "econf ${myconf} failed"
	emake || die "emake failed"
}

handle_avahi() {
	local avahi="-UAVAHI"
	use avahi && avahi="-DAVAHI"
	unifdef ${avahi} "${1}" > "${2}"
}

src_install() {
	make DESTDIR="${D%/}" install

	dodoc "${S}/survey.txt"

	exeinto /usr/bin
	doexe "${FILESDIR}/distcc-config"

	handle_avahi "${FILESDIR}/${PATCHLEVEL}/init" "${T}/init"
	newinitd "${T}/init" distccd || die

	handle_avahi "${FILESDIR}/${PATCHLEVEL}/conf" "${T}/conf"
	newconfd "${T}/conf" distccd || die

	# create and keep the symlink dir
	dodir /usr/lib/distcc/bin
	keepdir /usr/lib/distcc/bin

	# create the distccd pid directory
	dodir /var/run/distccd
	keepdir /var/run/distccd

	if use gnome || use gtk; then
	  einfo "Renaming /usr/bin/distccmon-gnome to /usr/bin/distccmon-gui"
	  einfo "This is to have a little sensability in naming schemes between distccmon programs"
	  mv "${D}/usr/bin/distccmon-gnome" "${D}/usr/bin/distccmon-gui" || die
	  dosym /usr/bin/distccmon-gui /usr/bin/distccmon-gnome
	fi

}

pkg_preinst() {
	# non-/ installs don't require us to do anything here
	[ "${ROOT}" != "/" ] && return 0

	# stop daemon since script is being updated
	[ -n "$(pidof distccd)" -a -x /etc/init.d/distccd ] && \
		/etc/init.d/distccd stop
}

pkg_postinst() {
	fdo-mime_desktop_database_update

	#are we doing bootstrap with has no useradd?
	if [[ ${CHOST} != *-*-gnu && ${CHOST} != *-linux* ]] || [ -x /usr/sbin/useradd ]; then
	  enewuser distcc 240
	else
	  ewarn "You do not have useradd (bootstrap) from shadow so I didn't"
	  ewarn "install the distcc user.  Note that attempting to start the daemon"
	  ewarn "will fail. Please install shadow and re-emerge distcc."
	  ebeep 2
	fi

	# By now everyone should be using the right envfile

	if [ "${ROOT}" = "/" ]; then
		einfo "Installing links to native compilers..."
		/usr/bin/distcc-config --install
	else
		# distcc-config can *almost* handle ROOT installs itself
		#  but for now, but user must finsh things off
		ewarn "*** Installation is not complete ***"
		ewarn "You must run the following as root:"
		ewarn "  /usr/bin/distcc-config --install"
		ewarn "after booting or chrooting into ${ROOT}"
	fi
	einfo "Setting permissions on ${ROOT}var/run/distccd"
	chown -R distcc:daemon "${ROOT}var/run/distccd"
	echo ""

	einfo "Tips on using distcc with Gentoo can be found at"
	einfo "http://www.gentoo.org/doc/en/distcc.xml"
	echo ""
	einfo "To use the distccmon programs with Gentoo you should use this command:"
	einfo "      DISTCC_DIR=/var/tmp/portage/.distcc distccmon-text N"
	use gnome || use gtk && einfo "Or:   DISTCC_DIR=/var/tmp/portage/.distcc distccmon-gnome"

	ewarn "***SECURITY NOTICE***"
	ewarn "If you are upgrading distcc please make sure to run etc-update to"
	ewarn "update your /etc/conf.d/distccd and /etc/init.d/distccd files with"
	ewarn "added security precautions (the --listen and --allow directives)"
	ebeep 5
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
