# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/x-modular.eclass,v 1.81 2006/12/17 15:30:25 joshuabaergen Exp $
#
# Author: Donnie Berkholz <spyderous@gentoo.org>
#
# This eclass is designed to reduce code duplication in the modularized X11
# ebuilds.
#
# Using this eclass:
#
# Inherit it. If you need to run autoreconf for any reason (e.g., your patches
# apply to the autotools files rather than configure), set SNAPSHOT="yes". Set
# CONFIGURE_OPTIONS to everything you want to pass to the configure script.
#
# If you have any patches to apply, set PATCHES to their locations and epatch
# will apply them. It also handles epatch-style bulk patches, if you know how to
# use them and set the correct variables. If you don't, read eutils.eclass.
#
# If you're creating a font package and the suffix of PN is not equal to the
# subdirectory of /usr/share/fonts/ it should install into, set FONT_DIR to that
# directory or directories.
#
# IMPORTANT: Both SNAPSHOT and FONT_DIR must be set _before_ the inherit.
#
# Pretty much everything else should be automatic.

# Directory prefix to use for everything
XDIR="/usr"

# Set up default patchset version(s) if necessary
# x11-driver-patches
if [[ -z "${XDPVER}" ]]; then
	XDPVER="1"
fi

IUSE=""
HOMEPAGE="http://xorg.freedesktop.org/"

# Set up SRC_URI for individual modular releases
BASE_INDIVIDUAL_URI="http://www.qtopia.org.cn/ftp/mirror/ftp.x.org/pub/individual"
if [[ ${CATEGORY} = x11-apps ]] || [[ ${CATEGORY} = x11-wm ]]; then
	SRC_URI="${SRC_URI}
		${BASE_INDIVIDUAL_URI}/app/${P}.tar.bz2"
elif [[ ${CATEGORY} = app-doc ]]; then
	SRC_URI="${SRC_URI}
		${BASE_INDIVIDUAL_URI}/doc/${P}.tar.bz2"
# x11-misc contains data and util, x11-themes contains data
elif [[ ${CATEGORY} = x11-misc ]] || [[ ${CATEGORY} = x11-themes ]]; then
	SRC_URI="${SRC_URI}
		${BASE_INDIVIDUAL_URI}/data/${P}.tar.bz2
		${BASE_INDIVIDUAL_URI}/util/${P}.tar.bz2"
elif [[ ${CATEGORY} = x11-drivers ]]; then
	SRC_URI="${SRC_URI}
		${BASE_INDIVIDUAL_URI}/driver/${P}.tar.bz2"
elif [[ ${CATEGORY} = media-fonts ]]; then
	SRC_URI="${SRC_URI}
		${BASE_INDIVIDUAL_URI}/font/${P}.tar.bz2"
elif [[ ${CATEGORY} = x11-libs ]]; then
	SRC_URI="${SRC_URI}
		${BASE_INDIVIDUAL_URI}/lib/${P}.tar.bz2"
elif [[ ${CATEGORY} = x11-proto ]]; then
	SRC_URI="${SRC_URI}
		${BASE_INDIVIDUAL_URI}/proto/${P}.tar.bz2"
elif [[ ${CATEGORY} = x11-base ]]; then
	SRC_URI="${SRC_URI}
		${BASE_INDIVIDUAL_URI}/xserver/${P}.tar.bz2"
fi

SLOT="0"

# Set the license for the package. This can be overridden by setting
# LICENSE after the inherit.
LICENSE=${PN}

# Set up shared dependencies
if [[ -n "${SNAPSHOT}" ]]; then
# FIXME: What's the minimal libtool version supporting arbitrary versioning?
	DEPEND="${DEPEND}
		>=sys-devel/libtool-1.5
		>=sys-devel/m4-1.4"
	WANT_AUTOCONF="latest"
	WANT_AUTOMAKE="latest"
fi

# If we're a font package, but not the font.alias one
FONT_ECLASS=""
if [[ "${PN/#font-}" != "${PN}" ]] \
	&& [[ "${CATEGORY}" = "media-fonts" ]] \
	&& [[ "${PN}" != "font-alias" ]] \
	&& [[ "${PN}" != "font-util" ]]; then
	# Activate font code in the rest of the eclass
	FONT="yes"

	# Whether to inherit the font eclass
	FONT_ECLASS="font"

	RDEPEND="${RDEPEND}
		media-fonts/encodings
		x11-apps/mkfontscale
		x11-apps/mkfontdir"
	PDEPEND="${PDEPEND}
		media-fonts/font-alias"

	# Starting with 7.0RC3, we can specify the font directory
	# But oddly, we can't do the same for encodings or font-alias

	# Wrap in `if` so ebuilds can set it too
	if [[ -z ${FONT_DIR} ]]; then
		FONT_DIR=${PN##*-}

	fi

	# Fix case of font directories
	FONT_DIR=${FONT_DIR/ttf/TTF}
	FONT_DIR=${FONT_DIR/otf/OTF}
	FONT_DIR=${FONT_DIR/type1/Type1}
	FONT_DIR=${FONT_DIR/speedo/Speedo}

	# Set up configure option
	FONT_OPTIONS="--with-fontdir=\"/usr/share/fonts/${FONT_DIR}\""

	if [[ -n "${FONT}" ]]; then
		if [[ ${PN##*-} = misc ]] || [[ ${PN##*-} = 75dpi ]] || [[ ${PN##*-} = 100dpi ]]; then
			IUSE="${IUSE} nls"
		fi
	fi
fi

# If we're a driver package
if [[ "${PN/#xf86-video}" != "${PN}" ]] || [[ "${PN/#xf86-input}" != "${PN}" ]]; then
	# Enable driver code in the rest of the eclass
	DRIVER="yes"

	if [[ ${XDPVER} != -1 ]]; then
		# Add driver patchset to SRC_URI
		SRC_URI="${SRC_URI}
			http://dev.gentoo.org/~joshuabaergen/distfiles/x11-driver-patches-${XDPVER}.tar.bz2"
	fi
fi

# Debugging -- ignore packages that can't be built with debugging
if [[ -z "${FONT}" ]] \
	|| [[ "${PN/app-doc}" != "${PN}" ]] \
	|| [[ "${PN/x11-proto}" != "${PN}" ]] \
	|| [[ "${PN/util-macros}" != "${PN}" ]] \
	|| [[ "${PN/xbitmaps}" != "${PN}" ]] \
	|| [[ "${PN/xkbdata}" != "${PN}" ]] \
	|| [[ "${PN/xorg-cf-files}" != "${PN}" ]] \
	|| [[ "${PN/xcursor}" != "${PN}" ]] \
	; then
	DEBUGGABLE="yes"
	IUSE="${IUSE} debug"
	if use debug; then
		if ! has splitdebug ${FEATURES}; then
			RESTRICT="${RESTRICT} nostrip"
		fi
	fi
fi

DEPEND="${DEPEND}
	>=dev-util/pkgconfig-0.18"

if [[ "${PN/util-macros}" = "${PN}" ]]; then
	DEPEND="${DEPEND}
		>=x11-misc/util-macros-0.99.2
		>=sys-devel/binutils-2.16.1-r3"
fi

RDEPEND="${RDEPEND}
	|| ( >=sys-apps/man-1.6b-r2 >=sys-apps/man-db-2.4.3-r1 )
	!<=x11-base/xorg-x11-6.9"
# Provides virtual/x11 for temporary use until packages are ported
#	x11-base/x11-env"

inherit eutils libtool multilib toolchain-funcs flag-o-matic autotools ${FONT_ECLASS}

x-modular_specs_check() {
	if [[ ${PN:0:11} = "xorg-server" ]] || [[ -n "${DRIVER}" ]]; then
		append-ldflags -Wl,-z,lazy
		# (#116698) breaks loading
		filter-ldflags -Wl,-z,now
	fi
}

x-modular_dri_check() {
	# (#120057) Enabling DRI in drivers requires that the server was built with
	# support for it
	if [[ -n "${DRIVER}" ]]; then
		if has dri ${IUSE} && use dri; then
			einfo "Checking for direct rendering capabilities ..."
			if ! built_with_use x11-base/xorg-server dri; then
				die "You must build x11-base/xorg-server with USE=dri."
			fi
		fi
	fi
}

x-modular_server_supports_drivers_check() {
	# (#135873) Only certain servers will actually use or be capable of
	# building external drivers, including binary drivers.
	if [[ -n "${DRIVER}" ]]; then
		if has_version '>=x11-base/xorg-server-1.1'; then
			if ! built_with_use x11-base/xorg-server xorg; then
				eerror "x11-base/xorg-server is not built with support for external drivers."
				die "You must build x11-base/xorg-server with USE=xorg."
			fi
		fi
	fi
}

x-modular_unpack_source() {
	unpack ${A}
	cd ${S}

	if [[ -n ${FONT_OPTIONS} ]]; then
		einfo "Detected font directory: ${FONT_DIR}"
	fi
}

x-modular_patch_source() {
	# Use standardized names and locations with bulk patching
	# Patch directory is ${WORKDIR}/patch
	# See epatch() in eutils.eclass for more documentation
	if [[ -z "${EPATCH_SUFFIX}" ]] ; then
		EPATCH_SUFFIX="patch"
	fi

	# If this is a driver package we need to fix man page install location.
	# Running autoreconf will use the patched util-macros to make the
	# change for us, so we only need to patch if it is not going to run.
	if [[ -n "${DRIVER}" ]] && [[ "${SNAPSHOT}" != "yes" ]]\
		&& [[ ${XDPVER} != -1 ]]; then
		PATCHES="${PATCHES} ${DISTDIR}/x11-driver-patches-${XDPVER}.tar.bz2"
	fi

	# For specific list of patches
	if [[ -n "${PATCHES}" ]] ; then
		for PATCH in ${PATCHES}
		do
			epatch ${PATCH}
		done
	# For non-default directory bulk patching
	elif [[ -n "${PATCH_LOC}" ]] ; then
		epatch ${PATCH_LOC}
	# For standard bulk patching
	elif [[ -d "${EPATCH_SOURCE}" ]] ; then
		epatch
	fi
}

x-modular_reconf_source() {
	# Run autoreconf for CVS snapshots only
	if [[ "${SNAPSHOT}" = "yes" ]]
	then
		# If possible, generate configure if it doesn't exist
		if [ -f "./configure.ac" ]
		then
			eautoreconf
		fi
	fi

	# Joshua Baergen - October 23, 2005
	# Fix shared lib issues on MIPS, FBSD, etc etc
	elibtoolize
}

x-modular_src_unpack() {
	x-modular_specs_check
	x-modular_server_supports_drivers_check
	x-modular_dri_check
	x-modular_unpack_source
	x-modular_patch_source
	x-modular_reconf_source
}

x-modular_font_configure() {
	if [[ -n "${FONT}" ]]; then
		# Might be worth adding an option to configure your desired font
		# and exclude all others. Also, should this USE be nls or minimal?
		if ! use nls; then
			FONT_OPTIONS="${FONT_OPTIONS}
				--disable-iso8859-2
				--disable-iso8859-3
				--disable-iso8859-4
				--disable-iso8859-5
				--disable-iso8859-6
				--disable-iso8859-7
				--disable-iso8859-8
				--disable-iso8859-9
				--disable-iso8859-10
				--disable-iso8859-11
				--disable-iso8859-12
				--disable-iso8859-13
				--disable-iso8859-14
				--disable-iso8859-15
				--disable-iso8859-16
				--disable-jisx0201
				--disable-koi8-r"
		fi
	fi
}

x-modular_debug_setup() {
	if [[ -n "${DEBUGGABLE}" ]]; then
		if use debug; then
			strip-flags
			append-flags -g
		fi
	fi
}

x-modular_src_configure() {
	x-modular_font_configure
	x-modular_debug_setup

	# If prefix isn't set here, .pc files cause problems
	if [[ -x ./configure ]]; then
		econf --prefix=${XDIR} \
			--datadir=${XDIR}/share \
			${FONT_OPTIONS} \
			${DRIVER_OPTIONS} \
			${CONFIGURE_OPTIONS}
	fi
}

x-modular_src_make() {
	emake || die "emake failed"
}

x-modular_src_compile() {
	x-modular_src_configure
	x-modular_src_make
}

x-modular_src_install() {
	# Install everything to ${XDIR}
	make \
		DESTDIR="${D}" \
		install
# Shouldn't be necessary in XDIR=/usr
# einstall forces datadir, so we need to re-force it
#		datadir=${XDIR}/share \
#		mandir=${XDIR}/share/man \

	if [[ -e ${S}/ChangeLog ]]; then
		dodoc ${S}/ChangeLog
	fi

	# Make sure docs get compressed
	prepalldocs

	# Don't install libtool archives for server modules
	if [[ -e ${D}/usr/$(get_libdir)/xorg/modules ]]; then
		find ${D}/usr/$(get_libdir)/xorg/modules -name '*.la' \
			| xargs rm -f
	fi

	# Don't install overlapping fonts.* files
	# Generate them instead when possible
	if [[ -n "${FONT}" ]]; then
		remove_font_metadata
	fi

	if [[ -n "${DRIVER}" ]]; then
		install_driver_hwdata
	fi
}

x-modular_pkg_preinst() {
	# We no longer do anything here, but we can't remove it from the API
	:
}

x-modular_pkg_postinst() {
	if [[ -n "${FONT}" ]]; then
		setup_fonts
	fi
}

x-modular_pkg_postrm() {
	if [[ -n "${FONT}" ]]; then
		cleanup_fonts
		font_pkg_postrm
	fi
}

cleanup_fonts() {
	local ALLOWED_FILES="encodings.dir fonts.cache-1 fonts.dir fonts.scale"
	for DIR in ${FONT_DIR}; do
		unset KEEP_FONTDIR
		REAL_DIR=${ROOT}usr/share/fonts/${DIR}

		ebegin "Checking ${REAL_DIR} for useless files"
		pushd ${REAL_DIR} &> /dev/null
		for FILE in *; do
			unset MATCH
			for ALLOWED_FILE in ${ALLOWED_FILES}; do
				if [[ ${FILE} = ${ALLOWED_FILE} ]]; then
					# If it's allowed, then move on to the next file
					MATCH="yes"
					break
				fi
			done
			# If we found a match in allowed files, move on to the next file
			if [[ -n ${MATCH} ]]; then
				continue
			fi
			# If we get this far, there wasn't a match in the allowed files
			KEEP_FONTDIR="yes"
			# We don't need to check more files if we're already keeping it
			break
		done
		popd &> /dev/null
		# If there are no files worth keeping, then get rid of the dir
		if [[ -z "${KEEP_FONTDIR}" ]]; then
			rm -rf ${REAL_DIR}
		fi
		eend 0
	done
}

setup_fonts() {
	if [[ ! -n "${FONT_DIR}" ]]; then
		msg="FONT_DIR is empty. The ebuild should set it to at least one subdir of /usr/share/fonts."
		eerror "${msg}"
		die "${msg}"
	fi

	create_fonts_scale
	create_fonts_dir
	fix_font_permissions
	create_font_cache
}

remove_font_metadata() {
	local DIR
	for DIR in ${FONT_DIR}; do
		if [[ "${DIR}" != "Speedo" ]] && \
			[[ "${DIR}" != "CID" ]] ; then
			# Delete font metadata files
			# fonts.scale, fonts.dir, fonts.cache-1
			rm -f ${D}/usr/share/fonts/${DIR}/fonts.{scale,dir,cache-1}
		fi
	done
}

# Installs device-to-driver mappings for system-config-display
# and anything else that uses hwdata
install_driver_hwdata() {
	insinto /usr/share/hwdata/videoaliases
	for i in "${FILESDIR}"/*.xinf; do
		# We need this for the case when none exist,
		# so *.xinf doesn't expand
		if [[ -e $i ]]; then
			doins $i
		fi
	done
}

discover_font_dirs() {
	FONT_DIRS="${FONT_DIR}"
}

create_fonts_scale() {
	ebegin "Creating fonts.scale files"
		local x
		for DIR in ${FONT_DIR}; do
			x=${ROOT}/usr/share/fonts/${DIR}
			[[ -z "$(ls ${x}/)" ]] && continue
			[[ "$(ls ${x}/)" = "fonts.cache-1" ]] && continue

			# Only generate .scale files if truetype, opentype or type1
			# fonts are present ...

			# NOTE: There is no way to regenerate Speedo/CID fonts.scale
			# <spyderous@gentoo.org> 2 August 2004
			if [[ "${x/encodings}" = "${x}" ]] \
				&& [[ -n "$(find ${x} -iname '*.[pot][ft][abcf]' -print)" ]]; then
				mkfontscale \
					-a ${ROOT}/usr/share/fonts/encodings/encodings.dir \
					-- ${x}
			fi
		done
	eend 0
}

create_fonts_dir() {
	ebegin "Generating fonts.dir files"
		for DIR in ${FONT_DIR}; do
			x=${ROOT}/usr/share/fonts/${DIR}
			[[ -z "$(ls ${x}/)" ]] && continue
			[[ "$(ls ${x}/)" = "fonts.cache-1" ]] && continue

			if [[ "${x/encodings}" = "${x}" ]]; then
				mkfontdir \
					-e ${ROOT}/usr/share/fonts/encodings \
					-e ${ROOT}/usr/share/fonts/encodings/large \
					-- ${x}
			fi
		done
	eend 0
}

fix_font_permissions() {
	ebegin "Fixing permissions"
		for DIR in ${FONT_DIR}; do
			find ${ROOT}/usr/share/fonts/${DIR} -type f -name 'font.*' \
				-exec chmod 0644 {} \;
		done
	eend 0
}

create_font_cache() {
	font_pkg_postinst
}

EXPORT_FUNCTIONS src_unpack src_compile src_install pkg_preinst pkg_postinst pkg_postrm
