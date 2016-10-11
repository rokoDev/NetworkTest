set(cmake_version 3.6.1)

cmake_minimum_required(VERSION ${cmake_version})

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake_modules)

set(LibName "SimpleNet")

project(${LibName} 
		VERSION 1.0.0.0
		LANGUAGES CXX)
		
message(STATUS "cur c++ compiler is:${CMAKE_CXX_COMPILER}")

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

set(LIB_HEADERS ${CMAKE_SOURCE_DIR}/include/${LibName})

add_subdirectory(src)
add_subdirectory(tests)
