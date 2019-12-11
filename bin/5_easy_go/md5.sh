#!/bin/bash

#JREPO="android/vendor/lge/common/tools/jrepo.sh"
JREPO="jrepo.sh"
${JREPO} 32 'echo ${REPO_PATH} `git log -1 --pretty=format:%H`'| LC_COLLATE=C sort > md5list

{
while read line
do
  echo "$line" |awk '{ORS=""; print $2}'
done < md5list
} |md5sum

#rm md5list
