# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit games autotools eutils git-r3

DESCRIPTION="Stepmania 5 sm-ssc branch"
HOMEPAGE="https://github.com/stepmania/stepmania"
SRC_URI=""

EGIT_REPO_URI="https://github.com/stepmania/stepmania.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug X gtk +jpeg +mad +vorbis +network +ffmpeg sse2 bundled-libs"

DEPEND="gtk? ( x11-libs/gtk+:2 )
	media-libs/alsa-lib
	mad? ( media-libs/libmad )
	vorbis? ( media-libs/libvorbis )
	media-libs/libpng
	jpeg? ( virtual/jpeg )
	ffmpeg? ( >=virtual/ffmpeg-0.5 )
	virtual/glu
	x11-libs/libXrandr
	media-libs/glew
	virtual/opengl
	!bundled-libs? ( dev-libs/libpcre dev-libs/jsoncpp )"

remove_bundled_lib() {
	local blib_prefix
	blib_prefix="${S}/extern"
	einfo "Removing bundled library $1 ..."
	rm -rf "${blib_prefix}/$1" || die "Failed removing bundled library $1"
}

remove_dev_theme() {
	local theme_dir
	theme_dir="${S}/Themes"
	einfo "Removing dev theme $1 ..."
	rm -rf "${theme_dir}/$1" || die "Failed removing dev theme $1"
}

src_prepare() {

	# Remove bundled libs, to know if they become forked as lua already is.
	if ! use bundled-libs; then
		remove_bundled_lib "ffmpeg"
		remove_bundled_lib "libjpeg"
		remove_bundled_lib "libpng"
		#remove_bundled_lib "libtomcrypt"
		#remove_bundled_lib "libtommath"
		remove_bundled_lib "mad-0.15.1b"
		remove_bundled_lib "pcre"
		remove_bundled_lib "vorbis"
		remove_bundled_lib "zlib"
	fi
	
	# Remove dev themes
	remove_dev_theme "default-dev-midi"
	remove_dev_theme "HelloWorld"
	remove_dev_theme "MouseTest"
	remove_dev_theme "rsr"

	# Apply various patches
	#	00 - 09: Filepath changes
	#	10 - 19: De-bundle patches
	#	20 - 29: Other fixes
	#	30 - 39; Non-important gameplay patches
	EPATCH_SOURCE="${FILESDIR}" EPATCH_SUFFIX="patch" \
	EPATCH_FORCE="no" epatch || die "Patching failed!"

	# This is used instead of running StepMania's autogen.sh
	eautoreconf
}

src_configure() {
	myconf=""
	if ! use bundled-libs; then
		einfo "Disabling bundled libraries.."
		myconf="${myconf} --with-system-pcre --with-system-ffmpeg"
	fi
	egamesconf \
	--disable-dependency-tracking \
	--enable-lua-binaries \
	--with-extdatadir \
	$(use_enable gtk gtk2) \
	$(use_with debug) \
	$(use_with X x) \
	$(use_with jpeg) \
	$(use_with mad mp3) \
	$(use_with vorbis) \
	$(use_with network) \
	$(use_with ffmpeg) \
	$(use_with sse2) \
	${myconf}
}

src_install() {
	dogamesbin src/${PN} || die "dogamesbin $sm-ssc failed"

	insinto "${GAMES_DATADIR}"/${PN}
	if use gtk ; then
		doins src/GtkModule.so || die "doins GtkModule.so failed"
	fi
	doins -r Announcers _assets BackgroundEffects BackgroundTransitions \
		BGAnimations Characters Courses Data NoteSkins Songs Themes || die "doins failed"
	#dodoc -r Docs || die "dodoc failed"

	newicon "Themes/default/Graphics/Common window icon.png" ${PN}.png
	make_desktop_entry ${PN} Stepmania

	prepgamesdirs

	# Ensure that game can write to Data folder
	fperms -R 775 "${GAMES_DATADIR}"/${PN}/Data
}
