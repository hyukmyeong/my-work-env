#!/bin/sh

crash --rawdump DDRCS0.BIN@0x00000000-0x40000000,DDRCS1.BIN@0x40000000-0x40000000 -p 4096 -m phys_base=0x0 --smp vmlinux --cpus 4
