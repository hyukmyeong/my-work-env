### lwlib/Makefile.  Generated from Makefile.in by configure.

# Copyright (C) 1992, 1993 Lucid, Inc.
# Copyright (C) 1994, 2001-2020 Free Software Foundation, Inc.
#
# This file is part of the Lucid Widget Library.
#
# The Lucid Widget Library is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 1, or (at your option)
# any later version.
#
# The Lucid Widget Library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with GNU Emacs.  If not, see <https://www.gnu.org/licenses/>.


# This was taken from the output of Imake using Lucid's Imakefile.
# and set up to be configured by ../configure.

all: liblw.a
.PHONY: all

srcdir=.././emacs/lwlib
# MinGW CPPFLAGS may use this.
abs_top_srcdir=/home/hyuk.myeong/local/./emacs
VPATH=.././emacs/lwlib
C_SWITCH_X_SITE= -isystem /usr/include/freetype2
C_SWITCH_SYSTEM=
C_SWITCH_MACHINE=
PROFILING_CFLAGS = 
WARN_CFLAGS =  -fno-common -W -Waddress -Waggressive-loop-optimizations -Wall -Wattributes -Wbool-compare -Wbuiltin-macro-redefined -Wchar-subscripts -Wclobbered -Wcomment -Wcomments -Wcoverage-mismatch -Wcpp -Wdate-time -Wdeprecated -Wdeprecated-declarations -Wdesignated-init -Wdisabled-optimization -Wdiscarded-array-qualifiers -Wdiscarded-qualifiers -Wdiv-by-zero -Wdouble-promotion -Wempty-body -Wendif-labels -Wenum-compare -Wextra -Wformat-contains-nul -Wformat-extra-args -Wformat-security -Wformat-signedness -Wformat-y2k -Wformat-zero-length -Wfree-nonheap-object -Wignored-qualifiers -Wimplicit -Wimplicit-function-declaration -Wimplicit-int -Wincompatible-pointer-types -Winit-self -Wint-conversion -Wint-to-pointer-cast -Winvalid-memory-model -Winvalid-pch -Wlogical-not-parentheses -Wlogical-op -Wmain -Wmaybe-uninitialized -Wmemset-transposed-args -Wmissing-braces -Wmissing-declarations -Wmissing-include-dirs -Wmissing-parameter-type -Wmissing-prototypes -Wmultichar -Wnarrowing -Wnested-externs -Wnonnull -Wodr -Wold-style-declaration -Wold-style-definition -Wopenmp-simd -Woverflow -Wpacked -Wpacked-bitfield-compat -Wparentheses -Wpointer-arith -Wpointer-sign -Wpointer-to-int-cast -Wpragmas -Wpsabi -Wreturn-local-addr -Wreturn-type -Wsequence-point -Wshift-count-negative -Wshift-count-overflow -Wsizeof-array-argument -Wsizeof-pointer-memaccess -Wstrict-aliasing -Wstrict-prototypes -Wsuggest-attribute=format -Wsuggest-attribute=noreturn -Wsuggest-final-methods -Wsuggest-final-types -Wswitch-bool -Wtrampolines -Wtrigraphs -Wuninitialized -Wunknown-pragmas -Wunused -Wunused-but-set-parameter -Wunused-but-set-variable -Wunused-function -Wunused-label -Wunused-local-typedefs -Wunused-macros -Wunused-result -Wunused-value -Wunused-variable -Wvarargs -Wvariadic-macros -Wvector-operation-performance -Wvolatile-register-var -Wwrite-strings -Warray-bounds=2 -Wnormalized=nfc -Wredundant-decls -Wno-missing-field-initializers -Wno-override-init -Wno-sign-compare -Wno-type-limits -Wno-unused-parameter -Wno-format-nonliteral
WARN_CFLAGS := $(filter-out -Wwrite-strings,${WARN_CFLAGS})
WERROR_CFLAGS = 
CAIRO_CFLAGS= 

CC=gcc
CFLAGS=-g3 -O2
CPPFLAGS=  
RANLIB=ranlib

AR = ar
ARFLAGS = cr
MKDIR_P = /bin/mkdir -p
EXEEXT = 

LUCID_OBJS = lwlib-Xlw.o xlwmenu.o lwlib-Xaw.o
MOTIF_OBJS = lwlib-Xm.o

## LUCID_OBJS or MOTIF_OBJS.
TOOLKIT_OBJS = $(none_OBJS)

OBJS = lwlib.o $(TOOLKIT_OBJS) lwlib-utils.o

# 'make' verbosity.
AM_DEFAULT_VERBOSITY = 0

AM_V_CC = $(am__v_CC_$(V))
am__v_CC_ = $(am__v_CC_$(AM_DEFAULT_VERBOSITY))
am__v_CC_0 = @echo "  CC      " $@;
am__v_CC_1 =

AM_V_GEN = $(am__v_GEN_$(V))
am__v_GEN_ = $(am__v_GEN_$(AM_DEFAULT_VERBOSITY))
am__v_GEN_0 = @echo "  GEN     " $@;
am__v_GEN_1 =

AM_V_at = $(am__v_at_$(V))
am__v_at_ = $(am__v_at_$(AM_DEFAULT_VERBOSITY))
am__v_at_0 = @
am__v_at_1 =

AUTO_DEPEND = yes
DEPDIR = deps
ifeq ($(AUTO_DEPEND),yes)
  DEPFLAGS = -MMD -MF $(DEPDIR)/$*.d -MP
  -include $(ALLOBJS:%.o=$(DEPDIR)/%.d)
else
  DEPFLAGS =
  include $(srcdir)/deps.mk
endif

## ../src is where the generated file (config.h, globals.h) are.
## $(srcdir)/../src is where the non-generated files (lisp.h) are.
## (In an out-of-tree build, these two are not the same.)
## $(srcdir) is where the lwlib sources are.
## There are no generated lwlib files, hence no need for -I.
ALL_CFLAGS= $(C_SWITCH_SYSTEM) $(C_SWITCH_X_SITE) \
  $(C_SWITCH_MACHINE) $(DEPFLAGS) \
  $(WARN_CFLAGS) $(WERROR_CFLAGS) $(PROFILING_CFLAGS) $(CFLAGS) \
  $(CAIRO_CFLAGS) \
  -Demacs -I../src \
  -I$(srcdir) -I$(srcdir)/../src -I../lib -I$(srcdir)/../lib

.c.o:
	$(AM_V_CC)$(CC) -c $(CPPFLAGS) $(ALL_CFLAGS) $<

liblw.a: $(OBJS)
	$(AM_V_GEN)rm -f $@
	$(AM_V_at)$(AR) $(ARFLAGS) $@ $(OBJS)
	$(AM_V_at)$(RANLIB) $@

globals_h = ../src/globals.h
$(globals_h):
	$(MAKE) -C ../src globals.h

.PHONY: mostlyclean clean distclean bootstrap-clean maintainer-clean

clean mostlyclean:
	rm -f ./*.o liblw.a \#* $(DEPDIR)/*

distclean: clean
	rm -f Makefile
	rm -fr $(DEPDIR)

bootstrap-clean maintainer-clean: distclean
	rm -f TAGS

ETAGS = ../lib-src/etags${EXEEXT}

${ETAGS}: FORCE
	${MAKE} -C ../lib-src $(notdir $@)

ctagsfiles= $(wildcard ${srcdir}/*.[ch])

FORCE:
.PHONY: tags FORCE
tags: TAGS
TAGS: ${ETAGS} $(ctagsfiles)
	$(AM_V_GEN)${ETAGS} $(ctagsfiles)

### Makefile.in ends here
