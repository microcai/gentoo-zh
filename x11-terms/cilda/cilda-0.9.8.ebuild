# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit eutils autotools

DESCRIPTION="cilda = Cai forked Tilda"
HOMEPAGE="https://github.com/microcai/cilda"
SRC_URI="http://cloud.github.com/downloads/microcai/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=x11-libs/vte-0.30.1
	>=dev-libs/glib-2.32
	>=x11-libs/gtk+-3.0
	dev-libs/confuse"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die
}

echo_patch(){
cat << _EOF
diff --git a/src/cilda.c b/src/cilda.c
index 2db1155..1bdaf86 100644
--- a/src/cilda.c
+++ b/src/cilda.c
@@ -219,6 +219,7 @@ int main (int argc, char *argv[])
     gboolean need_wizard = FALSE;
     gchar *config_file;
 
+    chdir(g_get_home_dir());
 
     config_file = get_config_file_name ();
_EOF
}

src_prepare(){
	echo_patch | patch -p1
}
