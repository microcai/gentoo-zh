SRCS+= adb.c
SRCS+= adb_client.c
SRCS+= adb_auth_host.c
SRCS+= commandline.c
SRCS+= console.c
SRCS+= fdevent.c
SRCS+= file_sync_client.c
SRCS+= get_my_path_linux.c
SRCS+= services.c
SRCS+= sockets.c
SRCS+= transport.c
SRCS+= transport_local.c
SRCS+= transport_usb.c
SRCS+= usb_linux.c
SRCS+= usb_vendors.c

VPATH+= ../libcutils
SRCS+= list.c
SRCS+= load_file.c
SRCS+= socket_inaddr_any_server.c
SRCS+= socket_local_client.c
SRCS+= socket_local_server.c
SRCS+= socket_loopback_client.c
SRCS+= socket_loopback_server.c
SRCS+= socket_network_client.c

VPATH+= ../libzipfile
SRCS+= centraldir.c
SRCS+= zipfile.c

CPPFLAGS+= -DADB_HOST=1
CPPFLAGS+= -DADB_HOST_ON_TARGET=1
CPPFLAGS+= -DHAVE_FORKEXEC=1
CPPFLAGS+= -Wno-unused-parameter
CPPFLAGS+= -D_XOPEN_SOURCE
CPPFLAGS+= -D_GNU_SOURCE
CPPFLAGS+= -I.
CPPFLAGS+= -I../include

LIBS+= -lcrypto -lpthread -lz

OBJS= $(SRCS:.c=.o)

all: adb

adb: $(OBJS)
	cc -o $@ $(LDFLAGS) $(OBJS) $(LIBS)

install:
	test -d '$(DESTDIR)/usr/bin' || mkdir -p '$(DESTDIR)/usr/bin'
	cp adb '$(DESTDIR)/usr/bin'
