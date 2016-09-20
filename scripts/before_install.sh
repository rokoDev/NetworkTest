#! /bin/bash

if [ $TRAVIS_OS_NAME = osx ]
then
	brew update
    brew outdated cmake || brew upgrade cmake
    brew outdated boost || brew upgrade boost;
fi;