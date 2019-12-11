#!/bin/bash

if [ -f diff.zip ]
then
       rm diff.zip
fi

git difftool -y -x '~/bin/oldnew.sh' $@
zip -r diff.zip diff_new diff_old
rm -rf diff_new
rm -rf diff_old
