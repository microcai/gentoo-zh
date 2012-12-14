# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit python

DESCRIPTION="Google App Engine SDK for Python"
HOMEPAGE="http://appengine.google.com/"
SRC_URI="http://${PN/-/}.googlecode.com/files/${PN/-/_}_${PV}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND="
	dev-python/mysql-python
	dev-python/lxml
	dev-python/imaging
	dev-python/numpy
	dev-python/pycrypto
	dev-python/django
	dev-python/jinja
	dev-python/markupsafe
	dev-python/pyopenssl
	dev-python/pyyaml
	dev-python/webob
	media-libs/libpng:1.2
"

PYTHON_DEPEND="2"

S="${WORKDIR}/${PN/-/_}"

src_prepare(){
	sed -i -e "s#^DIR_PATH = .*\$#DIR_PATH = '/opt/${PN}'#" \
		-e 's#/usr/bin/env python#/usr/bin/python2#' *.py \
		|| die "sed failed"
	find -name "*.jpg" -exec rm -f {} \; 
	find -name "*.png" -exec rm -f {} \;
}

src_install(){
	insinto /opt/${PN}
	doins -r google lib || die "install failed"

	if use examples ; then
		insinto /opt/${PN}/examples
		doins -r demos new_project_template || die "install examples failed"
	fi

	dobin *.py
	dodoc BUGS README RELEASE_NOTES
}
