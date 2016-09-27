#ADD_LIBRARY(boost_unit_test_framework SHARED IMPORTED)
#SET_TARGET_PROPERTIES(boost_unit_test_framework PROPERTIES
#    IMPORTED_LOCATION $ENV{BOOST_ROOT}/lib/libboost_unit_test_framework.so) #libboost_unit_test_framework-gcc48-mt-s-1_60.a)


cmake_minimum_required(VERSION 3.6.1)

project(${LibName}_test)

set(Boost_DEBUG 1)

#set(CMAKE_INCLUDE_PATH ${CMAKE_INCLUDE_PATH} $ENV{BOOST_ROOT})
#set(CMAKE_LIBRARY_PATH ${CMAKE_LIBRARY_PATH} $ENV{BOOST_ROOT}/lib)
#set(BOOST_ROOT $ENV{BOOST_ROOT})
message(STATUS "BOOST_ROOT >> ${BOOST_ROOT}")

enable_testing()

#include_directories("${LIB_HEADERS}")

#set(Boost_INCLUDE_DIR $ENV{BOOST_ROOT}/include)
#set(Boost_LIBRARY_DIRS $ENV{BOOST_ROOT}/lib)

#set(Boost_INCLUDE_DIR /home/travis/build/rokoDev/NetworkTest/deps/boost/include)

message(STATUS "Boost_INCLUDE_DIR0 >> ${Boost_INCLUDE_DIR}")
message(STATUS "Boost_LIBRARY_DIRS0 >> ${Boost_LIBRARY_DIRS}")

set( Boost_USE_STATIC_LIBS        OFF )
	set( Boost_USE_MULTITHREADED      ON )
	set( Boost_USE_STATIC_RUNTIME     OFF )
	set( BOOST_ALL_DYN_LINK           ON ) # force dynamic linking for all libraries

find_package(Boost COMPONENTS unit_test_framework REQUIRED)

message(STATUS "Boost_INCLUDE_DIR >> ${Boost_INCLUDE_DIR}")
message(STATUS "Boost_LIBRARY_DIRS >> ${Boost_LIBRARY_DIRS}")

if(Boost_FOUND)
    include_directories(${Boost_INCLUDE_DIR})
	link_directories(${Boost_LIBRARY_DIRS})
	

	add_executable(test_executable
								main.cpp
								SomeClass_test.cpp
								)
								
	target_link_libraries(test_executable
										${Boost_UNIT_TEST_FRAMEWORK_LIBRARY}
										${LibName}
										)
										
	add_test(NAME test1 COMMAND test_executable)
else()
	message(STATUS "No Boost library were found!")
endif()
