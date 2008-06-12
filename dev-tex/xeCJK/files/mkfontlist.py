#!/usr/bin/python
# check the ttf fonts and make fontlist.tex ready for xeCJK
# author: Yu Yuwei <acevery@gmail.com>
# version 0.2 2008.6.11
# copyright: GPL-2

import os
import re
import sys

n_patt = re.compile(r'^\\setCJKlanguagefont\{(.{1,3})\}{"(.*)"}')
d_patt = re.compile(r'^\\setCJKlanguagefont\[def\]\{(.{1,3})\}{"(.*)"}')
c_patt = re.compile(r'^%.*')
f=file('fontlist.tex','r')
lines = f.readlines()
f.close()
new_lines=[]
sfont={}
dfont={}

# now we process every line in fontlist.tex
for line in lines:
	res = c_patt.match(line)
	if res:
		new_lines.append(line)
		continue
	res = n_patt.match(line)
	if res:
		fres=os.system( 'fc-list | grep "%s,"' % res.group(2) )
		if fres == 0:
			new_lines.append(line)
			sfont[res.group(1)]=''
		else:
			new_lines.append( '%'+'%s' % line )
		continue
	res = d_patt.match(line)
	if res:
		fres=os.system( 'fc-list | grep "%s,"' % res.group(2) )
		if fres == 0:
			new_lines.append(line)
			dfont[res.group(1)]=''
		else:
			new_lines.append( '%'+'%s' % line )
		continue
	# this line do not need to take care.
	continue

for lang in sfont.keys():
	if not dfont.has_key(lang):
		print "we don't have the default font for %s" % lang
		sys.exit(1)

os.system('mv fontlist.tex fontlist.tex.bak')

f = file ('fontlist.tex','w')
f.write( '\\def\\ghostscript{gs}\n' )
f.writelines( new_lines )
f.close()
