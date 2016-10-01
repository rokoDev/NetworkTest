cmake_minimum_required(VERSION ${cmake_version})

project(${LibName}_test)

set(Boost_DEBUG ON)
set(Boost_DETAILED_FAILURE_MSG ON)

set(BOOST_ROOT $ENV{BOOST_ROOT})
set(BOOST_LIBRARYDIR $ENV{BOOST_ROOT}/lib)
set(BOOST_INCLUDEDIR $ENV{BOOST_ROOT}/include)
message(STATUS "BOOST_ROOT >> ${BOOST_ROOT}")

#set(Boost_COMPILER "-gcc48")

enable_testing()

set(Boost_USE_STATIC_LIBS		OFF)
set(Boost_USE_MULTITHREADED		ON)

set(CMAKE_INCLUDE_PATH ${CMAKE_INCLUDE_PATH} "$ENV{BOOST_ROOT}/include")
set(CMAKE_LIBRARY_PATH ${CMAKE_LIBRARY_PATH} "$ENV{BOOST_ROOT}/lib")

message(STATUS "c++ compiler id: ${CMAKE_CXX_COMPILER_ID}")

#set_target_properties(Boost_unit_test_framework PROPERTIES
#                          IMPORTED_LOCATION libboost_unit_test_framework-mt.so
#                          LINKER_LANGUAGE CXX)
                          
#set_target_properties(boost_test Boost_unit_test_framework PROPERTIES
#                        LABELS Boost FOLDER "Third Party/Boost" EXCLUDE_FROM_ALL TRUE)
#add_dependencies(Boost_unit_test_framework boost_test)

#find_package(Boost 1.60.0 EXACT REQUIRED COMPONENTS unit_test_framework)

    include_directories(${LIB_HEADERS} $ENV{BOOST_ROOT}/include)
    
	#link_directories($ENV{BOOST_ROOT}/lib)
	
	add_library(boost_unit_test_framework SHARED IMPORTED GLOBAL)
	
	set_property(TARGET boost_unit_test_framework PROPERTY IMPORTED_LOCATION $ENV{BOOST_ROOT}/lib/libboost_unit_test_framework-mt.so)
             
    #target_include_directories(test_executable PRIVATE $ENV{BOOST_ROOT}/include)

	add_executable(test_executable
								main.cpp
								SomeClass_test.cpp
								)
								
	#target_include_directories(test_executable PRIVATE $ENV{BOOST_ROOT}/include)
								
	target_link_libraries(test_executable
						boost_unit_test_framework
						${LibName}
	)
								
	#target_include_directories(test_executable PRIVATE $ENV{BOOST_ROOT}/include)
										
	add_test(NAME test1 COMMAND test_executable)
