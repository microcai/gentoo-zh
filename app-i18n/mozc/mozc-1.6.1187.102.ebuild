# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/mozc/mozc-1.6.1187.102.ebuild,v 1.1 2012/10/02 02:47:18 naota Exp $

EAPI="3"
PYTHON_DEPEND="2"
inherit elisp-common eutils multilib multiprocessing python toolchain-funcs

DESCRIPTION="The Mozc engine for IBus Framework"
HOMEPAGE="http://code.google.com/p/mozc/"

PROTOBUF_VER="2.4.1"
GMOCK_VER="403"
MOZC_URL="http://mozc.googlecode.com/files/${P}.tar.bz2"
PROTOBUF_URL="http://protobuf.googlecode.com/files/protobuf-${PROTOBUF_VER}.tar.bz2"
SRC_URI="${MOZC_URL} ${PROTOBUF_URL}"

LICENSE="Apache-2.0 BSD Boost-1.0 ipadic public-domain unicode"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="emacs fcitx +ibus +qt4 renderer"

RDEPEND="dev-libs/glib:2
	dev-libs/openssl
	x11-libs/libxcb
	emacs? ( virtual/emacs )
	fcitx? ( app-i18n/fcitx )
	ibus? ( >=app-i18n/ibus-1.4.1 )
	renderer? ( x11-libs/gtk+:2 )
	qt4? (
		dev-qt/qtgui:4
		app-i18n/zinnia
	)"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

BUILDTYPE="${BUILDTYPE:-Release}"

RESTRICT="test"

SITEFILE=50${PN}-gentoo.el

pkg_setup() {
	python_set_active_version 2
}

src_unpack() {
	unpack $(basename ${MOZC_URL})

	cd "${S}"/protobuf
	unpack $(basename ${PROTOBUF_URL})
	mv protobuf-${PROTOBUF_VER} files
}

src_configure() {
	local myconf="--channel_dev=0"
	myconf+=" --server_dir=/usr/$(get_libdir)/mozc"

	if use fcitx; then
		EPATCH_OPTS="-p2" epatch "${FILESDIR}/fcitx-${P}.1.patch"
	fi

	if ! use qt4 ; then
		myconf+=" --noqt"
		export GYP_DEFINES="use_libzinnia=0"
	fi

	if ! use renderer ; then
		export GYP_DEFINES="${GYP_DEFINES} enable_gtk_renderer=0"
	fi

	"$(PYTHON)" build_mozc.py gyp ${myconf} || die "gyp failed"
}

src_compile() {
	tc-export CC CXX AR AS RANLIB LD

	local my_makeopts=$(makeopts_jobs)
	# This is for a safety. -j without a number, makeopts_jobs returns 999.
	local myjobs=-j${my_makeopts/999/1}

	local mytarget="server/server.gyp:mozc_server"
	use emacs && mytarget="${mytarget} unix/emacs/emacs.gyp:mozc_emacs_helper"
	use fcitx && mytarget="${mytarget} unix/fcitx/fcitx.gyp:fcitx-mozc"
	use ibus && mytarget="${mytarget} unix/ibus/ibus.gyp:ibus_mozc"
	use renderer && mytarget="${mytarget} renderer/renderer.gyp:mozc_renderer"
	if use qt4 ; then
		export QTDIR="${EPREFIX}/usr"
		mytarget="${mytarget} gui/gui.gyp:mozc_tool"
	fi

	"$(PYTHON)" build_mozc.py build_tools -c "${BUILDTYPE}" ${myjobs} || die
	"$(PYTHON)" build_mozc.py build -c "${BUILDTYPE}" ${mytarget} ${myjobs} || die

	if use emacs ; then
		elisp-compile unix/emacs/*.el || die
	fi
}

src_test() {
	"$(PYTHON)" build_mozc.py runtests -c "${BUILDTYPE}" || die
}

src_install() {
	if use emacs ; then
		dobin "out_linux/${BUILDTYPE}/mozc_emacs_helper" || die
		elisp-install ${PN} unix/emacs/*.{el,elc} || die
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" ${PN} || die
	fi

	if use fcitx; then
		exeinto /usr/$(get_libdir)/fcitx || die
		doexe "out_linux/${BUILDTYPE}/fcitx-mozc.so" || die
		insinto /usr/share/fcitx/addon || die
		doins "unix/fcitx/fcitx-mozc.conf" || die
		insinto /usr/share/fcitx/inputmethod || die
		doins "unix/fcitx/mozc.conf" || die
		insinto /usr/share/fcitx/mozc/icon || die
		(
			cd data/images
			newins product_icon_32bpp-128.png mozc.png || die
			cd unix
			for f in ui-*
			do
				newins ${f} "mozc-${f/ui-}" || die
			done
		)
		for mofile in out_linux/${BUILDTYPE}/obj/gen/unix/fcitx/po/*.mo
		do
			filename=`basename $mofile` || die
			lang=${filename/.mo/} || die
			insinto /usr/share/locale/$lang/LC_MESSAGES/ || die
			newins ${mofile} fcitx-mozc.mo || die
		done
	fi

	if use ibus ; then
		exeinto /usr/libexec || die
		newexe "out_linux/${BUILDTYPE}/ibus_mozc" ibus-engine-mozc || die
		insinto /usr/share/ibus/component || die
		doins "out_linux/${BUILDTYPE}/obj/gen/unix/ibus/mozc.xml" || die
		insinto /usr/share/ibus-mozc || die
		(
			cd data/images/unix
			newins ime_product_icon_opensource-32.png product_icon.png || die
			for f in ui-*
			do
				newins ${f} ${f/ui-} || die
			done
		)

	fi

	exeinto "/usr/$(get_libdir)/mozc" || die
	doexe "out_linux/${BUILDTYPE}/mozc_server" || die

	if use qt4 ; then
		exeinto "/usr/$(get_libdir)/mozc" || die
		doexe "out_linux/${BUILDTYPE}/mozc_tool" || die
	fi

	if use renderer ; then
		exeinto "/usr/$(get_libdir)/mozc" || die
		doexe "out_linux/${BUILDTYPE}/mozc_renderer" || die
	fi
}

pkg_postinst() {
	if use emacs ; then
		elisp-site-regen
		elog "You can use mozc-mode via LEIM (Library of Emacs Input Method)."
		elog "Write the following settings into your init file (~/.emacs.d/init.el"
		elog "or ~/.emacs) in order to use mozc-mode by default, or you can call"
		elog "\`set-input-method' and set \"japanese-mozc\" anytime you have loaded"
		elog "mozc.el"
		elog
		elog "  (require 'mozc)"
		elog "  (set-language-environment \"Japanese\")"
		elog "  (setq default-input-method \"japanese-mozc\")"
		elog
		elog "Having the above settings, just type C-\\ which is bound to"
		elog "\`toggle-input-method' by default."
	fi
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
