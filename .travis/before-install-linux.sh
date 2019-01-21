#!/usr/bin/env bash

set -eou pipefail

additional_repositories=( 'ppa:ubuntu-toolchain-r/test'
'ppa:beineri/opt-qt591-trusty' )
default_packages=( 'build-essential' 'gcc-4.9' 'g++-4.9' 'cmake' 'pkg-config'
'libjack-jackd2-dev' 'libsndfile1-dev' 'libasound2-dev' 'libavahi-client-dev'
'libreadline6-dev' 'libfftw3-dev' 'libicu-dev' 'libxt-dev' 'libudev-dev' )
qt_packages=( 'libgl1-mesa-dev' 'qt59base' 'qt59location' 'qt59declarative'
'qt59tools' 'qt59webengine' 'qt59webchannel' 'qt59xmlpatterns' 'qt59svg'
'qt59websockets' )
boost_packages=( 'boost-all-dev' )
yamlcpp_packages=( 'libyaml-cpp-dev' )

add_additional_repositories() {
  for repo in "${additional_repositories[@]}"; do
    sudo add-apt-repository --yes "${repo}"
  done
  sudo apt-get update
}

install_packages() {
  local packages=( "${default_packages[@]}" )
  if [ -n "$QT" ]; then
    packages+=( "${qt_packages[@]}" )
  fi
  if [ -n "$SYSTEM_BOOST" ]; then
    packages+=( "${boost_packages[@]}" )
  fi
  if [ -n "$SYSTEM_YAMLCPP" ]; then
    packages+=( "${yamlcpp_packages[@]}" )
  fi
  npm install -g lintspaces-cli
  sudo apt-get install --yes "${packages[@]}"
}

update_alternatives() {
  sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 60 \
                           --slave /usr/bin/g++ g++ /usr/bin/g++-4.9
  sudo update-alternatives --auto gcc
}

add_additional_repositories
install_packages
update_alternatives
