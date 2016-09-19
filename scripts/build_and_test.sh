#!/bin/bash

rm -rf build installed

cmake -E make_directory build #mkdir build
cd build

cmake -DBOOST_ROOT=$boost_installation_prefix ..
cmake --build .

cd tests
ctest -VV

#cd ..
#make install