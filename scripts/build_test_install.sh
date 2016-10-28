#! /bin/bash

rm -rf build installed deps

cmake -E make_directory build
cd build

#export CC=/usr/local/gcc-6.2.0/bin/gcc-6.2.0
export CXX=/usr/local/gcc-6.2.0/bin/g++-6.2.0
#export LD=/usr/local/gcc-6.2.0/bin/gcc-6.2.0
cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_DOCUMENTATION=ON .. #-DCMAKE_CXX_COMPILER=${COMPILER} -DBUILD_DOCS=ON ..
cmake --build .
#make doc

cd tests
ctest -VV
if [ $? -eq 0 ]
then
	cd ..
	make install
fi