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
  local target_file=$index-${file////-}.patch
  
  echo Generating $target_file ...
  cd $base_dir
  diff -urN -x '*.orig' -x'*.rej' $orig_dir/$file $work_dir/$file > $target_dir/$target_file
}

function make_patch_for_file_0() {
  make_patch_for_file $BASE_PATH/../src $ARCHIVE.orig $ARCHIVE $BASE_PATH/.. $1 $2
}

make_patch_for_file_0 0001 tools
make_patch_for_file_0 0002 c10
make_patch_for_file_0 0003 third_party/sleef
make_patch_for_file_0 0004 caffe2
make_patch_for_file_0 0005 torch
make_patch_for_file_0 0006 aten

make_patch_for_file_0 2001 CMakeLists.txt
make_patch_for_file_0 2002 setup.py

cd $BASE_PATH/..
updpkgsums

find $BASE_PATH/.. -maxdepth 1 -name "*.patch" | xargs cat > $BASE_PATH/all-in-one.patch
