# ebuild written by Rene Gass <kde-package@gmx.de>
# Distributed under the terms of the GNU General Public License v2
#
# ebuild v 1.02

inherit kde versionator

MY_P="KVideoEncoder-"$(replace_version_separator 2 '')
S=${WORKDIR}/${MY_P}

DESCRIPTION="KVideoEncoder is a GUI for mencoder and transcode"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=31385"
SRC_URI="mirror://sourceforge/kvideoencoder/${MY_P}.tar.bz2"
RESTRICT="mirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

DEPEND="kde-base/kdelibs
	media-video/mplayer"

pkg_setup() {
	if ! built_with_use media-video/mplayer encode ; then
		eerror "Sorry, mplayer must be built with USE=encode"
		die "Please rebuild mplayer with USE=encode"
	fi
}

src_compile() {
	# look for qmake at /usr/qt/3/bin/qmake first, in case more than one Qt is installed:
	sed -i "s:qmake=\"\`which qmake\`\":qmake=\"\`which /usr/qt/3/bin/qmake\`\"; if [ \"\$qmake\" = \"\" ]; then qmake=\"\`which qmake\`\"; fi:" configure
	./configure --prefix=/usr || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	rm -rf "${D}"/etc # no need for the file /etc/kvideoencoder if we install to /usr
}

