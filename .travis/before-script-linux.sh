#!/usr/bin/env bash

set -eou pipefail

default_cmake_options=(
"-DCMAKE_INSTALL_PREFIX:PATH=$TRAVIS_BUILD_DIR/BUILD/Install"
'-DCMAKE_BUILD_TYPE=Release' '-DSC_EL=OFF' )
qt_off_options=( '-DSC_QT=OFF' '-DSC_IDE=OFF' )
system_boost_options=( '-DSYSTEM_BOOST=ON' )
system_yamlcpp_options=( '-DSYSTEM_YAMLCPP=ON' )

"$TRAVIS_BUILD_DIR/.travis/lint.sh" "$TRAVIS_BUILD_DIR"

if [ -n "$QT" ]; then
  # shellcheck disable=SC1091
  source /opt/qt59/bin/qt59-env.sh
else
  default_cmake_options+=( "${qt_off_options[@]}" )
fi

if [ -n "$SYSTEM_BOOST" ]; then
  default_cmake_options+=( "${system_boost_options[@]}" )
fi

if [ -n "$SYSTEM_YAMLCPP" ]; then
  default_cmake_options+=( "${system_yamlcpp_options[@]}" )
fi

cmake "${default_cmake_options[@]}" "$TRAVIS_BUILD_DIR" --debug-output
