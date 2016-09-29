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
set(Boost_NO_SYSTEM_PATHS		ON)
set(Boost_NO_BOOST_CMAKE		ON)

find_package(Boost COMPONENTS unit_test_framework REQUIRED)

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
