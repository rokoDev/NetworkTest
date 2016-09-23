#! /bin/bash

rm -rf build installed

cmake -E make_directory build
cd build

cmake .. #-DBOOST_ROOT=$boost_installation_prefix ..
cmake --build .

cd tests
ctest -VV
if [ $? -eq 0 ]
then
	cd ..
	make install
fi