#!/bin/bash
BASE_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ARCHIVE=pytorch-1.4.0

cd $BASE_PATH/../src
diff -ur $ARCHIVE python-build-x86_64 > $BASE_PATH/python-build-x86_64.patch
