#! /bin/bash

if [ $TRAVIS_OS_NAME = osx ]
then
	brew update
    brew outdated cmake || brew upgrade cmake
    brew outdated boost || brew upgrade boost;
elif [ $TRAVIS_OS_NAME = linux ]
then
  echo "this is linux blablabla"
  CMAKE_URL="http://www.cmake.org/files/v3.3/cmake-3.3.1-Linux-x86_64.tar.gz"
  mkdir cmake && travis_retry wget --quiet -O - ${CMAKE_URL} | tar --strip-components=1 -xz -C cmake
  export PATH=${DEPS_DIR}/cmake/bin:${PATH}
fi