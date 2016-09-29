#ADD_LIBRARY(boost_unit_test_framework SHARED IMPORTED)
#SET_TARGET_PROPERTIES(boost_unit_test_framework PROPERTIES
#    IMPORTED_LOCATION $ENV{BOOST_ROOT}/lib/libboost_unit_test_framework.so) #libboost_unit_test_framework-gcc48-mt-s-1_60.a)


cmake_minimum_required(VERSION ${cmake_version})

project(${LibName}_test)

set(Boost_DEBUG ON)
set(Boost_DETAILED_FAILURE_MSG ON)

set(BOOST_ROOT $ENV{BOOST_ROOT})
message(STATUS "BOOST_ROOT >> ${BOOST_ROOT}")

enable_testing()

set(Boost_USE_STATIC_LIBS		OFF)
set(Boost_USE_MULTITHREADED		ON)

SET(CMAKE_INCLUDE_PATH ${CMAKE_INCLUDE_PATH} "$ENV{BOOST_ROOT}/include")
SET(CMAKE_LIBRARY_PATH ${CMAKE_LIBRARY_PATH} "$ENV{BOOST_ROOT}/lib")

find_package(Boost 1.60.0 EXACT COMPONENTS unit_test_framework)

if(Boost_FOUND)
    include_directories("${LIB_HEADERS}")
	

	add_executable(test_executable
								main.cpp
								SomeClass_test.cpp
								)
								
	target_include_directories(test_executable PRIVATE ${Boost_INCLUDE_DIRS})
								
	target_link_libraries(test_executable
										#${Boost_UNIT_TEST_FRAMEWORK_LIBRARY}
										Boost::unit_test_framework
										${LibName}
										)
										
	add_test(NAME test1 COMMAND test_executable)
else()
	message(STATUS "No Boost library were found!")
endif()
