#!/bin/bash

if [ -z "$S2EDIR" ]; then
  echo "Warning: S2EDIR environment variable is not set, building a normal MySQL."
  echo "         If you want to build a S2E-aware MySQL, do a 'source /path/to/violet/workspace/s2e_activate' first."
fi

root_dir=$(cd "$(dirname "${BASH_SOURCE-$0}")"; pwd)

if [ $# -ne 0 ]; then
  dest=$1
  mkdir -p $dest
else
  dest=.
fi
dest=$(cd $dest && pwd)

mkdir -p $dest/{build,dist}
cd $dest/build

cmake $root_dir/5.5.59  -DCMAKE_INSTALL_PREFIX=$dest/dist \
  -DMYSQL_DATADIR=$dest/dist/data -DWITH_DEBUG=1 -DCMAKE_BUILD_TYPE=DEBUG \
  -DCMAKE_C_FLAGS_DEBUG="-g -O0" -DCMAKE_CXX_FLAGS_DEBUG="-g -O0" \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DMYSQL_MAINTAINER_MODE=false

make -j4
