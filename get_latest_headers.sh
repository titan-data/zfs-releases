#!/bin/bash
#
# Copyright The Titan Project Contributors.
#

set -e

out=""
for line in $(apt list -a linux-headers-*-azure 2>/dev/null)
do
        if [[ $line == linux-headers-5.4.0-*-azure* ]] ;
        then
                out=$(echo "$line" | grep -o '^[^/]*')
        fi
done
out=${out#"linux-headers-"}
echo $out

#releases=$(curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/actions/virtual-environments/releases)
#for row in $(echo "${releases}" | jq -r '.[] | @base64'); do
#    _jq() {
#        echo ${row} | base64 --decode | jq -r ${1}
#    }
#    tag=$(_jq '.tag_name')
#    if [[ $tag == ubuntu18/* ]] ;
#    then
#        echo $(_jq '.body')
#    fi
#done