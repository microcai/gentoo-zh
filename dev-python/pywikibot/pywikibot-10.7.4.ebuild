# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit pypi distutils-r1

DESCRIPTION="To interact with MediaWiki API (for example Wikipedia, Wikimedia Commons)"
HOMEPAGE="
	https://www.mediawiki.org/wiki/Manual:Pywikibot
	https://github.com/wikimedia/pywikibot
	https://pypi.org/project/pywikibot
"

LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/mwparserfromhell[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"

# TODO drop this after releasing of
# https://github.com/wikimedia/pywikibot/commit/af271172a09b39f9f68d707520dad454cefd74db
# We have this against
# "
# License classifiers are deprecated.
# `project.license` as a TOML table is deprecated
# "
src_prepare() {
	default

	# Remove deprecared license lines
	sed -i '/^license = {.*}/d' pyproject.toml || die
	sed -i '/"License ::/d' pyproject.toml || die
}
