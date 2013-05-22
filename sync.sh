#!/bin/sh

set -e

source config.sh

SCRIPT_DIR=$( (cd -P $(dirname $0) && pwd) )
DIST_DIR_BASE=${DIST_DIR_BASE:="$SCRIPT_DIR/dist"}
OPUS_VER="2040606f4a1d3b230bdf00e1b7e4427df8dcdd3b"

echo ${OPUS_VER}

git submodule update --init opus
cd opus
git checkout master
git pull origin master
git checkout ${OPUS_VER}
cd ..

for ARCH in $ARCHS
do
    OPUS_DIR=opus-$ARCH
    echo "Syncing source for $ARCH to directory $OPUS_DIR"
    rsync opus/ $OPUS_DIR/ --exclude '.*' -a --delete
done
