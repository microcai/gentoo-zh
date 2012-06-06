# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/systemd/systemd-44-r1.ebuild,v 1.2 2012/05/24 02:36:59 vapier Exp $

EAPI=4

inherit autotools-utils bash-completion-r1 linux-info pam systemd user

DESCRIPTION="System and service manager for Linux"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/systemd"
SRC_URI="http://www.freedesktop.org/software/systemd/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="-keymap -quota -coredump acl audit cryptsetup lzma pam plymouth selinux tcpd"

# We need to depend on sysvinit for sulogin which is used in the rescue
# mode. Bug #399615.

# A little higher than upstream requires
# but I had real trouble with 2.6.37 and systemd.
MINKV="3.3"

# dbus version because of systemd units
# sysvinit for sulogin
RDEPEND=">=sys-apps/dbus-1.4.10
	>=sys-apps/kmod-5
	!sys-apps/sysvinit
	>=sys-apps/util-linux-2.19
	sys-libs/libcap
	acl? ( sys-apps/acl )
	audit? ( >=sys-process/audit-2 )
	cryptsetup? ( sys-fs/cryptsetup )
	lzma? ( app-arch/xz-utils )
	pam? ( virtual/pam )
	plymouth? ( sys-boot/plymouth )
	selinux? ( sys-libs/libselinux )
	tcpd? ( sys-apps/tcp-wrappers )
	>=sys-apps/pciutils-3.1"


DEPEND="${RDEPEND}
	app-arch/xz-utils
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	dev-util/gperf
	dev-util/intltool
	>=sys-kernel/linux-headers-${MINKV}
	>=sys-apps/usbutils-005-r1"

pkg_setup() {
	enewgroup lock # used by var-lock.mount
	enewgroup tty 5 # used by mount-setup for /dev/pts
}

src_configure() {
	local myeconfargs=(
		--with-distro=gentoo
		# install everything to /usr
		--with-rootprefix=/usr
		--with-rootlibdir=/usr/$(get_libdir)
		# but pam modules have to lie in /lib*
		--with-pamlibdir=/$(get_libdir)/security
		--localstatedir=/var
		# make sure we get /bin:/sbin in $PATH
		--enable-split-usr
		$(use_enable acl)
		$(use_enable audit)
		$(use_enable cryptsetup libcryptsetup)
		$(use_enable lzma xz)
		$(use_enable pam)
		$(use_enable plymouth)
		$(use_enable selinux)
		$(use_enable tcpd tcpwrap)
		# now in sys-apps/systemd-ui
		--disable-gtk
		--disable-vconsole
		$(use_enable quota quotacheck)
		$(use_enable coredump)
		$(use_enable keymap)
	)

	econf ${myeconfargs[*]}
}

src_compile(){
	emake
}

src_install() {
	emake install DESTDIR="${D}" 

	# compat for init= use
	dosym ../usr/lib/systemd/systemd /bin/systemd
	dosym ../lib/systemd/systemd /usr/bin/systemd
	dosym ../usr/lib/systemd/systemd /sbin/init

	dosym 	systemctl /bin/halt
	dosym	systemctl /bin/reboot
	dosym	systemctl /bin/poweroff
	dosym	systemctl /bin/telinit
	dosym	systemctl /bin/shutdown 
	
	# move files as necessary
	newbashcomp "${D}"/etc/bash_completion.d/systemd-bash-completion.sh ${PN}
	rm -rf "${D}/etc/bash_completion.d" || die

	# Create /run/lock as required by new baselay/OpenRC compat.
	insinto /usr/lib/tmpfiles.d
	doins "${FILESDIR}"/gentoo-run.conf
	#move pam_systemd
	mv "${D}/usr/${get_libdir}/security/pam_systemd.so" "${D}/${get_libdir}/security/pam_systemd.so"
}

pkg_preinst() {
	local CONFIG_CHECK="~AUTOFS4_FS ~CGROUPS ~DEVTMPFS ~FANOTIFY ~IPV6"
	kernel_is -ge ${MINKV//./ } || ewarn "Kernel version at least ${MINKV} required"
	check_extra_config
}

optfeature() {
	local i desc=${1} text
	shift

	text="  [\e[1m$(has_version ${1} && echo I || echo ' ')\e[0m] ${1}"
	shift

	for i; do
		elog "${text}"
		text="& [\e[1m$(has_version ${1} && echo I || echo ' ')\e[0m] ${1}"
	done
	elog "${text} (${desc})"
}

pkg_postinst() {
	mkdir -p "${ROOT}"/run || ewarn "Unable to mkdir /run, this could mean trouble."
	if [[ ! -L "${ROOT}"/etc/mtab ]]; then
		ewarn "Upstream suggests that the /etc/mtab file should be a symlink to /proc/mounts."
		ewarn "It is known to cause users being unable to unmount user mounts. If you don't"
		ewarn "require that specific feature, please call:"
		ewarn "	$ ln -sf '${ROOT}proc/self/mounts' '${ROOT}etc/mtab'"
		ewarn
	fi

	elog "You may need to perform some additional configuration for some programs"
	elog "to work, see the systemd manpages for loading modules and handling tmpfiles:"
	elog "	$ man modules-load.d"
	elog "	$ man tmpfiles.d"
	elog

	ewarn "Add session optional pam_systemd.so to /etc/pam.d/login"
}
