# Copyright 1999-2012 Gentoo Foundation  
# Distributed under the terms of the GNU General Public License v2  
# $Header: $  
  
EAPI=7

inherit eutils games
  
DESCRIPTION="Total Annihilation"
HOMEPAGE=""
LICENSE="as-is"
SLOT="0"  
KEYWORDS=""
IUSE="core-contingency tae battle-tactics"
  
DEPEND="app-arch/unzip 
        app-arch/p7zip"
RDEPEND=">=app-emulation/wine-1.4.1[win32,-win64]"

RESTRICT="fetch strip"


SRC_URI="Total.Annihilation.CD1.zip Total.Annihilation.CD2.iso Total.Annihilation.The.Core.Contingency.iso Total.Annihilation.Battle.Tactics.iso
ta1x-31c.zip installed-ta.zip"

src_unpack() {
#   7z x "${FILESDIR}/Total.Annihilation.CD1.iso" -o"${WORKDIR}/ta_cd1"  
    unzip "${DISTDIR}/Total.Annihilation.CD1.zip" -d "${WORKDIR}/ta_cd1"       # cd1.iso can't be decompressed by p7zip  
  
    7z x "${DISTDIR}/Total.Annihilation.CD2.iso" -o"${WORKDIR}/ta_cd2"  
    7z x "${DISTDIR}/Total.Annihilation.The.Core.Contingency.iso" -o"${WORKDIR}/ta_cd3"  
    7z x "${DISTDIR}/Total.Annihilation.Battle.Tactics.iso" -o"${WORKDIR}/ta_cd4"  
  
    unzip "${DISTDIR}/ta1x-31c.zip" -d "${WORKDIR}/ta1x-31c"  
  
    # Restruct the directory.  
    mkdir -v "${WORKDIR}/TOTALA"  
  
    # Should be extracted from the ZRB files in ta_cd1, but we don't know the ZRB file format  
    unzip "${DISTDIR}/installed-ta.zip" -d "${WORKDIR}/installed-ta"  
    mv -vf "${WORKDIR}/installed-ta"/* "${WORKDIR}/TOTALA"  
    rm -rf "${WORKDIR}/installed-ta"
  
    mv -vf "${WORKDIR}/ta1x-31c"/* "${WORKDIR}/TOTALA"  
    mv -vf "${WORKDIR}/ta_cd1/totala3.hpi" "${WORKDIR}/TOTALA"  
    mv -vf "${WORKDIR}/ta_cd2/totala4.hpi" "${WORKDIR}/TOTALA"  
  
        if use core-contingency ; then  
        for f in "${WORKDIR}/ta_cd3/CC"/* ; do                   # move ta_cd3/CC/* ignoring filename case  
            lwrf=`echo "$(basename $f)" | tr '[:upper:]' '[:lower:]'`  
            if [ "$lwrf" == "totala.exe" ] ; then  
                lwrf="TotalA.exe"  
            fi  
            mv -vf "$f" "${WORKDIR}/TOTALA/${lwrf}"  
        done  
    fi  
  
    if use tae ; then  
        mv -vf "${WORKDIR}/ta_cd3/TAE/Bitmaps" "${WORKDIR}/TOTALA"  
        mv -vf "${WORKDIR}/ta_cd3/TAE/camps" "${WORKDIR}/TOTALA"  
        mv -vf "${WORKDIR}/ta_cd3/TAE/TAE.EXE" "${WORKDIR}/TOTALA"  
        mv -vf "${WORKDIR}/ta_cd3/TAE/TAE.HLP" "${WORKDIR}/TOTALA"  
        mv -vf "${WORKDIR}/ta_cd3/TAE/TAEREAD.DOC" "${WORKDIR}/TOTALA"  
        mv -vf "${WORKDIR}/ta_cd3/TAE/TAEREAD.TXT" "${WORKDIR}/TOTALA"  
        mv -vf "${WORKDIR}/ta_cd3/TAE/Example.tdf" "${WORKDIR}/TOTALA"  
        mv -vf "${WORKDIR}/ta_cd3/TAE/Example.ufo" "${WORKDIR}/TOTALA"  
        mv -vf "${WORKDIR}/ta_cd3/TAE/worlds.hpi" "${WORKDIR}/TOTALA"  
    fi  
  
    if use battle-tactics ; then  
        mv -vf "${WORKDIR}/ta_cd4/bt"/* "${WORKDIR}/TOTALA"  
    fi  
  
    rm -rf "${WORKDIR}/ta1x-31c"  
    rm -rf "${WORKDIR}/ta_cd4"  
    rm -rf "${WORKDIR}/ta_cd3"  
    rm -rf "${WORKDIR}/ta_cd2"  
    rm -rf "${WORKDIR}/ta_cd1"  
}  
  
src_prepare() {  
  
    # Prepare the wrapper script  
    sed -e "s/^GAMEDIR=.*$/GAMEDIR=\/opt\/total-annihilation/g" \  
        -e "s/^DATADIR=.*$/DATADIR=~\/.local\/share\/total-annihilation/g" "${FILESDIR}/total-annihilation" > "${WORKDIR}/total-annihilation"  
}  

src_install() {  
  
    dodir "${GAMES_PREFIX_OPT}/total-annihilation"  
    cp -r "TOTALA" "${D}/${GAMES_PREFIX_OPT}/total-annihilation"  
  
    dogamesbin "total-annihilation"  
    #doicon "${FILESDIR}/nfs9.png"  
    domenu "${FILESDIR}/total-annihilation.desktop"  
  
    prepgamesdirs  
}
