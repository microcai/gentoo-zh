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

It is recommended to run `pkgdev commit` to quickly generate commit messages.

* for non-version bump commit, commit message should be like this:

        $category/$package: one line short description message
        {empty line}
        multiple lines of description about why you change this.
        if you change to fix the bug, and if there is an GitHub
        issue entry for that bug, then point the bug link here.

* for version bump commit, commit message should be like this:

        $category/$package: add $new_version, drop $old_version

# Contributions

* I trust contributors that have commit rights, therefore commitors
  should think carefully before committing.

* If you are sending a new pull request, make sure it contains all necessary commits
  for a single contribution, e.g. don't send two pull requests for an ebuild and its
  `Manifest`.

* Every ebuild change should not produce compile error before committing.

* Every ebuild should be tested in every ARCH that it KEYWORDS for.
  if not, don't claim that you support that keyword.

* Every ebuild is to have ~arch keywords. Stable keywords must not be used.

* Run `pkgcheck scan --commits --net` locally before you open pull request.

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
