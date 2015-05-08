# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

LANG=ZH

DESCRIPTION="Yozo Office -- Fully Functional Office Suite"
HOMEPAGE="http://www.yozosoft.com/person/"
#SRC_URI="http://download.yozosoft.com/free/zh/2012/Yozo_Office_${PV}$LANG.tar.gz"
SRC_URI="http://download.yozosoft.com/free/zh/2012/Yozo_Office_${PV}ZH.deb"
FEATURES="mirror"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=" x11-libs/libXext[abi_x86_32]
x11-libs/libXrender[abi_x86_32]
x11-libs/libXtst[abi_x86_32]
x11-libs/libXi[abi_x86_32]
media-libs/alsa-lib[abi_x86_32]"

RDEPEND="${DEPEND}"

DEPEND="${DEPEND}
app-arch/tar
app-arch/unzip
sys-apps/findutils"

S="${WORKDIR}"

src_install(){
	lnks="yozo-calc.desktop yozo.desktop yozofileconvert.desktop  yozo-impress.desktop yozo-pdf.desktop  yozo-writer.desktop"
	# 解压
	tar -xf data.tar.gz -C "${D}"
	
	cd "${D}"

	
	sed -i -e "s/\/usr\/local/\/opt/g"  "etc/Yozosoft/Yozo_Office/installinfo.cfg"
	
	dodir /opt

	mv	"${D}/usr/bin" "${D}/opt/"	
	mv	"${D}/usr/local/Yozosoft" "${D}/opt/"
	mv	"${D}/usr/share/yozofileicon" "${D}/opt/Yozosoft"


	rm -r "${D}/usr/local"
	rm -rf "${D}/usr/share/applications/yozo-latest.desktop"

	cd "${D}/usr/share/applications/"
	
	for d in ${lnks} ; do
		#指向正确的可执行文件路径
		sed -i -e "s/\/usr\/bin\//\/opt\/bin\//g" $d
		sed -i -e "s/\/usr\/share\/yozofileicon\//\/opt\/Yozosoft\/yozofileicon\//g" $d
	done

	unpackP="${D}/opt/Yozosoft/Yozo_Office/Jre/bin/unpack200"
	libP="${D}/opt/Yozosoft/Yozo_Office/Jre/lib"

	$unpackP -r $libP/rt.pack.gz $libP/rt.jar
	$unpackP -r $libP/jsse.pack.gz $libP/jsse.jar
	$unpackP -r $libP/charsets.pack.gz $libP/charsets.jar
	$unpackP -r $libP/plugin.pack.gz $libP/plugin.jar
	$unpackP -r $libP/javaws.pack.gz $libP/javaws.jar
	$unpackP -r $libP/deploy.pack.gz $libP/deploy.jar
	$unpackP -r $libP/resources.pack.gz $libP/resources.jar

	$unpackP -r $libP/ext/localedata.pack.gz $libP/ext/localedata.jar
	$unpackP -r $libP/ext/bcprov-jdk14-124.pack.gz $libP/ext/bcprov-jdk14-124.jar
	$unpackP -r $libP/ext/jai_core.pack.gz $libP/ext/jai_core.jar
	$unpackP -r $libP/ext/tools.pack.gz $libP/ext/tools.jar
	$unpackP -r $libP/ext/ojdbc14.pack.gz $libP/ext/ojdbc14.jar
	$unpackP -r $libP/ext/mysql-connector-java-5.1.18-bin.pack.gz $libP/ext/mysql-connector-java-5.1.18-bin.jar
	$unpackP -r $libP/ext/swt.pack.gz $libP/ext/swt.jar
	$unpackP -r $libP/ext/DJNativeSwing-SWT.pack.gz $libP/ext/DJNativeSwing-SWT.jar
	$unpackP -r $libP/ext/jhall.pack.gz $libP/ext/jhall.jar
	$unpackP -r $libP/ext/bcel-5.1.pack.gz $libP/ext/bcel-5.1.jar

	$unpackP -r ${D}/opt/Yozosoft/Yozo_Office/Yozo_Office.pack.gz ${D}/opt/Yozosoft/Yozo_Office/Yozo_Office.jar 

	cd ${D}
	chown root:root -R ${D}

	find -type f -exec chmod 0644 {} +
	find -type d -exec chmod 0755 {} +
	find -name '*.bin' -exec chmod 0755 {} +
	cd opt/bin
	find -exec chmod 0755 {} + 
}

pkg_postinst(){
	# "handling file association, waiting a while..."
	/opt/Yozosoft/Yozo_Office/Jre/bin/java -client -jar /opt/Yozosoft/Yozo_Office/Mimelnk/fileAssociate.jar -i

}

pkg_prerm(){
	/opt/Yozosoft/Yozo_Office/Jre/bin/java -client -jar /opt/Yozosoft/Yozo_Office/Mimelnk/fileAssociate.jar -u
	rm /opt/Yozosoft/Yozo_Office/System/ -rf
}
