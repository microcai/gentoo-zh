# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/freetype/freetype-2.4.11-r2.ebuild,v 1.4 2013/05/04 07:25:29 mgorny Exp $

EAPI=5

inherit autotools-multilib flag-o-matic multilib

DESCRIPTION="A high-quality and portable font engine"
HOMEPAGE="http://www.freetype.org/"
SRC_URI="mirror://sourceforge/freetype/${P/_/}.tar.bz2
	utils?	( mirror://sourceforge/freetype/ft2demos-${PV}.tar.bz2 )
	doc?	( mirror://sourceforge/freetype/${PN}-doc-${PV}.tar.bz2 )
	infinality? ( http://dev.gentoo.org/~polynomial-c/${PN}-2.4.11-infinality-patches.tar.xz )"

LICENSE="|| ( FTL GPL-2+ )"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris ~x86-winnt"
IUSE="X auto-hinter bindist bzip2 +adobe-cff debug doc fontforge infinality static-libs utils"

# Note: replace emul-linux dep when bzip2 becomes multilib-aware
# (and all [${MULTILIB_USEDEP}] on it then!)
DEPEND="sys-libs/zlib
	amd64? ( abi_x86_32? ( app-emulation/emul-linux-x86-baselibs ) )
	bzip2? ( app-arch/bzip2 )
	X?	( x11-libs/libX11
		  x11-libs/libXau
		  x11-libs/libXdmcp )"
RDEPEND="${DEPEND}
	infinality? ( media-libs/fontconfig-infinality )
	abi_x86_32? ( !<=app-emulation/emul-linux-x86-xlibs-20130224 )"

src_prepare() {
	enable_option() {
		sed -i -e "/#define $1/a #define $1" \
			include/freetype/config/ftoption.h \
			|| die "unable to enable option $1"
	}

	disable_option() {
		sed -i -e "/#define $1/ { s:^:/*:; s:$:*/: }" \
			include/freetype/config/ftoption.h \
			|| die "unable to disable option $1"
	}

	if ! use bindist; then
		# See http://freetype.org/patents.html
		# ClearType is covered by several Microsoft patents in the US
		enable_option FT_CONFIG_OPTION_SUBPIXEL_RENDERING
	fi

	if use auto-hinter; then
		disable_option TT_CONFIG_OPTION_BYTECODE_INTERPRETER
		enable_option TT_CONFIG_OPTION_UNPATENTED_HINTING
	fi

	if use adobe-cff; then
		epatch ${FILESDIR}/freetype-2.4.12-set-cff-hinting-as-default.patch
	fi

	if use debug; then
		enable_option FT_DEBUG_LEVEL_TRACE
		enable_option FT_DEBUG_MEMORY
	fi

	if use infinality; then
		epatch "${WORKDIR}"/patches/freetype-enable-subpixel-hinting-infinality.patch
		epatch "${WORKDIR}"/patches/freetype-entire-infinality-patchset.patch

		# FT_CONFIG_OPTION_SUBPIXEL_RENDERING is already enabled in
		# freetype-2.4.11
		enable_option TT_CONFIG_OPTION_SUBPIXEL_HINTING
	fi

	epatch "${FILESDIR}"/${PN}-2.3.2-enable-valid.patch

	epatch "${FILESDIR}"/${PN}-2.4.11-sizeof-types.patch # 459966

	if use utils; then
		cd "${WORKDIR}/ft2demos-${PV}" || die
		# Disable tests needing X11 when USE="-X". (bug #177597)
		if ! use X; then
			sed -i -e "/EXES\ +=\ ftdiff/ s:^:#:" Makefile || die
		fi
	fi

	# we need non-/bin/sh to run configure
	[[ -n ${CONFIG_SHELL} ]] && \
		sed -i -e "1s:^#![[:space:]]*/bin/sh:#!$CONFIG_SHELL:" \
			"${S}"/builds/unix/configure

	autotools-utils_src_prepare
}

src_configure() {
	append-flags -fno-strict-aliasing
	type -P gmake &> /dev/null && export GNUMAKE=gmake

	local myeconfargs=(
		--enable-biarch-config
		$(use_with bzip2)
	)

	autotools-multilib_src_configure
}

src_compile() {
	autotools-multilib_src_compile

	if use utils; then
		einfo "Building utils"
		# fix for Prefix, bug #339334
		multilib_for_best_abi autotools-utils_src_compile \
			X11_PATH="${EPREFIX}/usr/$(get_libdir)" \
			FT2DEMOS=1 TOP_DIR_2="${WORKDIR}/ft2demos-${PV}"
	fi
}

src_install() {
	autotools-multilib_src_install

	if use utils; then
		install_utils() {
			einfo "Installing utils"
			rm "${WORKDIR}"/ft2demos-${PV}/bin/README || die
			local ft2demo
			for ft2demo in ../ft2demos-${PV}/bin/*; do
				"${BUILD_DIR}"/libtool --mode=install $(type -P install) -m 755 "$ft2demo" \
					"${ED}"/usr/bin || die
			done
		}
		multilib_for_best_abi install_utils
	fi

	if use fontforge; then
		# Probably fontforge needs less but this way makes things simplier...
		einfo "Installing internal headers required for fontforge"
		local header
		find src/truetype include/freetype/internal -name '*.h' | \
		while read header; do
			mkdir -p "${ED}/usr/include/freetype2/internal4fontforge/$(dirname ${header})" || die
			cp ${header} "${ED}/usr/include/freetype2/internal4fontforge/$(dirname ${header})" || die
		done
	fi

	dodoc docs/{CHANGES,CUSTOMIZE,DEBUG,*.txt,PROBLEMS,TODO}
	use doc && dohtml -r docs/*
}
