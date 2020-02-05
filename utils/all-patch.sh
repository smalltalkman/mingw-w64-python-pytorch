#!/bin/bash
BASE_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ARCHIVE=pytorch-1.4.0

cd $BASE_PATH/../src
diff -urN -x '.git' -x '*.orig' -x '*.rej' $ARCHIVE.orig $ARCHIVE > $BASE_PATH/all.patch
