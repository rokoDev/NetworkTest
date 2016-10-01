cmake_minimum_required(VERSION ${cmake_version})

project(${LibName}_test)

set(Boost_DEBUG ON)
set(Boost_DETAILED_FAILURE_MSG ON)

set(BOOST_ROOT $ENV{BOOST_ROOT})
set(BOOST_LIBRARYDIR $ENV{BOOST_ROOT}/lib)
set(BOOST_INCLUDEDIR $ENV{BOOST_ROOT}/include)
message(STATUS "BOOST_ROOT >> ${BOOST_ROOT}")

enable_testing()

set(Boost_USE_STATIC_LIBS		OFF)
set(Boost_USE_MULTITHREADED		ON)
set(Boost_USE_STATIC_RUNTIME    OFF)

set(CMAKE_INCLUDE_PATH ${CMAKE_INCLUDE_PATH} "$ENV{BOOST_ROOT}/include")
set(CMAKE_LIBRARY_PATH ${CMAKE_LIBRARY_PATH} "$ENV{BOOST_ROOT}/lib")

find_package(Boost 1.60 COMPONENTS unit_test_framework)

if(Boost_FOUND)
  message(STATUS "BOOST FOUND :)")
  
  include_directories(${LIB_HEADERS} ${Boost_INCLUDE_DIRS})
  
  add_executable(test_executable
								main.cpp
								SomeClass_test.cpp
								)
								
  target_include_directories(test_executable PRIVATE ${Boost_INCLUDE_DIRS})
  
  target_link_libraries(test_executable
						boost_unit_test_framework
						${LibName}
	)

  add_test(NAME test1 COMMAND test_executable)
  
endif()

#message(STATUS "c++ compiler id: ${CMAKE_CXX_COMPILER_ID}")
#
#    include_directories(${LIB_HEADERS})
#	
#	add_library(boost_unit_test_framework SHARED IMPORTED GLOBAL)
#	
#	set_property(TARGET boost_unit_test_framework PROPERTY IMPORTED_LOCATION $ENV{BOOST_ROOT}/lib/libboost_unit_test_framework-mt.so)
#
#	add_executable(test_executable
#								main.cpp
#								SomeClass_test.cpp
#								)
#								
#	target_include_directories(test_executable PRIVATE $ENV{BOOST_ROOT}/include)
#								
#	target_link_libraries(test_executable
#						${Boost_UNIT_TEST_FRAMEWORK_LIBRARY}
#						${LibName}
#	)
#										
#	add_test(NAME test1 COMMAND test_executable)
