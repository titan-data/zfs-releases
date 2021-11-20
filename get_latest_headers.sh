#!/bin/bash
#
# Copyright The Titan Project Contributors.
#

set -e

out=""
for line in $(apt list -a linux-headers-*-azure 2>/dev/null)
do
        if [[ $line == linux-headers-*-azure* ]] ;
        then
                out=$(echo "$line" | grep -o '^[^/]*')
        fi
done
echo $out