# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils

MY_PN="gstreamer-vaapi"
DESCRIPTION="Hardware accelerated video decoding through VA-API plugin"
HOMEPAGE="http://gitorious.org/vaapi/gstreamer-vaapi"
SRC_URI="http://www.freedesktop.org/software/vaapi/releases/${MY_PN}/${MY_PN}-${PV}.tar.bz2"

LICENSE=""
SLOT="1.0"
KEYWORDS="~amd64"
IUSE="+X opengl wayland"

RDEPEND="
	>=dev-libs/glib-2.28:2
	>=media-libs/gstreamer-0.10:${SLOT}
	>=media-libs/gst-plugins-base-0.10:${SLOT}
	>=media-libs/gst-plugins-bad-0.10:${SLOT}
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libXrandr
	>=x11-libs/libva-1.1.0[X?,opengl?,wayland?]
	virtual/opengl
	virtual/udev
	wayland? ( >=dev-libs/wayland-1 )
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.9
	virtual/pkgconfig"

S="${WORKDIR}/${MY_PN}-${PV}"

src_configure() {
	econf \
		--disable-static \
		--enable-drm \
		--with-gstreamer-api=${SLOT} \
		$(use_enable opengl glx) \
		$(use_enable wayland) \
		$(use_enable X x11)
}

src_compile() {
	default
}

src_install() {
	default
	prune_libtool_files
}
