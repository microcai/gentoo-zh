# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info unpacker

DESCRIPTION="LoongArch old-world ABI compatibility layer from AOSC OS"
HOMEPAGE="https://github.com/shankerwangmiao/liblol"
SRC_URI="https://mirrors.tuna.tsinghua.edu.cn/anthon/debs/pool/frontier/main/libl/liblol_${PV}-0_loongarch64.deb"

# rely on the AOSC mirror for now
RESTRICT="strip mirror"
QA_PREBUILT="*"

# liblol itself is licensed under GPL-2 according to the AOSC maintainers.
# XXX: The bundled Loongnix libraries are way too many to manually ensure no
# inclusion of non-free code, so a precautionary marker of Loongnix is placed.
# TODO: automate license discovery from the deb package
LICENSE="GPL-2 Loongnix-Base-EULA"
SLOT="0"
KEYWORDS="-* ~loong"

IUSE="split-usr"

PDEPEND="app-emulation/la-ow-syscall"

S="${WORKDIR}"

pkg_pretend() {
	if ! use kernel_linux; then
		return
	fi

	if ! linux_config_exists; then
		ewarn "Unable to check your kernel for ISA extensions support"
		ewarn "Most old-world programs require LSX and LASX to work, and"
		ewarn "LBT is required for LATX. Please ensure this is the case"
		ewarn "with your kernel before trying old-world programs."
		return
	fi

	CONFIG_CHECK="~CPU_HAS_LASX ~CPU_HAS_LBT"
	ERROR_CPU_HAS_LASX="You must enable LSX and LASX support"
	ERROR_CPU_HAS_LASX+=" (CONFIG_CPU_HAS_{LSX,LASX}) in your kernel for most"
	ERROR_CPU_HAS_LASX+=" old-world programs to work."
	ERROR_CPU_HAS_LBT="You must enable LBT support (CONFIG_CPU_HAS_LBT) in"
	ERROR_CPU_HAS_LBT+=" your kernel if you plan to use LATX."

	check_extra_config
}

src_install() {
	cp -r "${S}"/opt "${D}" || die

	insinto /usr/share/liblol
	doins "${FILESDIR}"/*.in

	# The modules-load.d config file is owned and installed by
	# app-emulation/la-ow-syscall, so we no longer install it here.

	# Install the liblol dynamic loader at the well-known path.
	if use split-usr; then
		dosym ../opt/lol/lib/loongarch64-aosc-linux-gnuow/ld.so.1 /lib64/ld.so.1
	else
		# /lib64 is a symlink to /usr/lib64, install into the actual directory
		dosym ../../opt/lol/lib/loongarch64-aosc-linux-gnuow/ld.so.1 /usr/lib64/ld.so.1
	fi
}

_render_cache_file() {
	local lol_libdir="/opt/lol/lib/loongarch64-aosc-linux-gnuow"
	sed -e "s#@libdir@#${EROOT}${lol_libdir}#g" \
		"${D}"/usr/share/liblol/"$1" > "${D}${lol_libdir}/$2"
}

_populate_caches() {
	ebegin "Populating gdk-pixbuf loader cache for liblol"
	_render_cache_file gdk-pixbuf-query-loaders.cache.in \
		gdk-pixbuf-2.0/2.10.0/loaders.cache || die
	eend $?

	ebegin "Populating gtk2 input method module cache for liblol"
	_render_cache_file gtk2-immodules.cache.in \
		gtk-2.0/2.10.0/immodules.cache || die
	eend $?

	ebegin "Populating gtk3 input method module cache for liblol"
	_render_cache_file gtk3-immodules.cache.in \
		gtk-3.0/3.0.0/immodules.cache || die
	eend $?

	ebegin "Populating GIO modules cache for liblol"
	_render_cache_file giomodule.cache.in \
		gio/modules/giomodule.cache || die
	eend $?
}

pkg_preinst() {
	_populate_caches
}

pkg_prerm() {
	local lol_libdir="${EROOT}/opt/lol/lib/loongarch64-aosc-linux-gnuow"
	rm "${lol_libdir}/gdk-pixbuf-2.0/2.10.0/loaders.cache"
	rm "${lol_libdir}/gtk-2.0/2.10.0/immodules.cache"
	rm "${lol_libdir}/gtk-3.0/3.0.0/immodules.cache"
	rm "${lol_libdir}/gio/modules/giomodule.cache"
}
