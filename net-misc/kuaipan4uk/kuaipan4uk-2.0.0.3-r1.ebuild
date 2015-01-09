# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="KuaiPan is one of the most popular cloud storage service in China. "
HOMEPAGE="http://www.ubuntukylin.com/applications/showimg.php?lang=cn&id=21"
SRC_URI="amd64? ( https://launchpadlibrarian.net/180448424/${PN}_1404_${PV}_amd64.deb )
 x86? ( https://launchpadlibrarian.net/180448408/kuaipan4uk_1404_${PV}_i386.deb )
"

LICENSE=" "
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="dev-qt/qtgui:4
sys-libs/zlib
media-libs/freetype:2
x11-libs/libSM
x11-libs/libXrender
x11-libs/libXext
app-arch/bzip2
dev-libs/icu
media-video/rtmpdump
dev-libs/crypto++
dev-libs/nss
dev-libs/boost
x11-libs/libqxt"
DEPEND="${RDEPEND}"
S=${WORKDIR}

src_compile(){
  tar xf ${WORKDIR}/data.tar.xz
  rm control.tar.gz  data.tar.xz  debian-binary
  rm -f usr/bin/*
  rm -rf etc
  rm opt/ubuntukylin/kuaipan4uk/pkglist
  rm -rf usr/share/keyrings
  echo -e "#! /bin/bash\nexport LD_LIBRARY_PATH=/opt/ubuntukylin/kuaipan4uk/lib:\$LD_LIBRARY_PATH\n/opt/ubuntukylin/kuaipan4uk/bin/kuaipan4uk_script">usr/bin/kuaipan4uk_script
  sed -i 's/bin\/kuaipan4uk/bin\/kuaipan4uk_script/g' usr/share/applications/kuaipan4uk.desktop
  sed -i 's/.png//g' usr/share/applications/kuaipan4uk.desktop 
}

src_install(){
  dodir /opt/ubuntukylin/kuaipan4uk
  insinto /opt/ubuntukylin/kuaipan4uk
  doins -r ${S}/opt/ubuntukylin/kuaipan4uk/*
  fperms 0755 /opt/ubuntukylin/kuaipan4uk/bin/kuaipan4uk
  fperms 0755 /opt/ubuntukylin/kuaipan4uk/bin/kuaipan4uk_script
  dodir /usr/bin
  insinto /usr/bin
  insopts -m0755
  doins ${S}/usr/bin/kuaipan4uk_script
  dosym /opt/ubuntukylin/kuaipan4uk/bin/kuaipan4uk /usr/bin/kuaipan4uk 
  insinto /usr/share
  doins -r ${S}/usr/share/*
  
  if [ ! -e /usr/lib/libboost_iostreams.so.1.56.0 ];
  	then dosym /usr/lib/libboost_iostreams.so  /opt/ubuntukylin/kuaipan4uk/lib/libboost_iostreams.so.1.56.0;
  fi;  
}
