# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

MY_PV=$(ver_cut 1)-$(ver_cut 2)
DESCRIPTION="Gimp Animation Package"
SRC_URI="https://gitlab.gnome.org/Archive/gimp-gap/-/archive/gap-${MY_PV}/gimp-gap-gap-${MY_PV}.tar.bz2"
HOMEPAGE="http://www.gimp.org/"

KEYWORDS="~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE="mpeg mp3"

S="${WORKDIR}/${PN}-gap-${MY_PV}"

DEPEND="
	>=media-gfx/gimp-2.8
	mpeg? ( media-libs/xvid )
"
RDEPEND="
	${DEPEND}
	app-arch/lbzip2
	media-libs/faac
	media-libs/faad2
	media-libs/x264
	mp3? ( >=media-sound/lame-3.9 )
"

src_prepare() {
	eaclocal
	eautoheader
	eautomake
	eautoconf
	einfo "Running glib-gettextize --force"
	glib-gettextize --force || die
	einfo "intltoolize --force --automake"
	intltoolize --force --automake || die

	default

	bsdtar -xf extern_libs/ffmpeg.tar.gz -C extern_libs || die
	# fix building with binutil >= 2.41
	# https://git.ffmpeg.org/gitweb/ffmpeg.git/patch/effadce6c756247ea8bae32dc13bb3e6f464f0eb
	patch -Np1 -i "${FILESDIR}/gimp-gap-2.8-fix-build-for-bundled-ffmpeg.patch" -d extern_libs/ffmpeg || die
	mv -v "${S}"/configure.{ac,in} || die
	# fix library linking order
	sed -i 's/$FFMPEG_LIBAVUTIL_A $FFMPEG_LIBSWSCALE_A/$FFMPEG_LIBSWSCALE_A $FFMPEG_LIBAVUTIL_A/' configure.in || die
}

src_compile() {
	# anything other than -j1 might fail
	emake -j1
}

src_configure() {
	export LIBS='-lm'
	econf --with-ffmpegsrcdir="${S}"/extern_libs/ffmpeg
}

src_install() {
	make DESTDIR="${ED}" install || die "install failed"
	dodoc AUTHORS ChangeLog* NEWS README
	docinto howto
	dodoc docs/howto/txt/*.txt
	docinto reference
	dodoc docs/reference/txt/*.txt
}
