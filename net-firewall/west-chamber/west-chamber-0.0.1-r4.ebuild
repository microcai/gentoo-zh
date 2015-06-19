# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Modified from xtables_addon by zhixun.lin@gmail.com
# TODO:
#   change some modules as default

EAPI="2"

inherit eutils linux-mod linux-info

DESCRIPTION="xtables addons that may crash GFW, named after the Romance_of_the_West_Chamber"
HOMEPAGE="http://code.google.com/p/scholarzhang/"
SRC_URI="http://scholarzhang.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"
IUSE="+ipset"

MODULES="gfw zhang cui"

for mod in ${MODULES}; do
	IUSE="${IUSE} xtables_addons_${mod}"
done

RDEPEND="virtual/modutils
	>=net-firewall/iptables-1.4.4
	ipset? ( >=net-firewall/ipset-4.2 )"

DEPEND="${RDEPEND}"

pkg_pretend() {
	if kernel_is le 2 6 22 ; then
		die "Your linux kernel must be newer than 2.6.22"
	fi
}

pkg_setup()	{
	get_version
	check_modules_supported
	# CONFIG_IP_NF_CONNTRACK{,_MARK} doesn't exist in >virtual/linux-sources-2.6.22
	CONFIG_CHECK="NF_CONNTRACK NF_CONNTRACK_MARK NETFILTER_XT_MATCH_STATE IP_NF_FILTER"
	linux-mod_pkg_setup
}

# Helper for maintainer: cheks if all possible MODULES are listed.
XA_qa_check() {
	local all_modules
	all_modules=$(sed -n '/^build_/{s/build_\(.*\)=.*/\L\1/;G;s/\n/ /;s/ $//;h}; ${x;p}' "${S}/mconfig")
	if [[ ${all_modules} != ${MODULES} ]]; then
		ewarn "QA: Modules in mconfig differ from \$MODULES in ebuild."
		ewarn "Please, update MODULES in ebuild."
		ewarn "'${all_modules}'"
	fi
}

# Is there any use flag set? 
XA_has_something_to_build() {
	for mod in ${MODULES}; do
		use xtables_addons_${mod} && return
	done

	eerror "All modules are disabled. What do you want me to build?"
	eerror "Please, set XTABLES_ADDONS to any combination of"
	eerror "${MODULES}"
	die "All modules are disabled."
}

# Parse Kbuid files and generates list of sources
XA_get_module_name() {
	[[ $# != 1 ]] && die "XA_get_sources_for_mod: needs exactly one argument."
	local mod objdir build_mod sources_list
	mod=${1}
	objdir=${S}/extensions
	build_mod=$(sed -n "s/\(build_${mod}\)=.*/\1/Ip" "${S}/mconfig")
	sources_list=$(sed -n "/^obj-[$][{]${build_mod}[}]/\
		{s:obj-[^+]\+ [+]=[[:space:]]*::;s:[.]o::g;p}" \
				"${objdir}/Kbuild")

	if [[ -d ${S}/extensions/${sources_list} ]]; then
		objdir=${S}/extensions/${sources_list}
		sources_list=$(sed -n "/^obj-m/\
			{s:obj-[^+]\+ [+]=[[:space:]]*::;s:[.]o::g;p}" \
				"${objdir}/Kbuild")
	fi
	for mod_src in ${sources_list}; do
		echo " ${mod_src}(xtables_addons:${S}/extensions:${objdir})"
	done
}

src_prepare() {
	sed -e 's/build_ipset=m//' -i mconfig || die
	epatch "${FILESDIR}/facebook.patch"
	epatch "${FILESDIR}/wikipedia.patch"
	XA_qa_check
	XA_has_something_to_build

	MODULE_NAMES="compat_xtables(xtables_addons:${S}/extensions:)"
	for mod in ${MODULES}; do
		if use xtables_addons_${mod}; then
			sed "s/\(build_${mod}=\).*/\1m/I" -i mconfig || die
			for module_name in $(XA_get_module_name ${mod}); do
				MODULE_NAMES+=" ${module_name}"
			done
		else
			sed "s/\(build_${mod}=\).*/\1n/I" -i mconfig || die
		fi
	done

	sed -e 's/depmod -a/true/' -i Makefile.am || die
	sed -e '/^all-local:/{s: modules::}' \
		-e '/^install-exec-local:/{s: modules_install::}' \
			-i extensions/Makefile.am || die
	sed -e 's/$(make -sC ${kbuilddir} kernelrelease)/${KV}/' -i configure.ac
}

src_configure() {
	unset ARCH # .. or it'll look for /arch/amd64/Makefile in linux sources
	./autogen.sh
	econf --prefix=/ \
		--libexecdir=/lib/ \
		--with-kbuild="${KV_DIR}"
}

src_compile() {
	emake CFLAGS="${CFLAGS}" CC="$(tc-getCC)" || die
	BUILD_TARGETS="modules" linux-mod_src_compile
}

src_install() {
	emake DESTDIR="${D}" install || die
	linux-mod_src_install

	dodoc README USAGE INSTALL || die

	insinto /etc/west-chamber
	doins examples/*

	newinitd "${FILESDIR}/${PN}.initd" west-chamber
	newconfd "${FILESDIR}/${PN}.confd" west-chamber

	find "${D}" -type f -name '*.la' -exec rm -rf '{}' '+'
}

pkg_postinst() {
	linux-mod_pkg_postinst
	einfo "This ebuild comes from: http://www.linuxsir.org/bbs/thread364811.html"
	einfo "Thanks to the contributors!"
	einfo "Usage:"
	einfo "    # /etc/init.d/west-chamber start"
}
