# Makefile for systems with GNU tools
CC 	=	gcc
INSTALL	=	install
IFLAGS  = -idirafter dummyinc
#CFLAGS = -g
CFLAGS	=	-O2 -Wall -W -Wshadow #-pedantic -Werror -Wconversion

LIBS	=	`./vsf_findlibs.sh`
LINK	=	-Wl,-s

OBJS	=	main.o utility.o prelogin.o ftpcmdio.o postlogin.o privsock.o \
		tunables.o ftpdataio.o secbuf.o ls.o \
		postprivparent.o logging.o str.o netstr.o sysstr.o strlist.o \
    banner.o filestr.o parseconf.o secutil.o \
    ascii.o oneprocess.o twoprocess.o privops.o standalone.o hash.o \
    tcpwrap.o ipaddrparse.o access.o features.o readwrite.o opts.o \
    ssl.o sslslave.o ptracesandbox.o ftppolicy.o sysutil.o sysdeputil.o \
    crc32.o


.c.o:
	$(CC) -c $*.c $(CFLAGS) $(IFLAGS)

flowftpd: $(OBJS)
	$(CC) -o flowftpd $(OBJS) $(LINK) $(LIBS) $(LDFLAGS)

install:
	if [ -x /usr/local/sbin ]; then \
		$(INSTALL) -m 755 flowftpd /usr/local/sbin/flowftpd; \
	else \
		$(INSTALL) -m 755 flowftpd /usr/sbin/flowftpd; fi
	if [ -x /usr/local/man ]; then \
		$(INSTALL) -m 644 flowftpd.8 /usr/local/man/man8/flowftpd.8; \
		$(INSTALL) -m 644 flowftpd.conf.5 /usr/local/man/man5/flowftpd.conf.5; \
	elif [ -x /usr/share/man ]; then \
		$(INSTALL) -m 644 flowftpd.8 /usr/share/man/man8/flowftpd.8; \
		$(INSTALL) -m 644 flowftpd.conf.5 /usr/share/man/man5/flowftpd.conf.5; \
	else \
		$(INSTALL) -m 644 flowftpd.8 /usr/man/man8/flowftpd.8; \
		$(INSTALL) -m 644 flowftpd.conf.5 /usr/man/man5/flowftpd.conf.5; fi
	if [ -x /etc/xinetd.d ]; then \
		$(INSTALL) -m 644 xinetd.d/flowftpd /etc/xinetd.d/flowftpd; fi

clean:
	rm -f *.o *.swp flowftpd

