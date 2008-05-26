# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt/qt-3.3.8-r3.ebuild,v 1.6 2007/08/05 14:42:59 armin76 Exp $

# *** Please remember to update qt3.eclass when revbumping this ***

inherit eutils flag-o-matic toolchain-funcs

SRCTYPE="free"
DESCRIPTION="The Qt toolkit is a comprehensive C++ application development framework."
HOMEPAGE="http://www.trolltech.com/"

IMMQT_P="qt-x11-immodule-unified-qt3.3.8-20070321-gentoo"

SRC_URI="ftp://ftp.trolltech.com/qt/source/qt-x11-${SRCTYPE}-${PV}.tar.gz
	immqt? ( mirror://gentoo/${IMMQT_P}.diff.bz2 )
	immqt-bc? ( mirror://gentoo/${IMMQT_P}.diff.bz2 )"
LICENSE="|| ( QPL-1.0 GPL-2 )"

SLOT="3"
KEYWORDS="alpha ~amd64 ~hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="cups debug doc examples firebird gif ipv6 mysql nas nis odbc opengl postgres sqlite xinerama immqt immqt-bc zh_TW"

DEPEND="x11-libs/libXcursor
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libSM
	x11-proto/inputproto
	x11-proto/xextproto
	xinerama? ( x11-proto/xineramaproto x11-libs/libXinerama )
	virtual/xft
	media-libs/libpng
	media-libs/jpeg
	>=media-libs/libmng-1.0.9
	>=media-libs/freetype-2
	sys-libs/zlib
	nas? ( >=media-libs/nas-1.5 )
	mysql? ( virtual/mysql )
	firebird? ( dev-db/firebird )
	opengl? ( virtual/opengl virtual/glu )
	postgres? ( dev-db/libpq )
	cups? ( net-print/cups )"
PDEPEND="odbc? ( ~dev-db/qt-unixODBC-$PV )"

S=${WORKDIR}/qt-x11-${SRCTYPE}-${PV}

QTBASE=/usr/qt/3

pkg_setup() {
	if use immqt && use immqt-bc ; then
		ewarn
		ewarn "immqt and immqt-bc are exclusive. You cannot set both."
		ewarn "Please specify either immqt or immqt-bc."
		ewarn
		die
	elif use immqt ; then
		ewarn
		ewarn "You are going to compile binary imcompatible immodule for Qt. This means"
		ewarn "you have to recompile everything depending on Qt after you install it."
		ewarn "Be aware."
		ewarn
	fi

	export QTDIR=${S}

	CXX=$(tc-getCXX)
	if [[ ${CXX/g++/} != ${CXX} ]]; then
		PLATCXX="g++"
	elif [[ ${CXX/icpc/} != ${CXX} ]]; then
		PLATCXX="icc"
	else
		die "Unknown compiler ${CXX}."
	fi

	case ${CHOST} in
		*-freebsd*|*-dragonfly*)
			PLATNAME="freebsd" ;;
		*-openbsd*)
			PLATNAME="openbsd" ;;
		*-netbsd*)
			PLATNAME="netbsd" ;;
		*-darwin*)
			PLATNAME="darwin" ;;
		*-linux-*|*-linux)
			PLATNAME="linux" ;;
		*)
			die "Unknown CHOST, no platform choosed."
	esac

	# probably this should be '*-64' for 64bit archs
	# in a fully multilib environment (no compatibility symlinks)
	export PLATFORM="${PLATNAME}-${PLATCXX}"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i -e 's:read acceptance:acceptance=yes:' configure

	# Do not link with -rpath. See bug #75181.
	find ${S}/mkspecs -name qmake.conf | xargs \
		sed -i -e 's:QMAKE_RPATH.*:QMAKE_RPATH =:'

	# Patch for uic includehint errors (aseigo patch)
	epatch ${FILESDIR}/${P}-uic-fix.patch

	# Patch for mysql unload crash (Bug #171883)
	epatch ${FILESDIR}/${P}-mysql-unload-crash.diff

	# KDE related patches
	epatch ${FILESDIR}/0001-dnd_optimization.patch
	epatch ${FILESDIR}/0002-dnd_active_window_fix.patch
	epatch ${FILESDIR}/0038-dragobject-dont-prefer-unknown.patch
	epatch ${FILESDIR}/0044-qscrollview-windowactivate-fix.diff
	epatch ${FILESDIR}/0047-fix-kmenu-widget.diff
	epatch ${FILESDIR}/0048-qclipboard_hack_80072.patch

	# possible rce, CVE-2007-3388
	epatch ${FILESDIR}/0081-format-string-fixes.diff

	# ulibc patch (bug #100246)
	epatch ${FILESDIR}/qt-ulibc.patch

	# xinerama patch: http://ktown.kde.org/~seli/xinerama/
	epatch "${FILESDIR}/${P}-seli-xinerama.patch"

	epatch ${FILESDIR}/utf8-bug-qt3.diff

	# Visibility patch, apply only on GCC 4.1 and later for safety
	# [[ $(gcc-major-version)$(gcc-minor-version) -ge 41 ]] && \
		epatch "${FILESDIR}/${P}-visibility.patch"

	if use immqt || use immqt-bc ; then
		epatch ../${IMMQT_P}.diff
		sh make-symlinks.sh || die "make symlinks failed"
	fi

	if use ppc-macos ; then
		epatch "${FILESDIR}/${PN}-3.3.5-macos.patch"
	fi
	
	if use zh_TW
	then
		# add by scsi
		# :http://www.linux-ren.org/modules/everestblog/?p=7
		epatch ${FILESDIR}/qt-add-bold-style-for-missing-font.patch.gz
		#http://deepstyle.org.ua/downloads/deepstyle-2.0/source/kde/qt/
		epatch ${FILESDIR}/qt-font-default-subst.diff.gz
	fi
	# known working flags wrt #77623
	use sparc && export CFLAGS="-O1" && export CXXFLAGS="${CFLAGS}"
	# set c/xxflags and ldflags
	strip-flags
	append-flags -fno-strict-aliasing
	sed -i -e "s:QMAKE_CFLAGS_RELEASE.*=.*:QMAKE_CFLAGS_RELEASE=${CFLAGS}:" \
	       -e "s:QMAKE_CXXFLAGS_RELEASE.*=.*:QMAKE_CXXFLAGS_RELEASE=${CXXFLAGS}:" \
	       -e "s:QMAKE_LFLAGS_RELEASE.*=.*:QMAKE_LFLAGS_RELEASE=${LDFLAGS}:" \
		   -e "s:\<QMAKE_CC\>.*=.*:QMAKE_CC=$(tc-getCC):" \
		   -e "s:\<QMAKE_CXX\>.*=.*:QMAKE_CXX=$(tc-getCXX):" \
		   -e "s:\<QMAKE_LINK\>.*=.*:QMAKE_LINK=$(tc-getCXX):" \
		   -e "s:\<QMAKE_LINK_SHLIB\>.*=.*:QMAKE_LINK_SHLIB=$(tc-getCXX):" \
		${S}/mkspecs/${PLATFORM}/qmake.conf || die

	if [ $(get_libdir) != "lib" ] ; then
		sed -i -e "s:/lib$:/$(get_libdir):" \
			${S}/mkspecs/${PLATFORM}/qmake.conf || die
	fi
}

src_compile() {
	export SYSCONF=${D}${QTBASE}/etc/settings

	# Let's just allow writing to these directories during Qt emerge
	# as it makes Qt much happier.
	addwrite "${QTBASE}/etc/settings"
	addwrite "${HOME}/.qt"

	[ $(get_libdir) != "lib" ] && myconf="${myconf} -L/usr/$(get_libdir)"

	# unixODBC support is now a PDEPEND on dev-db/qt-unixODBC; see bug 14178.
	use nas		&& myconf="${myconf} -system-nas-sound"
	use nis		&& myconf="${myconf} -nis" || myconf="${myconf} -no-nis"
	use gif		&& myconf="${myconf} -qt-gif" || myconf="${myconf} -no-gif"
	use mysql	&& myconf="${myconf} -plugin-sql-mysql -I/usr/include/mysql -L/usr/$(get_libdir)/mysql" || myconf="${myconf} -no-sql-mysql"
	use postgres	&& myconf="${myconf} -plugin-sql-psql -I/usr/include/postgresql/server -I/usr/include/postgresql/pgsql -I/usr/include/postgresql/pgsql/server" || myconf="${myconf} -no-sql-psql"
	use firebird    && myconf="${myconf} -plugin-sql-ibase -I/opt/firebird/include" || myconf="${myconf} -no-sql-ibase"
	use sqlite	&& myconf="${myconf} -plugin-sql-sqlite" || myconf="${myconf} -no-sql-sqlite"
	use cups	&& myconf="${myconf} -cups" || myconf="${myconf} -no-cups"
	use opengl	&& myconf="${myconf} -enable-module=opengl" || myconf="${myconf} -disable-opengl"
	use debug	&& myconf="${myconf} -debug" || myconf="${myconf} -release -no-g++-exceptions"
	use xinerama    && myconf="${myconf} -xinerama" || myconf="${myconf} -no-xinerama"

	myconf="${myconf} -system-zlib"

	use ipv6        && myconf="${myconf} -ipv6" || myconf="${myconf} -no-ipv6"
	use immqt-bc	&& myconf="${myconf} -inputmethod"
	use immqt	&& myconf="${myconf} -inputmethod -inputmethod-ext"

	if use ppc-macos ; then
		myconf="${myconf} -no-sql-ibase -no-sql-mysql -no-sql-psql -no-cups -lresolv -shared"
		myconf="${myconf} -I/usr/X11R6/include -L/usr/X11R6/lib"
		myconf="${myconf} -L${S}/lib -I${S}/include"
		sed -i -e "s,#define QT_AOUT_UNDERSCORE,," mkspecs/${PLATFORM}/qplatformdefs.h || die
	fi

	export YACC='byacc -d'
	tc-export CC CXX
	export LINK="$(tc-getCXX)"

	./configure -sm -thread -stl -system-libjpeg -verbose -largefile \
		-qt-imgfmt-{jpeg,mng,png} -tablet -system-libmng \
		-system-libpng -xft -platform ${PLATFORM} -xplatform \
		${PLATFORM} -xrender -prefix ${QTBASE} -libdir ${QTBASE}/$(get_libdir) \
		-fast -no-sql-odbc ${myconf} -dlopen-opengl || die

	emake src-qmake src-moc sub-src || die

	export DYLD_LIBRARY_PATH="${S}/lib:/usr/X11R6/lib:${DYLD_LIBRARY_PATH}"
	export LD_LIBRARY_PATH="${S}/lib:${LD_LIBRARY_PATH}"

	emake sub-tools || die

	if use examples; then
		emake sub-tutorial sub-examples || die
	fi

	# Make the msg2qm utility (not made by default)
	cd ${S}/tools/msg2qm
	../../bin/qmake
	emake

	# Make the qembed utility (not made by default)
	cd ${S}/tools/qembed
	../../bin/qmake
	emake

}

src_install() {
	# binaries
	into ${QTBASE}
	dobin bin/*
	dobin tools/msg2qm/msg2qm
	dobin tools/qembed/qembed

	# libraries
	if use ppc-macos; then
		# dolib is broken on BSD because of missing readlink(1)
		dodir ${QTBASE}/$(get_libdir)
		cp -fR lib/*.{dylib,la,a} ${D}/${QTBASE}/$(get_libdir) || die

		cd ${D}/${QTBASE}/$(get_libdir)
		for lib in libqt-mt* ; do
			ln -s ${lib} ${lib/-mt/}
		done
	else
		dolib.so lib/lib{editor,qassistantclient,designercore}.a
		dolib.so lib/libqt-mt.la
		dolib.so lib/libqt-mt.so.${PV} lib/libqui.so.1.0.0
		cd ${D}/${QTBASE}/$(get_libdir)

		for x in libqui.so ; do
			ln -s $x.1.0.0 $x.1.0
			ln -s $x.1.0 $x.1
			ln -s $x.1 $x
		done

		# version symlinks - 3.3.5->3.3->3->.so
		ln -s libqt-mt.so.${PV} libqt-mt.so.3.3
		ln -s libqt-mt.so.3.3 libqt-mt.so.3
		ln -s libqt-mt.so.3 libqt-mt.so

		# libqt -> libqt-mt symlinks
		ln -s libqt-mt.so.${PV} libqt.so.${PV}
		ln -s libqt-mt.so.3.3 libqt.so.3.3
		ln -s libqt-mt.so.3 libqt.so.3
		ln -s libqt-mt.so libqt.so
	fi

	# plugins
	cd ${S}
	local plugins=$(find plugins -name "lib*.so" -print)
	for x in ${plugins}; do
		exeinto ${QTBASE}/$(dirname ${x})
		doexe ${x}
	done

	# Past this point just needs to be done once
	is_final_abi || return 0

	# includes
	cd ${S}
	dodir ${QTBASE}/include/private
	cp include/* ${D}/${QTBASE}/include/
	cp include/private/* ${D}/${QTBASE}/include/private/

	# prl files
	sed -i -e "s:${S}:${QTBASE}:g" ${S}/lib/*.prl
	insinto ${QTBASE}/$(get_libdir)
	doins ${S}/lib/*.prl

	# pkg-config file
	insinto ${QTBASE}/$(get_libdir)/pkgconfig
	doins ${S}/lib/*.pc

	# List all the multilib libdirs
	local libdirs
	for libdir in $(get_all_libdirs); do
		libdirs="${libdirs}:${QTBASE}/${libdir}"
	done

	# environment variables
	if use ppc-macos; then
		cat <<EOF > ${T}/45qt3
PATH=${QTBASE}/bin
ROOTPATH=${QTBASE}/bin
DYLD_LIBRARY_PATH=${libdirs:1}
QMAKESPEC=${PLATFORM}
MANPATH=${QTBASE}/doc/man
PKG_CONFIG_PATH=${QTBASE}/$(get_libdir)/pkgconfig
EOF
	else
		cat <<EOF > ${T}/45qt3
PATH=${QTBASE}/bin
ROOTPATH=${QTBASE}/bin
LDPATH=${libdirs:1}
QMAKESPEC=${PLATFORM}
MANPATH=${QTBASE}/doc/man
PKG_CONFIG_PATH=${QTBASE}/$(get_libdir)/pkgconfig
EOF
	fi
	cat <<EOF > ${T}/50qtdir3
QTDIR=${QTBASE}
EOF

	cat <<EOF > ${T}/50-qt3-revdep
SEARCH_DIRS="${QTBASE}"
EOF

	insinto /etc/revdep-rebuild
	doins ${T}/50-qt3-revdep

	doenvd ${T}/45qt3 ${T}/50qtdir3

	if [ "${SYMLINK_LIB}" = "yes" ]; then
		dosym $(get_abi_LIBDIR ${DEFAULT_ABI}) ${QTBASE}/lib
	fi

	insinto ${QTBASE}/tools/designer
	doins -r tools/designer/templates

	insinto ${QTBASE}
	doins -r translations

	keepdir ${QTBASE}/etc/settings

	if use doc; then
		insinto ${QTBASE}
		doins -r ${S}/doc
	fi

	if use examples; then
		find ${S}/examples ${S}/tutorial -name Makefile | \
			xargs sed -i -e "s:${S}:${QTBASE}:g"

		cp -r ${S}/examples ${D}${QTBASE}/
		cp -r ${S}/tutorial ${D}${QTBASE}/
	fi

	# misc build reqs
	insinto ${QTBASE}/mkspecs
	doins -r ${S}/mkspecs/${PLATFORM}

	sed -e "s:${S}:${QTBASE}:g" \
		${S}/.qmake.cache > ${D}${QTBASE}/.qmake.cache

	dodoc FAQ README README-QT.TXT changes*
	if use immqt || use immqt-bc ; then
		dodoc ${S}/README.immodule
	fi
}

pkg_postinst() {
	echo
	elog "After a rebuild of Qt, it can happen that Qt plugins (such as Qt/KDE styles,"
	elog "or widgets for the Qt designer) are no longer recognized.  If this situation"
	elog "occurs you should recompile the packages providing these plugins,"
	elog "and you should also make sure that Qt and its plugins were compiled with the"
	elog "same version of gcc.  Packages that may need to be rebuilt are, for instance,"
	elog "kde-base/kdelibs, kde-base/kdeartwork and kde-base/kdeartwork-styles."
	elog "See http://doc.trolltech.com/3.3/plugins-howto.html for more infos."
	echo
}
