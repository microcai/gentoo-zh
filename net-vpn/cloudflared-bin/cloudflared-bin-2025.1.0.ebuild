# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Cloudflare Tunnel client (formerly Argo Tunnel)"
HOMEPAGE="https://github.com/cloudflare/cloudflared"
SRC_URI+="
	amd64? (
		https://github.com/cloudflare/cloudflared/releases/download/${PV}/cloudflared-linux-amd64
			-> cloudflared-${PV}-amd64
	)
	arm64? (
		https://github.com/cloudflare/cloudflared/releases/download/${PV}/cloudflared-linux-arm64
			-> cloudflared-${PV}-arm64
	)
	doc? (
		https://raw.githubusercontent.com/cloudflare/cloudflared/refs/tags/${PV}/RELEASE_NOTES
			-> RELEASE_NOTES-${PV}
	)"
S=${WORKDIR}

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* amd64 ~arm64"
IUSE="doc"

RESTRICT="strip"

src_prepare() {
	default

	case ${ARCH} in
	        amd64)
	                cp "${DISTDIR}/cloudflared-${PV}-amd64" cloudflared || die
	                ;;
	        arm64)
	                cp "${DISTDIR}/cloudflared-${PV}-arm64" cloudflared || die
	                ;;
	        *)
	                die "Unsupported arch ${ARCH}"
	                ;;
	esac

	use doc && (cp "${DISTDIR}/RELEASE_NOTES-${PV}" release_notes || die)
}

src_install() {
	exeinto /usr/bin
	doexe "${S}/cloudflared"
	use doc && dodoc "${S}/release_notes"
}
