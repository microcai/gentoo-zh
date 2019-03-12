# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DIST_AUTHOR=TOBYINK
DIST_VERSION=0.006
inherit perl-module

DESCRIPTION="XML::LibXML::PrettyPrint - add pleasant whitespace to a DOM tree"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/XML-LibXML
		>=dev-perl/Exporter-Tiny-0.26.0"
DEPEND="${RDEPEND}
		test? (                                               
        	dev-perl/Test-Warnings                            
		)"

