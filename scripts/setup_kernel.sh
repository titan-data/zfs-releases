#!/bin/sh

set -e

mkdir -p src/$(uname -r)
printf %s "$(uname -a)" >> src/$(uname -r)/uname
