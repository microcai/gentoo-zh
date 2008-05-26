inherit eutils

IUSE=""

#S=${WORKDIR}/${PN}
DESCRIPTION="A Good True Type Font Manager from firefly"
SRC_URI="http://firefly.idv.tw/setfont-xft/fonttools/SRC/${P}.tar.gz"
HOMEPAG="http://firefly.idv.tw/test/Forum.php?Board=1"
LICENSE="GPL"
KEYWORDS="x86 ~alpha ~ppc ~sparc ~mips ~hppa ~arm"

#DEPEND="=media-libs/freetype-1.3.1"

src_compile() {
	cd ${S}
	epatch $FILESDIR/xttmgr.path_fix.patch
	emake || die
}
src_install(){
	mkdir -p ${D}/usr/sbin ${D}/usr/share/fonts/ttf
	cp xttmgr ${D}/usr/sbin
}
