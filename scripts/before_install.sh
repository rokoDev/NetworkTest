#! /bin/bash

cmake_version_id="3.6"
cmake_version="3.6.1"
if [ $TRAVIS_OS_NAME = osx ]
then
	#brew update
    #brew outdated cmake || brew upgrade cmake
    #brew outdated boost || brew upgrade boost
    
    #find /Applications -maxdepth 1 -name "CMake*" -print
    #sudo rm /usr/bin/ccmake /usr/bin/cmake /usr/bin/cmake-gui /usr/bin/cmakexbuild /usr/bin/cpack /usr/bin/ctest
    
    mkdir ~/cmake_tmp
    cd ~/cmake_tmp
    CMAKE_URL="https://cmake.org/files/v${cmake_version_id}/cmake-$cmake_version-Darwin-x86_64.tar.gz"
    wget $CMAKE_URL
    tar xf cmake-$cmake_version-Darwin-x86_64.tar.gz
    #sudo cp -R "cmake-$cmake_version-Darwin-x86_64/" "/usr/local/bin"
    CMAKE_PATH=$(pwd)/cmake-$cmake_version-Darwin-x86_64
    echo "CMAKE_PATH=${CMAKE_PATH}"
    sudo ${CMAKE_PATH}/CMake.app/Contents/bin/cmake-gui --install #=/usr/local/bin
    cd ..
    rm -rf ~/cmake_tmp
elif [ $TRAVIS_OS_NAME = linux ]
then
  #install cmake--------------------------------------------------------------------
  mkdir ~/cmake_tmp
  cd ~/cmake_tmp
  CMAKE_URL="https://cmake.org/files/v${cmake_version_id}/cmake-$cmake_version-Linux-x86_64.tar.gz"
  wget $CMAKE_URL
  tar xf cmake-$cmake_version-Linux-x86_64.tar.gz
  #sudo cp -r cmake-$cmake_version-Linux-x86_64/* /usr/local
  sudo cp -r cmake-$cmake_version-Linux-x86_64/* /usr
  cd ..
  rm -rf ~/cmake_tmp

fi