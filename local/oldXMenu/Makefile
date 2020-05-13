### oldXMenu/Makefile.  Generated from Makefile.in by configure.

## Copyright 1985, 1986, 1987 by the Massachusetts Institute of Technology

## Permission to use, copy, modify, and distribute this
## software and its documentation for any purpose and without
## fee is hereby granted, provided that the above copyright
## notice appear in all copies and that both that copyright
## notice and this permission notice appear in supporting
## documentation, and that the name of M.I.T. not be used in
## advertising or publicity pertaining to distribution of the
## software without specific, written prior permission.
## M.I.T. makes no representations about the suitability of
## this software for any purpose.  It is provided "as is"
## without express or implied warranty.


## Copyright (C) 2001-2020 Free Software Foundation, Inc.

## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.

## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.

## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.


### Commentary:

## To the best of our knowledge, this code was originally based on the
## X11 oldXMenu Makefile, which was automatically generated from the
## X11 oldXMenu Imakefile.  There was no explicit copyright information
## in the Imakefile, therefore we have added the same MIT license as
## used by the rest of the oldXMenu code.


### Code:

srcdir=.././emacs/oldXMenu
# MinGW CPPFLAGS may use this.
abs_top_srcdir=/home/hyuk.myeong/local/./emacs
VPATH=.././emacs/oldXMenu
C_SWITCH_X_SITE= -isystem /usr/include/freetype2
C_SWITCH_SYSTEM=
C_SWITCH_MACHINE=
PROFILING_CFLAGS = 
WARN_CFLAGS =  -fno-common -W -Waddress -Waggressive-loop-optimizations -Wall -Wattributes -Wbool-compare -Wbuiltin-macro-redefined -Wchar-subscripts -Wclobbered -Wcomment -Wcomments -Wcoverage-mismatch -Wcpp -Wdate-time -Wdeprecated -Wdeprecated-declarations -Wdesignated-init -Wdisabled-optimization -Wdiscarded-array-qualifiers -Wdiscarded-qualifiers -Wdiv-by-zero -Wdouble-promotion -Wempty-body -Wendif-labels -Wenum-compare -Wextra -Wformat-contains-nul -Wformat-extra-args -Wformat-security -Wformat-signedness -Wformat-y2k -Wformat-zero-length -Wfree-nonheap-object -Wignored-qualifiers -Wimplicit -Wimplicit-function-declaration -Wimplicit-int -Wincompatible-pointer-types -Winit-self -Wint-conversion -Wint-to-pointer-cast -Winvalid-memory-model -Winvalid-pch -Wlogical-not-parentheses -Wlogical-op -Wmain -Wmaybe-uninitialized -Wmemset-transposed-args -Wmissing-braces -Wmissing-declarations -Wmissing-include-dirs -Wmissing-parameter-type -Wmissing-prototypes -Wmultichar -Wnarrowing -Wnested-externs -Wnonnull -Wodr -Wold-style-declaration -Wold-style-definition -Wopenmp-simd -Woverflow -Wpacked -Wpacked-bitfield-compat -Wparentheses -Wpointer-arith -Wpointer-sign -Wpointer-to-int-cast -Wpragmas -Wpsabi -Wreturn-local-addr -Wreturn-type -Wsequence-point -Wshift-count-negative -Wshift-count-overflow -Wsizeof-array-argument -Wsizeof-pointer-memaccess -Wstrict-aliasing -Wstrict-prototypes -Wsuggest-attribute=format -Wsuggest-attribute=noreturn -Wsuggest-final-methods -Wsuggest-final-types -Wswitch-bool -Wtrampolines -Wtrigraphs -Wuninitialized -Wunknown-pragmas -Wunused -Wunused-but-set-parameter -Wunused-but-set-variable -Wunused-function -Wunused-label -Wunused-local-typedefs -Wunused-macros -Wunused-result -Wunused-value -Wunused-variable -Wvarargs -Wvariadic-macros -Wvector-operation-performance -Wvolatile-register-var -Wwrite-strings -Warray-bounds=2 -Wnormalized=nfc -Wredundant-decls -Wno-missing-field-initializers -Wno-override-init -Wno-sign-compare -Wno-type-limits -Wno-unused-parameter -Wno-format-nonliteral
WERROR_CFLAGS = 

EXTRA=insque.o
CC=gcc
CFLAGS=-g3 -O2
CPPFLAGS =   

RM = rm -f
RANLIB = ranlib
AR = ar
ARFLAGS = cr
MKDIR_P = /bin/mkdir -p
EXEEXT = 

OBJS =  Activate.o \
	AddPane.o \
	AddSel.o \
	ChgPane.o \
	ChgSel.o \
	Create.o \
	DelPane.o \
	DelSel.o \
	Destroy.o \
	Error.o \
	EvHand.o \
	FindPane.o \
	FindSel.o \
	InsPane.o \
	InsSel.o \
	Internal.o \
	Locate.o \
	Post.o \
	Recomp.o \
	SetAEQ.o \
	SetFrz.o \
	SetPane.o \
	SetSel.o \
      XDelAssoc.o XLookAssoc.o XCrAssoc.o XDestAssoc.o XMakeAssoc.o

all: libXMenu11.a
.PHONY: all

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

ALL_CFLAGS=$(C_SWITCH_SYSTEM) $(C_SWITCH_MACHINE) \
  $(C_SWITCH_X_SITE) $(DEPFLAGS) \
  $(WARN_CFLAGS) $(WERROR_CFLAGS) ${PROFILING_CFLAGS} \
  $(CPPFLAGS) $(CFLAGS) -DEMACS_BITMAP_FILES \
  -I../src -I../lib -I${srcdir} -I${srcdir}/../src -I${srcdir}/../lib

.c.o:
	$(AM_V_CC)$(CC) -c ${ALL_CFLAGS} $<

libXMenu11.a: $(OBJS) $(EXTRA)
	$(AM_V_GEN)$(RM) $@
	$(AM_V_at)$(AR) $(ARFLAGS) $@ $(OBJS) $(EXTRA)
	$(AM_V_at)$(RANLIB) $@

.PHONY: mostlyclean clean distclean bootstrap-clean maintainer-clean

clean mostlyclean:
	rm -f libXMenu11.a ./*.o $(DEPDIR)/*

bootstrap-clean maintainer-clean distclean: clean
	rm -f Makefile
	rm -fr $(DEPDIR)

ETAGS = ../lib-src/etags${EXEEXT}

${ETAGS}: FORCE
	${MAKE} -C ../lib-src $(notdir $@)

tagsfiles = $(wildcard ${srcdir}/*.[ch])

FORCE:
.PHONY: tags FORCE
tags: TAGS
TAGS: ${ETAGS} ${tagsfiles}
	${ETAGS} ${tagsfiles}

### Makefile.in ends here
