# How to add this overlay to your Gentoo system

```
eselect repository enable gentoo-zh
emaint sync
```

# rule no.1

DO NOT BREAK PEOPLE'S SYSTEM

# rule no.2

DO NOT BREAK PEOPLE'S SYSTEM

# rule no.3

follow rule no.1 and no.2

# the dependencies table

https://github.com/microcai/gentoo-zh/blob/deps-table/relation.md

# commit message

* for non-version bump commit, commit message should be like this:

        $category/$package: one line short description message
        {empty line}
        multiple lines of description about why you change this.
        if you change to fix the bug, and if there is an GitHub
        issue entry for that bug, then point the bug link here.

* for version bump commit, commit message should be like this:

        $category/$package: version bump to $new_version

# package review

* I trust contributors that have commit rights, therefore commitors
  should think carefully before committing.

* If you want to discuss your commit/patch, push to *another branch* or send a
  Pull Request and discuss in the GitHub Issue, mailing list, or talk to the maintainer
  directly.

* If you are sending a new pull request, make sure it contains all necessary commits
  for a single contribution, e.g. don't send two pull requests for an ebuild and its
  `Manifest`.

* Every ebuild change should not produce compile error before
  committing.

* Every ebuild should be tested in every ARCH that it KEYWORDS for.
  if not, don't claim that you support that keyword.

* If you are writing the ebuild for a font, and you are using stantard font.eclass
  to install the font, I could grant an exception for the must-tested-in-every-ARCH
  rule. You could use something like

  `KEYWORDS="alpha amd64 arm hppa ppc mips ~s390 ~sh sparc x86 ~x86-fbsd"`

  But please don't abuse this exception. It must be a pure font package.

# Distfiles mirror

We provide a distfiles mirror that caches the distfiles in gentoo-zh.

Our server, hosted on Finland:
```
GENTOO_MIRRORS="${GENTOO_MIRRORS} https://distfiles.gentoocn.org"
```

Chongqing University mirror:
```
GENTOO_MIRRORS="${GENTOO_MIRRORS} https://mirrors.cqu.edu.cn/gentoo-zh"
```

Nanjing University mirror:
```
GENTOO_MIRRORS="${GENTOO_MIRRORS} https://mirrors.nju.edu.cn/gentoo-zh"
```

# See wiki for some package not working
