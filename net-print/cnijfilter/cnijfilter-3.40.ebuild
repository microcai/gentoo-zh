# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils flag-o-matic multilib

DESCRIPTION="Canon InkJet Printer Driver for Linux (Pixus/Pixma-Series)."
HOMEPAGE="http://support-au.canon.com.au/contents/AU/EN/0100302002.html"
RESTRICT="nomirror confcache"

SRC_URI="http://gdlp01.c-wss.com/gds/0/0100003020/01/cnijfilter-source-3.40-1.tar.gz"
LICENSE="UNKNOWN" # GPL-2 source and proprietary binaries

SLOT="2"
KEYWORDS="~x86 ~amd64"
IUSE="amd64
    servicetools
    nocupsdetection
    mp250
    mp280
    mp495
    mg5100
    ip4800
    mg5200
    mg6100
    mg8100"
DEPEND=">=app-text/ghostscript-gpl-8.71-r6
    >=net-print/cups-1.3.11-r3
    !amd64? ( sys-libs/glibc
        >=dev-libs/popt-1.6
        >=media-libs/tiff-3.9.4
        >=media-libs/libpng-1.4.3 )
    servicetools? ( !amd64? ( >=gnome-base/libglade-2.6.4
            >=dev-libs/libxml2-2.7.7
            >=x11-libs/gtk+-2.20.1-r1 ) )"

# Arrays of supported Printers, there IDs and compatible models
_pruse=("mp250" "mp280" "mp495" "mg5100" "ip4800" "mg5200" "mg6100" "mg8100")
_prname=(${_pruse[@]})
_prid=("356" "370" "369" "373" "375" "374" "376" "377")
_prcomp=("mp250series" "mp280series" "mp495series" "mg5100series" "ip4800series" "mg5200series" "mg6100series" "mg8100series")
_max=$((${#_pruse[@]}-1)) # used for iterating through these arrays

###
#   Standard Ebuild-functions
###

pkg_setup() {
    if [ -z "$LINGUAS" ]; then    # -z tests to see if the argument is empty
        ewarn "You didn't specify 'LINGUAS' in your make.conf. Assuming"
        ewarn "English localisation, i.e. 'LINGUAS=\"en\"'."
        LINGUAS="en"
    fi

    _prefix="/usr/"
    _bindir="${_prefix}/bin"
    _libdir="/usr/$(get_libdir)" # either lib or lib32
    _cupsdir1="/usr/lib/cups"
    _cupsdir2="/usr/libexec/cups"
    _ppddir="/usr/share/cups/model"

    einfo ""
    einfo " USE-flags\t(description / probably compatible printers)"
    einfo ""
    einfo " amd64\t(basic support for this architecture)"
    einfo " servicetools\t(additional monitoring and maintenance software)"
    einfo " nocupsdetection\t(this is only useful to create binary packages)"
    _autochoose="true"
    for i in $(seq 0 ${_max}); do
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

src_unpack() {
    unpack ${A}
    mv ${PN}-source-${PV}-1 ${P} || die # Correcting directory-structure

    cd "${S}"
}

src_prepare(){
    epatch "${FILESDIR}"/cnnijfilter-fix-missing-pppd_file_t-error.patch 
    epatch "${FILESDIR}"/cnnijfilter-fix-newpng.patch 
	#cnijfilter-3.40-bjcupsmon_ui.c.patch

}

src_compile() {
    cd libs || die
    ./autogen.sh --prefix=${_prefix} || die "Error: libs/autoconf.sh failed"
    make || die "Couldn't make libs"

    cd ../backend || die
    ./autogen.sh --prefix=/usr || die "Error: backend/autoconf.sh failed"
    make || die "Couldn't make backend"

    cd ../backendnet || die
    if use x86; then
        ./autogen.sh --prefix=${_prefix} --enable-progpath=${_bindir} LDFLAGS="-L../../com/libs_bin32" || die "Error: backendnet/autoconf.sh failed"
    else # amd64
        ./autogen.sh --prefix=${_prefix} --enable-progpath=${_bindir} LDFLAGS="-L../../com/libs_bin64" || die "Error: backendnet/autoconf.sh failed"
    fi
    make || die "Couldn't make backendnet"

    cd ../pstocanonij || die
    ./autogen.sh --prefix=/usr --enable-progpath=${_bindir} || die "Error: pstocanonij/autoconf.sh failed"
    make || die "Couldn't make pstocanonij"

    if use servicetools; then
        cd ../cngpij || die
        ./autogen.sh --prefix=${_prefix} --enable-progpath=${_bindir} || die "Error: cngpij/autoconf.sh failed"
        make || die "Couldn't make cngpij" 
    fi

    cd ..

    for i in $(seq 0 ${_max}); do
        if use ${_pruse[$i]} || ${_autochoose}; then
            _pr=${_prname[$i]} _prid=${_prid[$i]}
            src_compile_pr;
        fi
    done
}

src_install() {
    mkdir -p ${D}${_bindir} || die
    mkdir -p ${D}${_libdir}/cups/filter || die
    mkdir -p ${D}${_ppddir} || die
    mkdir -p ${D}${_libdir}/bjlib || die

    cd libs || die
    make DESTDIR=${D} install || die "Couldn't make install libs"

    cd ../backend || die
    make DESTDIR=${D} install || die "Couldn't make install backend"

    cd ../backendnet || die
    make DESTDIR=${D} install || die "Couldn't make install backendnet"

    cd ../pstocanonij || die
    make DESTDIR=${D} install || die "Couldn't make install pstocanoncnij"

    if use servicetools; then
        cd ../cngpij || die
        make DESTDIR=${D} install || die "Couldn't make install cngpij"
    fi

    cd ..

    for i in $(seq 0 ${_max}); do
        if use ${_pruse[$i]} || ${_autochoose}; then
            _pr=${_prname[$i]} _prid=${_prid[$i]}
            src_install_pr;
        fi
    done

    # fix directory structure
    if use nocupsdetection; then
        mkdir -p ${D}${_cupsdir2}/filter || die
        dosym ${_cupsdir1}/filter/pstocanonij ${_cupsdir2}/filter/pstocanonij
    elif has_version ">=net-print/cups-1.2.0"; then
        mkdir -p ${D}${_cupsdir2} || die
        mv ${D}${_cupsdir1}/* ${D}${_cupsdir2} || die
    fi
}

pkg_postinst() {
    einfo ""
    einfo "For installing a printer:"
    einfo " * Restart CUPS: /etc/init.d/cupsd restart"
    einfo " * Go to http://127.0.0.1:631/"
    einfo "   -> Printers -> Add Printer"
    einfo ""
    einfo "If you experience any problems, please visit:"
    einfo " http://forums.gentoo.org/viewtopic-p-3217721.html"
    einfo ""
}

###
#   Custom Helper Functions
###

src_compile_pr()
{
    mkdir ${_pr}
    cp -a ${_prid} ${_pr} || die
    cp -a cnijfilter ${_pr} || die
    cp -a printui ${_pr} || die
    cp -a lgmon ${_pr} || die
    cp -a cngpijmon ${_pr} || die

    sleep 10
    cd ${_pr}/cnijfilter || die
    ./autogen.sh --prefix=${_prefix} --program-suffix=${_pr} --enable-libpath=${_libdir}/bjlib --enable-binpath=${_bindir} || die
    make || die "Couldn't make ${_pr}/cnijfilter"

    if use servicetools; then
        cd ../printui || die
        ./autogen.sh --prefix=${_prefix} --program-suffix=${_pr} --datadir=${_prefix}/share --enable-libpath=${_libdir}/bjlib || die
        make || die "Couldn't make ${_pr}/printui"

        cd ../lgmon || die
        ./autogen.sh --prefix=${_prefix} --program-suffix=${_pr} --enable-progpath=${_bindir}  || die
        make || die "Couldn't make ${_pr}/lgmon"

        cd ../cngpijmon || die
        ./autogen.sh --prefix=${_prefix} --program-suffix=${_pr} --enable-progpath=${_bindir} --datadir=${_prefix}/share || die "Error: cngpijmon/autoconf.sh failed"
        make || die "Couldn't make ${_pr}/cngpijmon"

        cd cnijnpr || die
        ./autogen.sh --prefix=${_prefix} || die "Error: i${_pr}/cngpijmon/cnijnpr failed"
        make || die "Couldn't make ${_pr}/cngpijmon/cnijnpr"
        cd ..
    fi

    cd ../..
}

src_install_pr()
{
    cd ${_pr}/cnijfilter || die
    make DESTDIR=${D} install || die "Couldn't make install ${_pr}/cnijfilter"

    if use servicetools; then
        cd ../printui || die
        make DESTDIR=${D} install || die "Couldn't make install ${_pr}/printui"

        cd ../lgmon || die
        make DESTDIR=${D} install || die "Couldn't make install ${_pr}/lgmon"
       
        cd ../cngpijmon || die
        make DESTDIR=${D} install || die "Couldn't make install ${_pr}/cngpijmon"

        cd cnijnpr || die
        make DESTDIR=${D} install || die "Couldn't make install ${_pr}/cngpijmon/cnijnpr"
        cd ..
    fi

    cd ../..

    if use x86; then
        cp -a ${_prid}/libs_bin32/* ${D}${_libdir} || die
        cp -a com/libs_bin32/* ${D}${_libdir} || die
    else # amd54
        cp -a ${_prid}/libs_bin64/* ${D}${_libdir} || die
        cp -a com/libs_bin64/* ${D}${_libdir} || die
    fi
    cp -a ${_prid}/database/* ${D}${_libdir}/bjlib || die
    cp -a ppd/canon${_pr}.ppd ${D}${_ppddir} || die
    cp com/ini/cnnet.ini ${D}${_libdir}/bjlib || die

    chown lp:lp ${D}${_libdir}/bjlib/cnnet.ini || die
    chmod 644 ${D}${_libdir}/bjlib/* || die
} 
