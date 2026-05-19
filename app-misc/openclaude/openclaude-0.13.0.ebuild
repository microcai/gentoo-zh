# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Open-source coding-agent CLI for cloud and local LLM providers"
HOMEPAGE="https://github.com/Gitlawb/openclaude"
# Scoped npm package: @gitlawb/openclaude
# Bundled dist/cli.mjs still has dynamic imports requiring node_modules at runtime.
# Vendor tarball with production node_modules is hosted on gentoo-zh-drafts.
SRC_URI="
	https://registry.npmjs.org/@gitlawb/${PN}/-/${P}.tgz
	https://github.com/gentoo-zh-drafts/openclaude/releases/download/v${PV}/${P}-node_modules.tar.gz
"
S="${WORKDIR}/package"

LICENSE="openclaude"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist mirror strip"

RDEPEND="
	>=net-libs/nodejs-22
	dev-vcs/git
	sys-apps/ripgrep
"

src_unpack() {
	default
	# Vendor tarball contains 'package/node_modules/'; unpack to ${WORKDIR}
	# so it lands at ${S}/node_modules
	tar xzf "${DISTDIR}/${P}-node_modules.tar.gz" -C "${WORKDIR}"
}

src_install() {
	local install_dir="/usr/$(get_libdir)/node_modules/@gitlawb/${PN}"

	insinto "${install_dir}"
	doins -r .

	fperms +x "${install_dir}/bin/openclaude"
	dosym "../$(get_libdir)/node_modules/@gitlawb/${PN}/bin/openclaude" "/usr/bin/openclaude"
	fperms +x /usr/bin/openclaude

	# Restore execute permissions lost by doins for native binaries
	local bin
	while IFS= read -r -d '' bin; do
		fperms +x "${bin#${ED}}"
	done < <(find "${ED}${install_dir}"/node_modules -type f \( \
		-name '*.node' -o \
		-name 'rg' -o \
		-name 'esbuild' -o \
		-name 'apply-seccomp' \
	\) -print0 2>/dev/null)

	# Restore execute permissions for .bin wrappers and their targets
	local link target
	for link in "${ED}${install_dir}"/node_modules/.bin/*; do
		[ -L "${link}" ] || continue
		target=$(readlink -f "${link}")
		[ -f "${target}" ] || continue
		fperms +x "${target#${ED}}"
	done
}
