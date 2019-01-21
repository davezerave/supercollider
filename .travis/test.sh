#!/usr/bin/env bash

set -eou pipefail

if [[ "$TRAVIS_OS_NAME" == linux ]]; then
  export SCLANG="$TRAVIS_BUILD_DIR/BUILD/Install/bin/sclang"
else
  export SCLANG="$TRAVIS_BUILD_DIR/BUILD/Install/SuperCollider/SuperCollider.app/Contents/MacOS/sclang"
fi

# $TRAVIS_BUILD_DIR/testsuite/sclang/launch_test.py $SCLANG

if [ -n "$QT" ]; then "$TRAVIS_BUILD_DIR/.travis/qpm-test.sh" ; fi
