#!/bin/bash
BASE_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ARCHIVE=pytorch-1.4.0

function make_patch_for_file() {
  local base_dir=$1
  local orig_dir=$2
  local work_dir=$3
  local target_dir=$4
  local index=$5
  local file=$6
  
  cd $base_dir
  diff -urN -x '*.orig' -x'*.rej' $orig_dir/$file $work_dir/$file > $target_dir/$index-${file////-}.patch
}

function make_patch_for_file_0() {
  make_patch_for_file $BASE_PATH/../src $ARCHIVE.orig $ARCHIVE $BASE_PATH/.. $1 $2
}

make_patch_for_file_0 0001 tools
make_patch_for_file_0 0002 c10
make_patch_for_file_0 0003 third_party/sleef
make_patch_for_file_0 0004 caffe2
