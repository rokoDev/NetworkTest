#! /bin/bash

rm -rf build installed

cmake -E make_directory build
cd build

cmake -DCMAKE_BUILD_TYPE=Release -DBOOST_ROOT=${BOOST_ROOT} -DCMAKE_C_COMPILER=gcc-5 -DCMAKE_CXX_COMPILER=${COMPILER} ..
cmake --build .

cd tests
ctest -VV
if [ $? -eq 0 ]
then
	cd ..
	make install
fi