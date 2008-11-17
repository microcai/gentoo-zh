# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/fontconfig/fontconfig-2.6.0-r2.ebuild,v 1.1 2008/06/26 21:38:55 cardoe Exp $

WANT_AUTOMAKE=1.9

EAPI="1"
inherit eutils autotools libtool

DESCRIPTION="A library for configuring and customizing font access"
HOMEPAGE="http://fontconfig.org/"
SRC_URI="http://fontconfig.org/release/${P}.tar.gz"

LICENSE="fontconfig"
SLOT="1.0"
KEYWORDS="alpha amd64 arm hppa ia64 ~m68k ~mips ppc ppc64 ~s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="doc +ubuntu"

# Purposefully dropped the xml USE flag and libxml2 support. Having this is
# silly since expat is the preferred way to go per upstream and libxml2 support
# simply exists as a fallback when expat isn't around. expat support is the main
# way to go and every other distro uses it. By using the xml USE flag to enable
# libxml2 support, this confuses users and results in most people getting the
# non-standard behavior of libxml2 usage since most profiles have USE=xml

RDEPEND="ubuntu? ( >=media-libs/freetype-2.3.6 )
	!ubuntu? ( >=media-libs/freetype-2.1.4 )
	>=dev-libs/expat-1.95.3"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-text/docbook-sgml-utils )"
PDEPEND="app-admin/eselect-fontconfig"

pkg_setup () {
	if use ubuntu && ! built_with_use --missing false media-libs/freetype:2 ubuntu; then
		eerror "You need to compile freetype-2 with the ubuntu USE before you can compile fontconfig with the ubuntu USE flag."
		die "Please rebuild freetype-2 with ubuntu enabled."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	if use ubuntu; then
		epatch "${FILESDIR}"/${PN}-2.6.0-ubuntu.diff
		epatch "${FILESDIR}"/${PN}-monospace-lcd-filtering.patch
		epatch "${FILESDIR}"/${PN}-hinting-and-alising-confs.patch
		epatch "${FILESDIR}"/${PN}-lcddefault.patch
		cp "${FILESDIR}"/30-replace-bitmap-fonts.conf conf.d/
	fi

	epunt_cxx #74077
	epatch "${FILESDIR}"/${P}-parallel.patch
	# Neeeded to get a sane .so versionning on fbsd, please dont drop
	# If you have to run eautoreconf, you can also leave the elibtoolize call as
	# it will be a no-op.
	eautoreconf
}

src_compile() {
	econf $(use_enable doc docs) \
		--localstatedir=/var \
		--with-docdir=/usr/share/doc/${PF} \
		--with-default-fonts=/usr/share/fonts \
		--with-add-fonts=/usr/local/share/fonts \
		|| die

	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	#fc-lang directory contains language coverage datafiles
	#which are needed to test the coverage of fonts.
	insinto /usr/share/fc-lang
	doins fc-lang/*.orth

	insinto /etc/fonts
	doins "${S}"/fonts.conf

	doman $(find "${S}" -type f -name *.1 -print)
	newman doc/fonts-conf.5 fonts.conf.5
	dodoc doc/fontconfig-user.{txt,pdf}

	if use doc; then
		doman doc/Fc*.3
		dohtml doc/fontconfig-devel.html doc
		dodoc doc/fontconfig-devel.{txt,pdf}
	fi

	dodoc AUTHORS ChangeLog README

	# Changes should be made to /etc/fonts/local.conf, and as we had
	# too much problems with broken fonts.conf, we force update it ...
	# <azarah@gentoo.org> (11 Dec 2002)
	echo 'CONFIG_PROTECT_MASK="/etc/fonts/fonts.conf"' > "${T}"/37fontconfig
	doenvd "${T}"/37fontconfig
}

pkg_postinst() {
	echo
	ewarn "Please make fontconfig configuration changes in /etc/fonts/conf.d/"
	ewarn "and NOT to /etc/fonts/fonts.conf, as it will be replaced!"
	echo

	if [[ ${ROOT} = / ]]; then
		ebegin "Creating global font cache..."
		/usr/bin/fc-cache -sr
		eend $?
	fi
}
