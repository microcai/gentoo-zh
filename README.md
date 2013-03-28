#rule no.1

DO NOT BREAK PEOPLE'S SYSTEM

#rule no.2

DO NOT BREAK PEOPLE'S SYSTEM

#rule no.3

follow rule no.1 and no.2

#commit message

* for non-version bump commit, commit message should be like this:

        [category/package]: one line short description message
        {empty line}
        [
            multiple lines of description about why you change this.
            if you change to fix the bug, and if there is an google code
            issue entry for that bug, then point the bug link here.
        ]

* for version bump commit, commit message should be like this:

        [category/package]: version bump to [new version]

#package review

* I trust contributors that have commit rights, therefore commitors
  should think carfully befor committing.

* If you want to discuss your commit/patch, push to *another branch*
  and discuss in the mail list or with the maintainer.

* Every ebuild change should not produce compile error before
  committing.

* Every ebuild should be tested in every ARCH that it KEYWORDS for.
  if not, don't claim that you support that keyword.

