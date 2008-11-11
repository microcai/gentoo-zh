# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

inherit eutils linux-info

PROTECT_VER="3"

DESCRIPTION="IBM ThinkPad Harddrive Active Protection disk head parking daemon"
HOMEPAGE="http://hdaps.sourceforge.net/"
SRC_URI="http://gentoo-china-overlay.googlecode.com/svn/distfiles/${P}.c.bz2
	http://gentoo-china-overlay.googlecode.com/svn/distfiles/hdaps_protect-patches-${PROTECT_VER}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
RDEPEND=">=app-laptop/tp_smapi-0.32"

S="${WORKDIR}"

src_compile() {
	# We require the hdaps module; problem is that it can come from either
	# kernel sources or from the tp_smapi package. This hack is required because
	# the linux-info eclass doesn't export any more suitable config checkers.
	# Here we just skip calling its pkg_setup() in case the module is provided
	# by the package.

	if ! has_version app-laptop/tp_smapi || ! built_with_use app-laptop/tp_smapi hdaps; then
		CONFIG_CHECK="SENSORS_HDAPS"
		ERROR_SENSORS_HDAPS="${P} requires support for HDAPS (CONFIG_SENSORS_HDAPS)"
		linux-info_pkg_setup
	fi

	cd "${WORKDIR}"
	gcc ${CFLAGS} "${P}".c -o hdapsd || die "failed to compile"
}

src_install() {
	dosbin "${WORKDIR}"/hdapsd
	newconfd "${FILESDIR}"/hdapsd.conf hdapsd
	newinitd "${FILESDIR}"/hdapsd.init hdapsd

	# Install our kernel patches
	# Ecompress is no-op in paludis, so here we use doins not dodoc.
	insinto /usr/share/doc/${PF}
	doins *.patch "${FILESDIR}"/hdaps-Z60m.patch

	# Install udev file
	insinto /etc/udev/rules.d/
	newins "${FILESDIR}"/51-hdaps.rules 51-hdaps.rules
}

# Yes, this sucks as the source location may change, kernel sources may not be
# installed, but we try our best anyway
kernel_patched() {
	get_version

	if grep -qs "blk_protect_register" "${KERNEL_DIR}"/block/ll_rw_blk.c ; then
		einfo "Your kernel has already been patched for blk_freeze"
		return 0
	fi

	return 1
}

pkg_config() {
	kernel_patched && return 0

	local docdir="${ROOT}/usr/share/doc/${PF}"
	local p="hdaps_protect-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}.patch"

	# We need to find our FILESDIR as it's now lost
	if [[ ! -e ${docdir}/${p} ]] ; then
		eerror "We don't have a patch for kernel ${KV_MAJOR}.${KV_MINOR}.${KV_PATCH} yet"
		return 1
	fi

	if [[ ! -d ${KERNEL_DIR} ]] ; then
		eerror "Kernel sources not found!"
		return 1
	fi

	cd "${KERNEL_DIR}"
	epatch "${docdir}/${p}"

	# This is just a nice to have for me as I use a Z60m myself
	if ! grep -q "Z60m" "${KERNEL_DIR}"/drivers/hwmon/hdaps.c ; then
		epatch "${docdir}"/hdaps-Z60m.patch
	fi

	echo
	einfo "Now you should rebuild your kernel, its modules"
	einfo "and then install them."
}

pkg_postinst(){
	# Small change for new disk-protect interface in 2.6.27
	# http://article.gmane.org/gmane.linux.drivers.hdaps.devel/1372
	[[ -n $(ls "${ROOT}"/sys/block/*/queue/protect 2>/dev/null) ]] || \
	[[ -n $(ls "${ROOT}"/sys/block/*/device/unload_heads 2>/dev/null) ]] && \
	return 0

	if ! kernel_patched ; then
		ewarn "Your kernel has NOT been patched for blk_freeze"
		elog "The ebuild can attempt to patch your kernel like so"
		elog "   emerge --config =${PF} or paludis --config ${PN}"
	fi
}
