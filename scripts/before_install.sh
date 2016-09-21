#! /bin/bash

ANSI_RED="\033[31;1m"
ANSI_GREEN="\033[32;1m"
ANSI_RESET="\033[0m"
ANSI_CLEAR="\033[0K"

travis_retry() {
  local result=0
  local count=1
  while [ $count -le 3 ]; do
    [ $result -ne 0 ] && {
      echo -e "\n${ANSI_RED}The command \"$@\" failed. Retrying, $count of 3.${ANSI_RESET}\n" >&2
    }
    "$@"
    result=$?
    [ $result -eq 0 ] && break
    count=$(($count + 1))
    sleep 1
  done

  [ $count -gt 3 ] && {
    echo -e "\n${ANSI_RED}The command \"$@\" failed 3 times.${ANSI_RESET}\n" >&2
  }

  return $result
}

if [ $TRAVIS_OS_NAME = osx ]
then
	brew update
    brew outdated cmake || brew upgrade cmake
    brew outdated boost || brew upgrade boost;
elif [ $TRAVIS_OS_NAME = linux ]
then
  echo "this is linux blablabla"
  mkdir ~/cmake_tmp
  cd ~/cmake_tmp
  cmake_version="3.6.2"
  CMAKE_URL="https://cmake.org/files/v3.6/cmake-$cmake_version-Linux-x86_64.tar.gz"
  wget $CMAKE_URL
  tar xf cmake-$cmake_version-Linux-x86_64.tar.gz
  sudo cp -r cmake-$cmake_version-Linux-x86_64/* /usr
  rm -rf ~/cmake_tmp
  #CMAKE_URL="http://www.cmake.org/files/v3.3/cmake-3.3.1-Linux-x86_64.tar.gz"
  #mkdir cmake && travis_retry wget --quiet -O - ${CMAKE_URL} | tar --strip-components=1 -xz -C cmake
  #export PATH=${DEPS_DIR}/cmake/bin:${PATH}
fi