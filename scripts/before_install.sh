#! /bin/bash

if [ $TRAVIS_OS_NAME = osx ]
then
	brew update
    brew outdated cmake || brew upgrade cmake
    brew outdated boost || brew upgrade boost
elif [ $TRAVIS_OS_NAME = linux ]
then
  #install cmake--------------------------------------------------------------------
  mkdir ~/cmake_tmp
  cd ~/cmake_tmp
  cmake_version="3.6.1"
  CMAKE_URL="https://cmake.org/files/v3.6/cmake-$cmake_version-Linux-x86_64.tar.gz"
  wget $CMAKE_URL
  tar xf cmake-$cmake_version-Linux-x86_64.tar.gz
  #sudo cp -r cmake-$cmake_version-Linux-x86_64/* /usr/local
  sudo cp -r cmake-$cmake_version-Linux-x86_64/* /usr
  cd ..
  rm -rf ~/cmake_tmp

  #install boost--------------------------------------------------------------------
  BOOST_UNDERSCORE_VERSION=${BOOST_VERSION//./_}
  #echo "BOOST_UNDERSCORE_VERSION:$BOOST_UNDERSCORE_VERSION"

  mkdir deps
  DEPS_DIR=deps
  pushd $DEPS_DIR

  mkdir boost
  pushd boost

  BOOST_URL="http://sourceforge.net/projects/boost/files/boost/$BOOST_VERSION/boost_$BOOST_UNDERSCORE_VERSION.tar.bz2"
  echo "BOOST_URL: $BOOST_URL"

  wget $BOOST_URL

  tar --bzip2 -xf "boost_$BOOST_UNDERSCORE_VERSION.tar.bz2"

  pushd boost_${BOOST_UNDERSCORE_VERSION}
  
  mkdir -p ../installed/boost_${BOOST_UNDERSCORE_VERSION}


  ./bootstrap.sh --prefix=../installed/boost_${BOOST_UNDERSCORE_VERSION} --with-libraries=test
  ./b2 --layout=tagged -d0 link=shared threading=multi install
  
  pushd ../installed/boost_${BOOST_UNDERSCORE_VERSION}/lib
  echo "lib directory contains >>"
  ls
  popd
  
  echo "include dir contains >>"
  pushd ../installed/boost_${BOOST_UNDERSCORE_VERSION}/include/boost
  ls
  popd

  popd
  popd
  popd

fi