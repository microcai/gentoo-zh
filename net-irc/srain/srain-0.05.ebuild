# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

PYTHON_COMPAT=( python3_4 )

inherit autotools


DESCRIPTION="It does not look like an IRC client"
HOMEPAGE="https://github.com/lastavenger/srain"
SRC_URI="https://github.com/lastavenger/${PN}/archive/${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
  sys-devel/gettext
  media-gfx/imagemagick
"
RDEPEND="${DEPEND}
  >=x11-libs/gtk+-3.16.7
  >=net-libs/libircclient-1.8
  x11-libs/libnotify
"
src_prepare(){
	default
	mkdir build
	sed -i 's,#include <Python.h>,#include <python3.4m/Python.h>,' src/plugin.c || die "sed failed"
	sed -i 's,PY3FLAGS = $(shell pkg-config --cflags python3),PY3FLAGS = $(shell pkg-config --cflags python-3.4m),' src/Makefile || die "sed failed"
	sed -i 's,PY3LIBS = $(shell pkg-config --libs python3),PY3LIBS = $(shell pkg-config --libs python-3.4m),' src/Makefile || die "sed failed"
}
