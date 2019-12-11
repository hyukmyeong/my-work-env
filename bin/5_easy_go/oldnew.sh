#!/bin/bash

function bury_copy()
{
       mkdir -p `dirname $2` && cp "$1" "$2";
}

$(bury_copy $1 diff_old/$BASE)
$(bury_copy $2 diff_new/$BASE)
