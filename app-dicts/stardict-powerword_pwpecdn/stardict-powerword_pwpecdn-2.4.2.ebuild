# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

FROM_LANG="Simplified Chinese (GB)"
TO_LANG="English"
DICT_SUFFIX="powerword_pwpecdn"

inherit stardict

HOMEPAGE="http://stardict.sourceforge.net/Dictionaries_Quick.php"

KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

RDEPEND=">=app-text/stardict-2.4.2"
