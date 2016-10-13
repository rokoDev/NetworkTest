#! /bin/bash

rm -rf build installed deps

cmake -E make_directory build
cd build

#export CC=/usr/local/gcc-6.2.0/bin/gcc-6.2.0
#export CXX=/usr/local/gcc-6.2.0/bin/g++-6.2.0
#export LD=/usr/local/gcc-6.2.0/bin/gcc-6.2.0
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=${COMPILER} ..
cmake --build .

cd tests
ctest -VV
if [ $? -eq 0 ]
then
	cd ..
	make install
fi