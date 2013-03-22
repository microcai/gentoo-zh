#!/bin/bash

find . -type f -name ChangeLog -exec svn ps svn:keywords Id \{\} \;
find . -type f -name \*.ebuild -exec svn ps svn:keywords Id \{\} \;
