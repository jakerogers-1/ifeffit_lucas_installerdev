# Makefile.in generated automatically by automae 1.4 from Makefile.am

# Copyright (C) 1994, 1995-8, 1999 Free Software Foundation, Inc.
# This Makefile.in is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.

# Copyright (C) 2000 Matt Newville <newville@cars.uchicago.edu>
#  
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without 
# modifications, as long as this notice is preserved.
# 
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


.SUFFIXES:
.SUFFIXES: .c .f .o 


SHELL = /bin/bash

srcdir = .
top_srcdir = ../..

prefix = /usr/local
exec_prefix = ${prefix}

bindir = ${exec_prefix}/bin
sbindir = ${exec_prefix}/sbin
libexecdir = ${exec_prefix}/libexec
datadir = ${prefix}/share
# sysconfdir = ${prefix}/etc
# sharedstatedir = ${prefix}/com
# localstatedir = ${prefix}/var
libdir = ${exec_prefix}/lib
infodir = ${prefix}/info
mandir = ${prefix}/man
includedir = ${prefix}/include
oldincludedir = /usr/include

DESTDIR =

pkgdatadir = $(datadir)/ifeffit/cldata
pkglibdir = $(libdir)/ifeffit
pkgincludedir = $(includedir)/ifeffit

top_builddir = ../..

ACLOCAL = ${SHELL} /usr/lib/ifeffit-1.2.5_lucas/missing --run aclocal-1.6
AUTOCONF = ${SHELL} /usr/lib/ifeffit-1.2.5_lucas/missing --run autoconf
AUTOHEADER = ${SHELL} /usr/lib/ifeffit-1.2.5_lucas/missing --run autoheader

INSTALL = /usr/bin/install -c
INSTALL_PROGRAM = ${INSTALL} 
INSTALL_DATA = ${INSTALL} -m 644
INSTALL_SCRIPT = ${INSTALL}
transform = s,x,x,

NORMAL_INSTALL = :
PRE_INSTALL = :
POST_INSTALL = :
NORMAL_UNINSTALL = :
PRE_UNINSTALL = :
POST_UNINSTALL = :
host_alias = 
host_triplet = @host@
CC = cc
CPP = cc -E
F2C = @F2C@
F2CFLAGS = @F2CFLAGS@
F77 = g77
FFLAGS = -g -O2 
FLIBS =  -L/usr/lib/gcc/x86_64-linux-gnu/3.4.6 -L/usr/lib/gcc/x86_64-linux-gnu/3.4.6/../../../../lib -L/usr/lib/gcc/x86_64-linux-gnu/3.4.6/../../.. -L/lib/../lib -L/usr/lib/../lib -lfrtbegin -lg2c -lm -lgcc_s
MAKEINFO = ${SHELL} /usr/lib/ifeffit-1.2.5_lucas/missing --run makeinfo
PACKAGE = ifeffit
RANLIB = ranlib
VERSION = 1.2.5

CL_DATAFILES = 04.dat 05.dat 06.dat 07.dat 08.dat 09.dat 10.dat 11.dat \
	12.dat 13.dat 14.dat 15.dat 16.dat 17.dat 18.dat 19.dat 20.dat \
	21.dat 22.dat 23.dat 24.dat 25.dat 26.dat 27.dat 28.dat 29.dat \
	30.dat 31.dat 32.dat 33.dat 34.dat 35.dat 36.dat 37.dat 38.dat \
	39.dat 40.dat 41.dat 42.dat 43.dat 44.dat 45.dat 46.dat 47.dat \
	48.dat 49.dat 50.dat 51.dat 52.dat 53.dat 54.dat 55.dat 56.dat \
	57.dat 58.dat 59.dat 60.dat 61.dat 62.dat 63.dat 64.dat 65.dat \
	66.dat 67.dat 68.dat 69.dat 70.dat 71.dat 72.dat 73.dat 74.dat \
	75.dat 76.dat 77.dat 78.dat 79.dat 80.dat 81.dat 82.dat 83.dat \
	84.dat 85.dat 86.dat 87.dat 88.dat 89.dat 90.dat 91.dat 92.dat


pkgdata_DATA = $(CL_DATAFILES)

mkinstalldirs = $(SHELL) $(top_srcdir)/mkinstalldirs
CONFIG_HEADER = ../../config.h
LIBRARIES =  

DEFS = -DHAVE_CONFIG_H -I. -I$(srcdir) -I../..
CPPFLAGS = 
LDFLAGS =  -L./lib/termcap
LIBS = 


AR = ar
F77COMPILE = $(F77) $(FFLAGS)
F77LD   = $(F77)
F77LINK = $(F77LD) $(FFLAGS) $(LDFLAGS) -o $@
CFLAGS  = -g -O2
COMPILE = $(CC) $(DEFS) $(INCLUDES) $(CPPFLAGS) $(CFLAGS)
CCLD    = $(CC)
LINK    = $(CCLD) $(CFLAGS) $(LDFLAGS) -o $@
DATA    = $(pkgdata_DATA)
HEADERS = $(include_HEADERS)
DIST_COMMON =  ChangeLog Makefile.in 
DISTFILES   = $(DIST_COMMON) $(SOURCES) $(HEADERS) $(TEXINFOS) $(EXTRA_DIST)

SOURCES = 
OBJECTS = 


all: Makefile $(DATA)

Makefile: $(srcdir)/Makefile.in  $(top_builddir)/config.status $(BUILT_SOURCES)
	cd $(top_builddir) \
	  && CONFIG_FILES=$(subdir)/$@ CONFIG_HEADERS= $(SHELL) ./config.status

clean-data:
	rm $(MAKE_TEMPS)

clean-LIBRARIES:
	-test -z "$(LIBRARIES)" || rm -f $(LIBRARIES)

install-LIBRARIES: $(LIBRARIES)
	@$(NORMAL_INSTALL)
	$(mkinstalldirs) $(DESTDIR)$(libdir)
	@list='$(LIBRARIES)'; for p in $$list; do \
	  if test -f $$p; then \
	    echo " $(INSTALL_DATA) $$p $(DESTDIR)$(libdir)/$$p"; \
	    $(INSTALL_DATA) $$p $(DESTDIR)$(libdir)/$$p; \
	  else :; fi; \
	done
	@$(POST_INSTALL)
	@list='$(LIBRARIES)'; for p in $$list; do \
	  if test -f $$p; then \
	    echo " $(RANLIB) $(DESTDIR)$(libdir)/$$p"; \
	    $(RANLIB) $(DESTDIR)$(libdir)/$$p; \
	  else :; fi; \
	done

uninstall-LIBRARIES:
	@$(NORMAL_UNINSTALL)
	list='$(IBRARIES)'; for p in $$list; do \
	  rm -f $(DESTDIR)$(libdir)/$$p; \
	done


mostlyclean:
	-rm -f *.o core *.core

clean-compile:
	-rm -f *.o core *.core

distclean-compile:
	-rm -f *.tab.c

libifeffit.a: $(OBJECTS) 
	-rm -f libifeffit.a
	$(AR) cru libifeffit.a $(OBJECTS)
	$(RANLIB) libifeffit.a

.f.o:
	$(F77COMPILE) -c $<

install-pkgdataDATA: $(pkgdata_DATA)
	@$(NORMAL_INSTALL)
	$(mkinstalldirs) $(DESTDIR)$(pkgdatadir)
	@list='$(pkgdata_DATA)'; for p in $$list; do \
	  if test -f $(srcdir)/$$p; then \
	    echo " $(INSTALL_DATA) $(srcdir)/$$p $(DESTDIR)$(pkgdatadir)/$$p"; \
	    $(INSTALL_DATA) $(srcdir)/$$p $(DESTDIR)$(pkgdatadir)/$$p; \
	  else if test -f $$p; then \
	    echo " $(INSTALL_DATA) $$p $(DESTDIR)$(pkgdatadir)/$$p"; \
	    $(INSTALL_DATA) $$p $(DESTDIR)$(pkgdatadir)/$$p; \
	  fi; fi; \
	done

uninstall-pkgdataDATA:
	@$(NORMAL_UNINSTALL)
	list='$(pkgdata_DATA)'; for p in $$list; do \
	  rm -f $(DESTDIR)$(pkgdatadir)/$$p; \
	done

install-includeHEADERS: $(include_HEADERS)
	@$(NORMAL_INSTALL)
	$(mkinstalldirs) $(DESTDIR)$(includedir)
	@list='$(include_HEADERS)'; for p in $$list; do \
	  if test -f "$$p"; then d= ; else d="$(srcdir)/"; fi; \
	  echo " $(INSTALL_DATA) $$d$$p $(DESTDIR)$(includedir)/$$p"; \
	  $(INSTALL_DATA) $$d$$p $(DESTDIR)$(includedir)/$$p; \
	done

uninstall-includeHEADERS:
	@$(NORMAL_UNINSTALL)
	list='$(include_HEADERS)'; for p in $$list; do \
	  rm -f $(DESTDIR)$(includedir)/$$p; \
	done


ID: $(HEADERS) $(SOURCES) $(LISP)
	list='$(SOURCES) $(HEADERS)'; \
	unique=`for i in $$list; do echo $$i; done | \
	  awk '    { files[$$0] = 1; } \
	       END { for (i in files) print i; }'`; \
	here=`pwd` && cd $(srcdir) \
	  && mkid -f$$here/ID $$unique $(LISP)

distdir = $(top_builddir)/$(PACKAGE)-$(VERSION)/$(subdir)

subdir = src/lib

distdir: $(DISTFILES)
	here=`cd $(top_builddir) && pwd`; \
	top_distdir=`cd $(top_distdir) && pwd`; \
	distdir=`cd $(distdir) && pwd`; \
	@for file in $(DISTFILES); do \
	  d=$(srcdir); \
	  if test -d $$d/$$file; then \
	    cp -pr $$/$$file $(distdir)/$$file; \
	  else \
	    test -f $(distdir)/$$file \
	    || ln $$d/$$file $(distdir)/$$file 2> /dev/null \
	    || cp -p $$d/$$file $(distdir)/$$file || :; \
	  fi; \
	done

# DEPS_MAGIC := $(shell mkdir .deps > /dev/null 2>&1 || :)
# -include $(DEP_FILES)


%.o: %.c
	$(COMPILE) -c $<

check: all
install-exec: install-LIBRARIES

install-data: install-pkgdataDATA install-includeHEADERS

install: all
	@$(MAKE) install-exec install-data
uninstall: uninstall-LIBRARIES uninstall-pkgdataDATA \
		uninstall-includeHEADERS

installdirs:
	$(mkinstalldirs)  $(DESTDIR)$(libdir) $(DESTDIR)$(pkgdatadir) \
		$(DESTDIR)$(includedir)

clean-generic:
	-test -z "$(CLEANFILES)" || rm -f $(CLEANFILES)

clean:  clean-LIBRARIES clean-compile  \
		clean-generic mostlyclean

distclean: 
	-rm -f Makefile config.cache config.log stamp-h stamp-h[0-9]*

maintainer-clean:  maintainer-clean-LIBRARIES \
		maintainer-clean-compile  \
		maintainer-clean-generic \
		distclean
	@echo "This command is intended for maintainers to use;"
	@echo "it deletes files that may require special tools to rebuild."


.PHONY: clean-LIBRARIES maintainer-clean-LIBRARIES uninstall-LIBRARIES \
install-LIBRARIES mostlyclean  \
clean-compile maintainer-clean-compile uninstall-pkgdataDATA \
install-pkgdataDATA uninstall-includeHEADERS install-includeHEADERS \
distdir check installcheck  install-exec install-data  install  uninstall \
all installdirs  clean-generic \
maintainer-clean-generic clean distclean maintainer-clean

