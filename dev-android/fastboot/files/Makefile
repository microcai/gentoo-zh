# Makefile for fastboot

SRCS+=protocol.c
SRCS+=engine.c
SRCS+=bootimg.c
SRCS+=fastboot.c
SRCS+=usb_linux.c
SRCS+=util_linux.c

VPATH+= ../libzipfile
SRCS+= centraldir.c
SRCS+= zipfile.c

CPPFLAGS+= -DADB_HOST=1
CPPFLAGS+= -DHAVE_FORKEXEC=1
CPPFLAGS+= -DHAVE_SYMLINKS
CPPFLAGS+= -DHAVE_TERMIO_H
CPPFLAGS+= -D_GNU_SOURCE
CPPFLAGS+= -D_XOPEN_SOURCE
CPPFLAGS+= -I.
CPPFLAGS+= -I../include
CPPFLAGS+= -I../mkbootimg
CPPFLAGS+= -I../../../external/zlib

CFLAGS+= -O2 -Wno-unused-parameter
LDFLAGS= 
LIBS= -lrt -lpthread -lz

OBJS= $(SRCS:.c=.o)

all: fastboot

fastboot: $(OBJS)
	cc -o $@ $(LDFLAGS) $(OBJS) $(LIBS)

install:
	test -d '$(DESTDIR)/usr/bin' || mkdir -p '$(DESTDIR)/usr/bin'
	cp fastboot '$(DESTDIR)/usr/bin'

clean:
	rm -rf $(OBJS)
