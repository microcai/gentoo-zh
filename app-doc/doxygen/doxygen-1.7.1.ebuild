# Originally from:

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/doxygen/doxygen-1.6.3.ebuild,v 1.2 2010/05/22 09:00:44 jlec Exp $

EAPI=3

inherit eutils flag-o-matic toolchain-funcs qt4-r2 fdo-mime

DESCRIPTION="documentation system for C++, C, Java, Objective-C, Python, IDL, and other languages"
HOMEPAGE="http://www.doxygen.org/"
SRC_URI="ftp://ftp.stack.nl/pub/users/dimitri/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="debug doc nodot qt4 latex elibc_FreeBSD"

RDEPEND="qt4? ( x11-libs/qt-gui:4 )
	latex? ( >=app-text/texlive-2008[extra] )
	dev-lang/python
	virtual/libiconv
	media-libs/libpng
	app-text/ghostscript-gpl
	!nodot? ( >=media-gfx/graphviz-2.20.0
		media-libs/freetype )"
DEPEND=">=sys-apps/sed-4
	sys-devel/flex
	${RDEPEND}"

EPATCH_SUFFIX="patch"

src_prepare() {
	# use CFLAGS, CXXFLAGS, LDFLAGS
	sed -i.orig -e 's:^\(TMAKE_CFLAGS_RELEASE\t*\)= .*$:\1= $(ECFLAGS):' \
		-e 's:^\(TMAKE_CXXFLAGS_RELEASE\t*\)= .*$:\1= $(ECXXFLAGS):' \
		-e 's:^\(TMAKE_LFLAGS_RELEASE\s*\)=.*$:\1= $(ELDFLAGS):' \
		tmake/lib/{{linux,freebsd,netbsd,openbsd,solaris}-g++,macosx-c++}/tmake.conf \
		|| die "sed 1 failed"

	# Ensure we link to -liconv
	if use elibc_FreeBSD; then
		for pro in */*.pro.in */*/*.pro.in; do
		echo "unix:LIBS += -liconv" >> "${pro}"
		done
	fi

	# prefix search tools patch, plus OSX fixes
	epatch "${FILESDIR}"/${PN}-1.5.6-prefix-misc-alt.patch

	# fix final DESTDIR issue
	sed -i.orig -e "s:\$(INSTALL):\$(DESTDIR)/\$(INSTALL):g" \
		addon/doxywizard/Makefile.in || die "sed 2 failed"

	if is-flagq "-O3" ; then
		echo
		ewarn "Compiling with -O3 is known to produce incorrectly"
		ewarn "optimized code which breaks doxygen."
		echo
		elog "Continuing with -O2 instead ..."
		echo
		replace-flags "-O3" "-O2"
	fi
}

src_configure() {
	export ECFLAGS="${CFLAGS}" ECXXFLAGS="${CXXFLAGS}" ELDFLAGS="${LDFLAGS}"
	# set ./configure options (prefix, Qt based wizard, docdir)

	local my_conf=""
	use debug && my_conf="--debug"

	export CC="${QMAKE_CC}"
	export CXX="${QMAKE_CXX}"
	export LINK="${QMAKE_LINK}"
	export LINK_SHLIB="${QMAKE_CXX}"

	if use qt4; then
		export QTDIR="${EPREFIX}/usr"
		einfo "using QTDIR: '$QTDIR'."
		export LIBRARY_PATH="${QTDIR}/$(get_libdir)${LIBRARY_PATH:+:}${LIBRARY_PATH}"
		export LD_LIBRARY_PATH="${QTDIR}/$(get_libdir)${LD_LIBRARY_PATH:+:}${LD_LIBRARY_PATH}"
		einfo "using QT LIBRARY_PATH: '$LIBRARY_PATH'."
		einfo "using QT LD_LIBRARY_PATH: '$LD_LIBRARY_PATH'."
		./configure --prefix "${EPREFIX}/usr" ${my_conf} $(use_with qt4 doxywizard) \
		|| die 'configure with qt4 failed'
	else
		./configure --prefix "${EPREFIX}/usr" ${my_conf} || die 'configure failed'
	fi
}

src_compile() {
	emake all || die 'emake failed'

	# generate html and pdf (if tetex in use) documents.
	# errors here are not considered fatal, hence the ewarn message
	# TeX's font caching in /var/cache/fonts causes sandbox warnings,
	# so we allow it.
	if use doc; then
		if use nodot; then
			sed -i -e "s/HAVE_DOT               = YES/HAVE_DOT    = NO/" \
				{Doxyfile,doc/Doxyfile} \
				|| ewarn "disabling dot failed"
		fi
		if use latex; then
			addwrite /var/cache/fonts
			addwrite /var/cache/fontconfig
			addwrite /usr/share/texmf/fonts/pk
			addwrite /usr/share/texmf/ls-R
			make pdf || ewarn '"make pdf docs" failed.'
		else
			cp doc/Doxyfile doc/Doxyfile.orig
			cp doc/Makefile doc/Makefile.orig
			sed -i.orig -e "s/GENERATE_LATEX    = YES/GENERATE_LATEX    = NO/" \
				doc/Doxyfile
			sed -i.orig -e "s/@epstopdf/# @epstopdf/" \
				-e "s/@cp Makefile.latex/# @cp Makefile.latex/" \
				-e "s/@sed/# @sed/" doc/Makefile
			make docs || ewarn '"make html docs" failed.'
		fi
	fi
}

src_install() {
	make DESTDIR="${D}" MAN1DIR=share/man/man1 \
		install || die '"make install" failed.'

	if use qt4; then
		doicon "${FILESDIR}/doxywizard.png"
		make_desktop_entry doxywizard "DoxyWizard ${PV}" \
			"doxywizard.png" "Application;Development"
	fi

	dodoc INSTALL LANGUAGE.HOWTO README

	# pdf and html manuals
	if use doc; then
		dohtml -r html/*
		if use latex; then
			insinto /usr/share/doc/"${PF}"
			doins latex/doxygen_manual.pdf
		fi
	fi
}

pkg_postinst() {
	fdo-mime_desktop_database_update

	elog
	elog "The USE flags qt4, doc, and latex will enable doxywizard, or"
	elog "the html and pdf documentation, respectively.  For examples"
	elog "and other goodies, see the source tarball.  For some example"
	elog "output, run doxygen on the doxygen source using the Doxyfile"
	elog "provided in the top-level source dir."
	elog
	elog "Enabling the nodot USE flag will remove the GraphViz dependency,"
	elog "along with Doxygen's ability to generate diagrams in the docs."
	elog "See the Doxygen homepage for additional helper tools to parse"
	elog "more languages."
	elog
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
