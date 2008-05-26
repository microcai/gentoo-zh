# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/app-office/openoffice/openoffice-2.0.0.ebuild,v 1.4 2005/12/05 16:12:25 scsi Exp $

inherit eutils fdo-mime flag-o-matic kde-functions toolchain-funcs

IUSE="curl eds gnome gtk java kde ldap mozilla nas zlib xml2 zh_TW"

MY_PV="${PV}.1"
PATCHLEVEL="OOO680"
PATCHDIR="${WORKDIR}/ooo-build-${MY_PV}"
SRC="OOO_2_0_0"
S="${WORKDIR}/${SRC}"
CONFFILE="${PATCHDIR}/distro-configs/Gentoo.conf.in"
DESCRIPTION="OpenOffice.org, a full office productivity suite."

SRC_URI="http://go-oo.org/packages/${PATCHLEVEL}/${SRC}-core.tar.bz2
	http://go-oo.org/packages/${PATCHLEVEL}/${SRC}-system.tar.bz2
	http://go-oo.org/packages/${PATCHLEVEL}/${SRC}-lang.tar.bz2
	http://go-oo.org/packages/${PATCHLEVEL}/ooo-build-${MY_PV}.tar.gz
	http://go-ooo.org/packages/libwpd/libwpd-0.8.3.tar.gz
	kde? ( http://go-oo.org/packages/SRC680/ooo_crystal_images-6.tar.bz2 )
	http://go-oo.org/packages/SRC680/extras-2.tar.bz2"

HOMEPAGE="http://go-oo.org"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"

RDEPEND="!app-office/openoffice-bin
	!app-office/openoffice-ximian-bin
	!app-office/openoffice-ximian
	virtual/x11
	virtual/libc
	>=dev-lang/perl-5.0
	gnome? ( >=x11-libs/gtk+-2.4
		>=gnome-base/gnome-vfs-2.6
		>=gnome-base/gconf-2.0 )
	gtk? ( >=x11-libs/gtk+-2.4 )
	eds? ( >=gnome-extra/evolution-data-server-1.2 )
	kde? ( kde-base/kdelibs )
	mozilla? ( >=www-client/mozilla-1.7.10 )
	>=x11-libs/startup-notification-0.5
	>=media-libs/freetype-2.1.4
	>=media-libs/fontconfig-2.2.0
	media-libs/libpng
	sys-devel/flex
	sys-devel/bison
	app-arch/zip
	app-arch/unzip
	dev-libs/expat
	java? ( =virtual/jre-1.4* )
	>=sys-devel/gcc-3.2.1
	linguas_ja? ( >=media-fonts/kochi-substitute-20030809-r3 )
	linguas_zh_CN? ( >=media-fonts/arphicfonts-0.1-r2 )
	linguas_zh_TW? ( >=media-fonts/arphicfonts-0.1-r2 )"

DEPEND="${RDEPEND}
	net-print/cups
	>=sys-apps/findutils-4.1.20-r1
	app-shells/tcsh
	dev-perl/Archive-Zip
	dev-util/pkgconfig
	dev-util/intltool
	curl? ( >=net-misc/curl-7.9.8 )
	nas? ( >=media-libs/nas-1.6 )
	zlib? ( sys-libs/zlib )
	sys-libs/pam
	!dev-util/dmake
	>=dev-lang/python-2.3.4
	java? ( =virtual/jdk-1.4*
		dev-java/ant-core
		>=dev-java/java-config-1.2.11-r1 )
	!java? ( dev-libs/libxslt
		>=dev-libs/libxml2-2.0 )
	ldap? ( net-nds/openldap )
	xml2? ( >=dev-libs/libxml2-2.0 )"

PROVIDE="virtual/ooo"

pkg_setup() {

	ewarn
	ewarn " It is important to note that OpenOffice.org is a very fragile  "
	ewarn " build when it comes to CFLAGS.  A number of flags have already "
	ewarn " been filtered out.  If you experience difficulty merging this  "
	ewarn " package and use agressive CFLAGS, lower the CFLAGS and try to  "
	ewarn " merge again. Also note that building OOo takes a lot of time and "
	ewarn " hardware ressources: 4-6 GB free diskspace and 256 MB RAM are "
	ewarn " the minimum requirements. If you have less, use openoffice-bin "
	ewarn " instead. "
	ewarn

	strip-linguas af ar be_BY bg bn br ca cs cy da de el en en_GB en_US es et fi fr ga gu_IN he hi_IN hr hu it ja km ko lt nb ne nl nn ns pa_IN pl pt pt_BR ru sh_YU sk sl sr_CS sv th tn tr vi xh zh_CN zh_TW zu

	if [ -z "${LINGUAS}" ]; then
		export LINGUAS_OOO="en-US"
		ewarn " To get a localized build, set the according LINGUAS variable(s). "
		ewarn
	else
		export LINGUAS_OOO="${LINGUAS//en/en_US}"
		export LINGUAS_OOO="${LINGUAS_OOO//en_US_GB/en_GB}"
		export LINGUAS_OOO="${LINGUAS_OOO//en_US_US/en_US}"
		export LINGUAS_OOO="${LINGUAS_OOO//_/-}"
	fi

	if use !java; then
		ewarn " You are building with java-support disabled, this results in some "
		ewarn " of the OpenOffice.org functionality (i.e. help) being disabled. "
		ewarn " If something you need does not work for you, rebuild with "
		ewarn " java in your USE-flags. Also the xml2 use-flag is disabled with "
		ewarn " -java to prevent build breakage. "
		ewarn
	fi

}

src_unpack() {

	cd ${WORKDIR}
	unpack ooo-build-${MY_PV}.tar.gz

	if use zh_TW
	then
		FIREFLYPATCHFILES="openoffice-1.1.1b-freetype-20040228.diff
							openoffice-1.9.m100-usemyfreetype-20050505.diff
							openoffice-1.9.m130-fontmanager-fixfontconfig-20050919.diff
							openoffice-1.9.m130-officecfg-disableregister-20050919.diff
							openoffice-1.9.m130-psprint-recursive_scandir-20050919.diff
							openoffice-1.9.m130-svtools-nonenglishnamefirst-20050919.diff
							openoffice-1.9.m130-svx-vendor-ossii-20050919.diff
							openoffice-1.9.m130-vcl-disablexlfd-20050919.diff
							openoffice-1.9.m130-vcl-prefer-overthespot-20050919.diff
							openoffice-1.9.m130-vcl-prefersearch-20050919.diff
							openoffice-1.9.m130-vcl-setdefaultfontsize-20050919.diff
							openoffice-1.9.m130-vcl-setinterfacefontsize-20050919.diff
							openoffice-1.9.m130-vcl-setscreendpi-20050919.diff
							openoffice-1.9.m130-vcl-virtualstyles-20050919.diff
							openoffice-2.0.0-desktop-userinstall-20051029.diff
							openoffice-2.0.0rc1-desktop-soffice-20051007.diff
							openoffice-2.0.0rc1-officecfg-ChineseFont-20051006.diff
							openoffice-2.0.0rc1-psprint-usefreetype-20051002.diff
							openoffice-2.0.0rc2-helpcontent2-ChineseFont-20051013.diff"
		
		einfo
		einfo "add firefly patchs...."
		for pfile in $FIREFLYPATCHFILES
		do
			einfo "adding $pfile"
			cp -pPRf ${FILESDIR}/${PV}/firefly/$pfile ${PATCHDIR}/patches/src680
			echo $pfile  >> ${PATCHDIR}/patches/OOO_2_0/apply
		done
		einfo
	fi

	#Some fixes for our patchset
	cd ${PATCHDIR}
	epatch ${FILESDIR}/${PV}/gentoo-${PV}.diff

	#Additional and new patches get here
	cp -pPRf ${FILESDIR}/${PV}/nojava-fix-stringparam.diff ${PATCHDIR}/patches/src680 || die
	cp -pPRf ${FILESDIR}/${PV}/buildfix-new-xslt.diff ${PATCHDIR}/patches/src680 || die

	#Detect which look and patchset we are using, amd64 is known not to be working atm, so this is here for testing purposes only
	use amd64 && export DISTRO="Gentoo64" || export DISTRO="Gentoo"

	#Use flag checks
	use java && echo "--with-jdk-home=${JAVA_HOME} --with-ant-home=${ANT_HOME}" >> ${CONFFILE} || echo "--without-java" >> ${CONFFILE}

	echo "`use_with curl system-curl`" >> ${CONFFILE}
	echo "`use_with nas system-nas`" >> ${CONFFILE}
	echo "`use_with xml2 system-libxml`" >> ${CONFFILE}
	echo "`use_with zlib system-zlib`" >> ${CONFFILE}

	echo "`use_with mozilla system-mozilla`" >> ${CONFFILE}
	echo "`use_enable mozilla`" >> ${CONFFILE}

	echo "`use_enable ldap openldap`" >> ${CONFFILE}
	echo "`use_enable eds evolution2`" >> ${CONFFILE}
	echo "`use_enable gnome gnome-vfs`" >> ${CONFFILE}
	echo "`use_enable gnome lockdown`" >> ${CONFFILE}

}

src_compile() {

	unset LIBC
	addpredict "/bin"
	addpredict "/root/.gconfd"
	addpredict "/root/.gnome"

	# Should the build use multiprocessing? Not enabled by default, as it tends to break 
	if [ "${WANT_DISTCC}" == "true" ]; then
		export JOBS=`echo "${MAKEOPTS}" | sed -e "s/.*-j\([0-9]\+\).*/\1/"`
	fi

	# Make sure gnome-users get gtk-support
	export GTKFLAG="`use_enable gtk`" && use gnome && GTKFLAG="--enable-gtk"

	cd ${PATCHDIR}
	autoconf || die
	./configure ${MYCONF} \
		--with-distro="${DISTRO}" \
		--with-vendor="Gentoo" \
		--with-arch="${ARCH}" \
		--with-srcdir="${DISTDIR}" \
		--with-lang="${LINGUAS_OOO}" \
		--with-num-cpus="${JOBS}" \
		--with-binsuffix="2" \
		--with-installed-ooo-dirname="openoffice" \
		"${GTKFLAG}" \
		`use_enable kde` \
		--disable-access \
		--disable-mono \
		--disable-cairo \
		--disable-post-install-scripts \
		--mandir=/usr/share/man \
		|| die "Configuration failed!"

	# Compile problems with these ...
	filter-flags "-funroll-loops"
	filter-flags "-fomit-frame-pointer"
	filter-flags "-fprefetch-loop-arrays"
	filter-flags "-fno-default-inline"
	filter-flags "-fstack-protector"
	filter-flags "-ftracer"
	replace-flags "-O3" "-O2"
	replace-flags "-Os" "-O2"

	# Now for our optimization flags ...
	export ARCH_FLAGS="${CFLAGS}"

	einfo "Building OpenOffice.org..."
	use kde && set-kdedir 3
	make || die "Build failed"

}

src_install() {

	einfo "Preparing Installation"
	cd ${PATCHDIR}
	make DESTDIR=${D} install || die "Installation failed!"

	# Install corrected Symbol Font
	insinto /usr/share/fonts/TTF/
	doins ${PATCHDIR}/fonts/*.ttf

}

pkg_postinst() {

	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update

	einfo " To start OpenOffice.org, run:"
	einfo
	einfo " $ ooffice2"
	einfo
	einfo " Also, for individual components, you can use any of:"
	einfo
	einfo " oobase2, oocalc2, oodraw2, oofromtemplate2, ooimpress2, oomath2,"
	einfo " ooweb2 or oowriter2"
}
