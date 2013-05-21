# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/crossover-bin/crossover-bin-12.1.2.ebuild,v 1.3 2013/04/22 18:05:45 mgorny Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_5,2_6,2_7} )
PYTHON_REQ_USE="threads"

inherit python-single-r1 unpacker

DESCRIPTION="Commercial version of app-emulation/wine with paid support."
HOMEPAGE="http://www.codeweavers.com/products/crossover/"
SRC_URI="install-crossover-${PV}.bin"

LICENSE="CROSSOVER-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="+capi +cups doc +gphoto2 +gsm +jpeg +lcms +ldap +mp3 +nls +openal +opengl +png +scanner +ssl +v4l"
RESTRICT="fetch test"
QA_FLAGS_IGNORED="opt/cxoffice/.*"
QA_PRESTRIPPED="opt/cxoffice/lib/.*
	opt/cxoffice/bin/cxburner
	opt/cxoffice/bin/cxntlm_auth
	opt/cxoffice/bin/wineserver
	opt/cxoffice/bin/unrar
	opt/cxoffice/bin/wine-preloader
	opt/cxoffice/bin/cxdiag
	opt/cxoffice/bin/cxgettext
	opt/cxoffice/bin/wineloader
	"
S="${WORKDIR}"

MLIB_DEPS="amd64? (
	openal? ( app-emulation/emul-linux-x86-sdl )
	opengl? ( app-emulation/emul-linux-x86-opengl )
	scanner? ( app-emulation/emul-linux-x86-medialibs )
	v4l? ( app-emulation/emul-linux-x86-medialibs )
	app-emulation/emul-linux-x86-baselibs
	app-emulation/emul-linux-x86-soundlibs
	|| (
		(
			>=media-libs/freetype-2.0.0[abi_x86_32]
			x11-libs/libICE[abi_x86_32]
			x11-libs/libSM[abi_x86_32]
			x11-libs/libX11[abi_x86_32]
			x11-libs/libXau[abi_x86_32]
			x11-libs/libXdmcp[abi_x86_32]
			x11-libs/libXext[abi_x86_32]
			x11-libs/libXi[abi_x86_32]
			x11-libs/libXrandr[abi_x86_32]
			x11-libs/libXxf86vm[abi_x86_32]
			x11-libs/libxcb[abi_x86_32]
		)
		app-emulation/emul-linux-x86-xlibs
	)
)"

X86_DEPS="x86? (
	capi? ( net-dialup/capi4k-utils )
	cups? ( net-print/cups )
	gsm? ( media-sound/gsm )
	jpeg? ( virtual/jpeg )
	lcms? ( media-libs/lcms:0 )
	ldap? ( net-nds/openldap )
	gphoto2? ( media-libs/libgphoto2 )
	mp3? ( >=media-sound/mpg123-1.5.0 )
	nls? ( sys-devel/gettext )
	openal? ( media-libs/openal )
	opengl? (
		virtual/glu
		virtual/opengl
	)
	png? ( media-libs/libpng:0 )
	scanner? ( media-gfx/sane-backends )
	ssl? ( dev-libs/openssl:0 )
	v4l? ( media-libs/libv4l )
	media-libs/alsa-lib
	>=media-libs/freetype-2.0.0
	media-libs/mesa
	sys-apps/util-linux
	sys-libs/zlib
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXxf86vm
	x11-libs/libxcb
	)"

DEPEND="dev-lang/perl
	app-arch/unzip"

RDEPEND="${DEPEND}
	!prefix? ( sys-libs/glibc )
	>=dev-python/pygtk-2.10
	dev-util/desktop-file-utils
	sys-apps/dbus
	!app-emulation/crossover-office-pro-bin
	!app-emulation/crossover-office-bin
	${MLIB_DEPS}
	${X86_DEPS}
	"

pkg_nofetch() {
	einfo "Please visit ${HOMEPAGE}"
	einfo "and place ${A} in ${DISTDIR}"
}

src_unpack() {
	# self unpacking zip archive; unzip warns about the exe stuff
	unpack_zip ${A}
}

src_prepare() {
	python_fix_shebang .
	sed -e 's:/usr/local/etc/xdg /etc/xdg::' -i "${WORKDIR}/bin/locate_gui.sh" \
		 || die "Could not patch ${WORKDIR}/bin/locate_gui.sh"

	# Remove unnecessary files
	rm -r license.txt guis/ || die "Could not remove files"
	use doc || rm -r doc/ || die "Could not remove files"
}

src_install() {
	# Install documentation
	dodoc README changelog.txt
	rm README changelog.txt || die "Could not remove README and changelog.txt"

	# Install files
	dodir /opt/cxoffice
	cp -r ./* "${ED}opt/cxoffice" \
		|| die "Could not install into ${ED}opt/cxoffice"

	# Install configuration file
	insinto /opt/cxoffice/etc
	doins share/crossover/data/cxoffice.conf

	# Install requisite directories for menus
	dodir "/usr/share/applications"
	dodir "/etc/xdg/menus/applications-merged"

	# Install menus
	XDG_CONFIG_DIRS="${ED}etc/xdg" \
		XDG_DATA_DIRS="${ED}usr/share" \
		"${ED}opt/cxoffice/bin/cxmenu" --crossover --install \
		|| die "Could not install menus"

	# Fix menus
	sed -e "s:${ED}:/:" -i "${ED}usr/share/applications/"* \
		|| die "Could not fix menus"
}
