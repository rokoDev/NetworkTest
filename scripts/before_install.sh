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
    brew outdated boost || brew upgrade boost
elif [ $TRAVIS_OS_NAME = linux ]
then
  echo "this is linux blablabla"
  mkdir ~/cmake_tmp
  cd ~/cmake_tmp
  cmake_version="3.6.2"
  CMAKE_URL="https://cmake.org/files/v3.6/cmake-$cmake_version-Linux-x86_64.tar.gz"
  wget $CMAKE_URL
  tar xf cmake-$cmake_version-Linux-x86_64.tar.gz
  #sudo cp -r cmake-$cmake_version-Linux-x86_64/* /usr/local
  sudo cp -r cmake-$cmake_version-Linux-x86_64/* /usr
  cd ..
  rm -rf ~/cmake_tmp
  #CMAKE_URL="http://www.cmake.org/files/v3.3/cmake-3.3.1-Linux-x86_64.tar.gz"
  #mkdir cmake && travis_retry wget --quiet -O - ${CMAKE_URL} | tar --strip-components=1 -xz -C cmake
  #export PATH=${DEPS_DIR}/cmake/bin:${PATH}
  
#Download and install Boost
#elif [[ ${TRAVIS_OS_NAME} == "linux" && ${BOOST_VERSION} != "default" ]]
#then
  # if [ ! -f "${DEPS_DIR}/boost/${Boost_VERSION}_cached" ]
#   then
#     # create dirs for source and install
#     mkdir -p ${DEPS_DIR}/boost${Boost_VERSION}
#     mkdir -p ${DEPS_DIR}/boost
#     rm -rf ${DEPS_DIR}/boost/*
#     # download
#     #travis_retry wget --no-check-certificate --quiet -O - ${BOOST_URL} | tar --strip-components=1 -xz -C ${DEPS_DIR}/boost${Boost_VERSION}
#     #travis_retry wget --no-check-certificate -O - ${BOOST_URL} | tar --strip-components=1 -xz -C ${DEPS_DIR}/boost${Boost_VERSION}
#     travis_retry wget --no-check-certificate -O - ${BOOST_URL} | tar --bzip2 -xf ${DEPS_DIR}/boost${Boost_VERSION}
#     pushd ${DEPS_DIR}/boost${Boost_VERSION}
#     # configure and install
#     echo "using gcc : 4.8 : g++-4.8 ;" > $HOME/user-config.jam
#     ./bootstrap.sh --prefix=${DEPS_DIR}/boost/ --with-libraries=test
#     #./b2 -d0 install
#     ./b2 link=static install
#     popd
#     touch ${DEPS_DIR}/boost/${Boost_VERSION}_cached
#   else
#     echo 'Using cached Boost ${Boost_VERSION} libraries.'
#   fi
#     export CMAKE_OPTIONS=${CMAKE_OPTIONS}" -DBOOST_ROOT=${DEPS_DIR}/boost"
#     
#     #export BOOST_ROOT=${DEPS_DIR}/boost
#     export BOOST_ROOT={DEPS_DIR}/boost/bin
#     
#     #export BOOST_ROOT="/opt/boost/boost_1_57_0"
# 	export BOOST_INCLUDEDIR="${DEPS_DIR}/boost/include"
# 	export BOOST_LIBDIR="${DEPS_DIR}/boost${Boost_VERSION}/lib"
  #BOOST_VERSION="1.60.0"
  #echo "BOOST_VERSION:$BOOST_VERSION"

  BOOST_UNDERSCORE_VERSION=${BOOST_VERSION//./_}
  #echo "BOOST_UNDERSCORE_VERSION:$BOOST_UNDERSCORE_VERSION"

  #mkdir deps
  #DEPS_DIR=deps
  pushd $DEPS_DIR

  mkdir boost
  pushd boost

  BOOST_URL="http://sourceforge.net/projects/boost/files/boost/$BOOST_VERSION/boost_$BOOST_UNDERSCORE_VERSION.tar.bz2"
  #echo "BOOST_URL:$BOOST_URL"

  wget $BOOST_URL

  tar --bzip2 -xf "boost_$BOOST_UNDERSCORE_VERSION.tar.bz2"
  echo "boost archive extracted"

  pushd boost_${BOOST_UNDERSCORE_VERSION}

  ./bootstrap.sh --prefix=../ --with-libraries=test
  ./b2 -d0 link=static threading=multi install

  popd
  popd
  popd
  
  # Boost_INCLUDE_DIR="${DEPS_DIR}/boost/include"
#   Boost_LIBRARY_DIR="${DEPS_DIR}/boost/lib"
#   
#   export CMAKE_LIBRARY_PATH="$Boost_LIBRARY_DIR:$CMAKE_LIBRARY_PATH"
#   export CMAKE_INCLUDE_PATH="$Boost_INCLUDE_DIR:$CMAKE_INCLUDE_PATH"

  #export BOOST_ROOT="${DEPS_DIR}/boost"
#   export Boost_INCLUDEDIR="${DEPS_DIR}/boost/include/boost"
#   export Boost_LIBRARY_DIRS="${DEPS_DIR}/boost/lib"

fi