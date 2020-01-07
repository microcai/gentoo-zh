# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Changelog since last bugzilla upload 
# 
# initial version 
# updated to use cnijfilter-common-2.80 2008-01-12 by Victor Mataré 
# 
# 2010-03-19 GuS Version 3.20-r1 
#        Replaced dependency of non-existing dev-libs/libxml with 
#            dependency of >=dev-libs/libxml2-2.7.3-r2. 
# 
# 2010-03-20 GuS Version 3.20-r2 
#            Replaced dependency of non-existing virtual/ghostscript with 
#        dependency of app-text/ghostscript-gpl. 
EAPI=7

inherit eutils flag-o-matic autotools multilib 

DESCRIPTION="Canon InkJet Scanner Driver and ScanGear MP for Linux (Pixus/Pixma-Series)." 
HOMEPAGE="http://support-au.canon.com.au/contents/AU/EN/0100303302.html" 
RESTRICT="nomirror confcache" 

SRC_URI="http://gdlp01.c-wss.com/gds/3/0100003033/01/scangearmp-source-1.60-1.tar.gz" 
LICENSE="UNKNOWN" # GPL-2 source and proprietary binaries 

SLOT="2" 
KEYWORDS="~x86 ~amd64" 
IUSE="amd64 
    usb 
    mp250 
    mp280 
    mp495 
    mg5100 
    mg5200 
    mg6100 
    mg8100" 
DEPEND=">=dev-libs/libusb-0.1.12-r5 
    >=media-libs/libpng-1.2.44 
    >=media-gfx/gimp-2.6.8 
    >=x11-libs/gtk+-2.20.1-r1 
    >=media-gfx/sane-backends-1.0.19-r2" 

# Arrays of supported Printers, there IDs and compatible models 
_pruse=("mp250" "mp280" "mp495" "mg5100" "mg5200" "mg6100" "mg8100") 
_prname=(${_pruse[@]}) 
_prid=("356" "370" "369" "373" "374" "376" "377") 
_prcomp=("mp250series" "mp280series" "mp495series" "mg5100series" "mg5200series" "mg6100series" "mg8100series") 
_max=$((${#_pruse[@]}-1)) # used for iterating through these arrays 

### 
#   Standard Ebuild-functions 
### 

src_unpack() { 
    unpack ${A} 
    mv ${PN}-source-${PV}-1 ${P} || die # Correcting directory-structure 
} 

pkg_setup() { 
    if [ -z "$LINGUAS" ]; then    # -z tests to see if the argument is empty 
        ewarn "You didn't specify 'LINGUAS' in your make.conf. Assuming" 
        ewarn "English localisation, i.e. 'LINGUAS=\"en\"'." 
        LINGUAS="en" 
    fi 

    _prefix="/usr/local" 
    _bindir="${_prefix}/bin" 
    _libdir="/usr/$(get_libdir)" # either lib or lib32 
    _gimpdir="${_libdir}/gimp/2.0/plug-ins" 
    _udevdir="/etc/udev/rules.d" 

    einfo "" 
    einfo " USE-flags\t(description / probably compatible printers)" 
    einfo "" 
    einfo " amd64\t(basic support for this architecture)" 
    einfo " usb\t(connected using usb)" 
    _autochoose="true" 
    for i in `seq 0 ${_max}`; do 
        einfo " ${_pruse[$i]}\t${_prcomp[$i]}" 
        if (use ${_pruse[$i]}); then 
            _autochoose="false" 
        fi 
    done 
    einfo "" 
    if (${_autochoose}); then 
        ewarn "You didn't specify any driver model (set it's USE-flag)." 
        einfo "" 
        einfo "As example:\tbasic MP140 support without maintenance tools" 
        einfo "\t\t -> USE=\"mp140\"" 
        einfo "" 
        einfo "Press Ctrl+C to abort" 
        echo 
        ebeep 

        n=15 
        while [[ $n -gt 0 ]]; do 
            echo -en "  Waiting $n seconds...\r" 
            sleep 1 
            (( n-- )) 
        done 
    fi
}

src_prepare(){
	cd scangearmp

	sed -i 's/Z_BEST_SPEED/\ 1\ /g' src/scanfile.c


	( cd src && epatch "${FILESDIR}/fixcompile.patch" )

	libtoolize -cfi
	eautoreconf
}

src_configure(){
    cd scangearmp || die 

    if use x86; then 
        LDFLAGS="-L$(pwd)/../com/libs_bin32"
    elif use amd64 ; then
        LDFLAGS="-L$(pwd)/../com/libs_bin64"
    else
		die "not supported arch"
    fi
	 
    econf LDFLAGS="${LDFLAGS}"
} 

src_compile() { 

    cd scangearmp || die 

    make || die "Couldn't make scangearmp" 

    cd .. 
} 

src_install() { 
    mkdir -p ${D}${_bindir} || die 
    mkdir -p ${D}${_libdir}/bjlib || die 
    if use usb; then 
        mkdir -p ${D}${_udevdir} || die 
    fi 

    cd scangearmp || die 
    make DESTDIR=${D} install || die "Couldn't make install scangearmp" 

    cd .. 

    for i in $(seq 0 ${_max}); do 
        if use ${_pruse[$i]} || ${_autochoose}; then 
            _pr=${_prname[$i]} _prid=${_prid[$i]} 
        fi 
    done 

    # rm .1a and .a 
    rm -f {$D}${_libdir}/*.1a {$D}${_libdir}/*.a || die 
    
    # make symbolic link for gimp-plug-in 
    if [ -d "${_gimpdir}" ]; then 
        mkdir -p ${D}${_gimpdir} || die 
        dosym ${_bindir}/scangearmp ${_gimpdir}/scangearmp || die 
    fi 

    if use x86; then 
        cp -a ${_prid}/libs_bin32/* ${D}${_libdir} || die 
        cp -a com/libs_bin32/* ${D}${_libdir} || die 
    else # amd54 
        cp -a ${_prid}/libs_bin64/* ${D}${_libdir} || die 
        cp -a com/libs_bin64/* ${D}${_libdir} || die 
    fi 
    cp -a ${_prid}/*.DAT ${D}${_libdir}/bjlib || die 
    cp -a ${_prid}/*.tbl ${D}${_libdir}/bjlib || die 
    cp com/ini/canon_mfp_net.ini ${D}${_libdir}/bjlib || die 
    chmod 644 ${D}${_libdir}/bjlib/* || die 
    chmod 666 ${D}${_libdir}/bjlib/canon_mfp_net.ini || die 

    # usb 
    if use usb; then 
        cp -a scangearmp/etc/80-canon_mfp.rules ${D}${_udevdir} || die 
        chmod 644 ${D}${_udevdir}/80-canon_mfp.rules || die 
    fi 
} 

pkg_postinst() { 
    if use usb; then 
        if [ -x /sbin/udevadm ]; then 
            einfo "" 
            einfo "Reloading usb rules..." 
            /sbin/udevadm control --reload-rules 2> /dev/null 
            /sbin/udevadm trigger --action=add --subsystem-match=usb 2>/dev/null 
        else 
            einfo "" 
            einfo "Please, reload usb rules manually." 
        fi 
    fi 

    einfo "" 
    einfo "If you experience any problems, please visit:" 
    einfo " http://forums.gentoo.org/viewtopic-p-3217721.html" 
    einfo "" 
} 
