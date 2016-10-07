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
  gcc -v
  echo "this was gcc compiler version"
  dpkg --list | grep compiler
  echo "another version"

  wget $BOOST_URL

  tar --bzip2 -xf "boost_$BOOST_UNDERSCORE_VERSION.tar.bz2"

  pushd boost_${BOOST_UNDERSCORE_VERSION}
  
  PREFIX="../installed/boost_${BOOST_UNDERSCORE_VERSION}/BoostBuildInstallDir"
  mkdir -p $PREFIX
  pushd $PREFIX
  PREFIX=$(pwd)
  echo "PREFIX=$PREFIX"
  popd


  #./bootstrap.sh --with-toolset=gcc --prefix=../installed/boost_${BOOST_UNDERSCORE_VERSION} --with-libraries=test
  #./b2 --prefix=../installed/boost_${BOOST_UNDERSCORE_VERSION} --build-type=complete --with-test --layout=tagged -d0 toolset=gcc link=shared runtime-link=static threading=multi --build-dir=Build variant=release cxxflags=-fPIC cxxflags=-std=c++11 install
  pushd tools/build
  ./bootstrap.sh
  
  ./b2 --prefix=${PREFIX} --ignore-site-config

  echo "export BOOST_BUILD_INSTALLED_BIN=${PREFIX}/bin" >> $HOME/.bash_profile
  echo "export PATH=\$BOOST_BUILD_INSTALLED_BIN:\$PATH" >> $HOME/.bash_profile
  . ~/.bash_profile

  popd

  BUILD_DIR="../installed/boost_${BOOST_UNDERSCORE_VERSION}/build_boost"
  mkdir -p $BUILD_DIR
  pushd $BUILD_DIR
  BUILD_DIR=$(pwd)
  echo "BUILD_DIR=$BUILD_DIR"
  popd
  #pushd ../installed/boost_${BOOST_UNDERSCORE_VERSION}/boost_root

  echo "using gcc : 5 : ${COMPILER} : cxxflags=-std=gnu++11 ;" >> ./tools/build/src/user-config.jam
  
  pushd ../installed/boost_${BOOST_UNDERSCORE_VERSION}
  BOOST_INSTALL_PATH=$(pwd)
  echo "BOOST_INSTALL_PATH=$BOOST_INSTALL_PATH"
  popd

  b2 --prefix=$BOOST_INSTALL_PATH --build-dir=$BUILD_DIR --with-test --layout=tagged toolset=gcc link=shared threading=multi variant=debug,release cxxflags=-fPIC cxxflags=-std=c++11 --ignore-site-config install #>boostbuild.log 2>&1

  popd
  popd
  popd

fi