# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Terminal YouTube client for searching and watching videos using mpv"
HOMEPAGE="https://github.com/KrishnaSSH/gophertube"

EGO_SUM=(
	"github.com/BurntSushi/toml v1.5.0"
	"github.com/BurntSushi/toml v1.5.0/go.mod"
	"github.com/BurntSushi/toml v1.6.0"
	"github.com/BurntSushi/toml v1.6.0/go.mod"
	"github.com/atotto/clipboard v0.1.4"
	"github.com/atotto/clipboard v0.1.4/go.mod"
	"github.com/aymanbagabas/go-osc52/v2 v2.0.1"
	"github.com/aymanbagabas/go-osc52/v2 v2.0.1/go.mod"
	"github.com/charmbracelet/bubbles v1.0.0"
	"github.com/charmbracelet/bubbles v1.0.0/go.mod"
	"github.com/charmbracelet/bubbletea v1.3.10"
	"github.com/charmbracelet/bubbletea v1.3.10/go.mod"
	"github.com/charmbracelet/colorprofile v0.2.3-0.20250311203215-f60798e515dc"
	"github.com/charmbracelet/colorprofile v0.2.3-0.20250311203215-f60798e515dc/go.mod"
	"github.com/charmbracelet/colorprofile v0.4.1"
	"github.com/charmbracelet/colorprofile v0.4.1/go.mod"
	"github.com/charmbracelet/colorprofile v0.4.3"
	"github.com/charmbracelet/colorprofile v0.4.3/go.mod"
	"github.com/charmbracelet/lipgloss v1.1.0"
	"github.com/charmbracelet/lipgloss v1.1.0/go.mod"
	"github.com/charmbracelet/x/ansi v0.8.0"
	"github.com/charmbracelet/x/ansi v0.8.0/go.mod"
	"github.com/charmbracelet/x/ansi v0.10.1"
	"github.com/charmbracelet/x/ansi v0.10.1/go.mod"
	"github.com/charmbracelet/x/ansi v0.11.6"
	"github.com/charmbracelet/x/ansi v0.11.6/go.mod"
	"github.com/charmbracelet/x/ansi v0.11.7"
	"github.com/charmbracelet/x/ansi v0.11.7/go.mod"
	"github.com/charmbracelet/x/cellbuf v0.0.13-0.20250311204145-2c3ea96c31dd"
	"github.com/charmbracelet/x/cellbuf v0.0.13-0.20250311204145-2c3ea96c31dd/go.mod"
	"github.com/charmbracelet/x/cellbuf v0.0.15"
	"github.com/charmbracelet/x/cellbuf v0.0.15/go.mod"
	"github.com/charmbracelet/x/term v0.2.1"
	"github.com/charmbracelet/x/term v0.2.1/go.mod"
	"github.com/charmbracelet/x/term v0.2.2"
	"github.com/charmbracelet/x/term v0.2.2/go.mod"
	"github.com/chzyer/logex v1.2.1"
	"github.com/chzyer/logex v1.2.1/go.mod"
	"github.com/chzyer/readline v1.5.1"
	"github.com/chzyer/readline v1.5.1/go.mod"
	"github.com/chzyer/test v1.0.0"
	"github.com/chzyer/test v1.0.0/go.mod"
	"github.com/clipperhouse/displaywidth v0.9.0"
	"github.com/clipperhouse/displaywidth v0.9.0/go.mod"
	"github.com/clipperhouse/displaywidth v0.11.0"
	"github.com/clipperhouse/displaywidth v0.11.0/go.mod"
	"github.com/clipperhouse/stringish v0.1.1"
	"github.com/clipperhouse/stringish v0.1.1/go.mod"
	"github.com/clipperhouse/uax29/v2 v2.5.0"
	"github.com/clipperhouse/uax29/v2 v2.5.0/go.mod"
	"github.com/clipperhouse/uax29/v2 v2.7.0"
	"github.com/clipperhouse/uax29/v2 v2.7.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/erikgeiser/coninput v0.0.0-20211004153227-1c3628e74d0f"
	"github.com/erikgeiser/coninput v0.0.0-20211004153227-1c3628e74d0f/go.mod"
	"github.com/lucasb-eyer/go-colorful v1.2.0"
	"github.com/lucasb-eyer/go-colorful v1.2.0/go.mod"
	"github.com/lucasb-eyer/go-colorful v1.3.0"
	"github.com/lucasb-eyer/go-colorful v1.3.0/go.mod"
	"github.com/lucasb-eyer/go-colorful v1.4.0"
	"github.com/lucasb-eyer/go-colorful v1.4.0/go.mod"
	"github.com/mattn/go-isatty v0.0.20"
	"github.com/mattn/go-isatty v0.0.20/go.mod"
	"github.com/mattn/go-isatty v0.0.21"
	"github.com/mattn/go-isatty v0.0.21/go.mod"
	"github.com/mattn/go-localereader v0.0.1"
	"github.com/mattn/go-localereader v0.0.1/go.mod"
	"github.com/mattn/go-runewidth v0.0.16"
	"github.com/mattn/go-runewidth v0.0.16/go.mod"
	"github.com/mattn/go-runewidth v0.0.19"
	"github.com/mattn/go-runewidth v0.0.19/go.mod"
	"github.com/mattn/go-runewidth v0.0.23"
	"github.com/mattn/go-runewidth v0.0.23/go.mod"
	"github.com/muesli/ansi v0.0.0-20230316100256-276c6243b2f6"
	"github.com/muesli/ansi v0.0.0-20230316100256-276c6243b2f6/go.mod"
	"github.com/muesli/cancelreader v0.2.2"
	"github.com/muesli/cancelreader v0.2.2/go.mod"
	"github.com/muesli/termenv v0.16.0"
	"github.com/muesli/termenv v0.16.0/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/rivo/uniseg v0.2.0/go.mod"
	"github.com/rivo/uniseg v0.4.7"
	"github.com/rivo/uniseg v0.4.7/go.mod"
	"github.com/stretchr/testify v1.10.0"
	"github.com/stretchr/testify v1.10.0/go.mod"
	"github.com/stretchr/testify v1.11.1"
	"github.com/stretchr/testify v1.11.1/go.mod"
	"github.com/urfave/cli-altsrc/v3 v3.0.1"
	"github.com/urfave/cli-altsrc/v3 v3.0.1/go.mod"
	"github.com/urfave/cli-altsrc/v3 v3.1.0"
	"github.com/urfave/cli-altsrc/v3 v3.1.0/go.mod"
	"github.com/urfave/cli/v3 v3.3.8"
	"github.com/urfave/cli/v3 v3.3.8/go.mod"
	"github.com/urfave/cli/v3 v3.8.0"
	"github.com/urfave/cli/v3 v3.8.0/go.mod"
	"github.com/xo/terminfo v0.0.0-20220910002029-abceb7e1c41e"
	"github.com/xo/terminfo v0.0.0-20220910002029-abceb7e1c41e/go.mod"
	"golang.org/x/sys v0.0.0-20210809222454-d867a43fc93e/go.mod"
	"golang.org/x/sys v0.0.0-20220310020820-b874c991c1a5/go.mod"
	"golang.org/x/sys v0.6.0/go.mod"
	"golang.org/x/sys v0.34.0"
	"golang.org/x/sys v0.34.0/go.mod"
	"golang.org/x/sys v0.36.0"
	"golang.org/x/sys v0.36.0/go.mod"
	"golang.org/x/sys v0.38.0"
	"golang.org/x/sys v0.38.0/go.mod"
	"golang.org/x/sys v0.43.0"
	"golang.org/x/sys v0.43.0/go.mod"
	"golang.org/x/exp v0.0.0-20231006140011-7918f672742d"
	"golang.org/x/exp v0.0.0-20231006140011-7918f672742d/go.mod"
	"golang.org/x/text v0.3.8"
	"golang.org/x/text v0.3.8/go.mod"
	"golang.org/x/text v0.36.0"
	"golang.org/x/text v0.36.0/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
)
go-module_set_globals

SRC_URI="
	https://github.com/KrishnaSSH/gophertube/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}
"

LICENSE="GPL-3 MIT BSD Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	media-video/mpv
	net-misc/yt-dlp
"
BDEPEND="
	app-arch/unzip
	>=dev-lang/go-1.25.0:=
"

DOCS=( CONTRIBUTING.md README.md )

src_compile() {
	CGO_ENABLED=0 ego build \
		-trimpath \
		-ldflags "-s -w -X gophertube/internal/app.version=${PV}" \
		-o gophertube \
		.
}

src_install() {
	dobin gophertube
	doman man/gophertube.1
	einstalldocs
}
