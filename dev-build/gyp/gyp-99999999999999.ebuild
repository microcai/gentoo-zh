# Copyright 2017-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_SINGLE_IMPL="1"
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="GYP (Generate Your Projects) meta-build system"
HOMEPAGE="https://gyp.gsrc.io/ https://chromium.googlesource.com/external/gyp"

if [[ "${PV}" == "99999999999999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://chromium.googlesource.com/external/gyp"
fi

LICENSE="BSD"
SLOT="0"

RDEPEND="$(python_gen_cond_dep 'dev-python/six[${PYTHON_USEDEP}]')"

python_prepare_all() {
	distutils-r1_python_prepare_all

	sed -e "s/'  Linux %s' % ' '\.join(platform.linux_distribution())/'  Linux'/" -i gyptest.py || die
	sed -e "s/the_dict_key is 'variables'/the_dict_key == 'variables'/" -i pylib/gyp/input.py || die
	sed \
		-e "s/os\.environ\['PRESERVE'\] is not ''/os.environ['PRESERVE'] != ''/" \
		-e "s/conditions is ()/conditions == ()/" \
		-i test/lib/TestCmd.py || die
}

python_test() {
	# More errors with DeprecationWarnings enabled.
	local -x PYTHONWARNINGS=""

	"${PYTHON}" gyptest.py --all --verbose
}
