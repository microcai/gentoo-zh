# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
GCONF_DEBUG="no"
PYTHON_COMPAT=( python{3_3,3_4} )

DESCRIPTION="An elegant music player which can get songs from kuwo.cn"
HOMEPAGE="https://github.com/LiuLang/kwplayer"
SRC_URI="https://pypi.python.org/packages/source/k/${PN}/${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="GPL-3"
SLOT="0"
IUSE=" +python_single_target_python3_3 python_single_target_python3_4"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	dev-python/pygobject:3
	dev-python/dbus-python
	dev-python/html2text
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	media-libs/gst-plugins-good:1.0
	media-libs/gst-plugins-ugly:1.0
	media-libs/gst-plugins-bad:1.0
	media-plugins/gst-plugins-libav:1.0
	x11-themes/gnome-icon-theme
	x11-themes/gnome-icon-theme-symbolic
	"
src_compile() {
	if use python_single_target_python3_3 ; then
		python3.3 setup.py build ;
	elif use python_single_target_python3_4 ; then
		python3.4 setup.py build ;
	fi
}
src_install() {
	if use python_single_target_python3_3 ; then
		python3.3 setup.py install --root=${D};
	elif use python_single_target_python3_4 ; then
		python3.4 setup.py install --root=${D};
	fi
}
pkg_postinst() {
	elog "you may need to install some optional dependences by yourself:"
	elog "python3-mutagenx: for id3 tag transforming"
	elog "python3-xlib && python3-keybinder: for global shotkey surport"
}
 
