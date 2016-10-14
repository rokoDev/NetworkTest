cmake_minimum_required(VERSION ${cmake_version})

project(${LibName}_test)

set(BoostVersion 1.60.0)

string(REGEX REPLACE "beta\\.([0-9])$" "beta\\1" BoostFolderName ${BoostVersion})
string(REPLACE "." "_" BoostFolderName ${BoostFolderName})
set(BoostFolderName boost_${BoostFolderName})

set(BoostDirPath "${CMAKE_SOURCE_DIR}/deps/boost")
file(MAKE_DIRECTORY ${BoostDirPath})

set(BoostBuildDirPath "${CMAKE_SOURCE_DIR}/deps/boost/BoostBuild")
file(MAKE_DIRECTORY ${BoostBuildDirPath})

set(BOOST_ROOT "${CMAKE_SOURCE_DIR}/deps/boost/installed")
file(MAKE_DIRECTORY ${BOOST_ROOT})

# Download boost if required
set(ZipFilePath "${BoostDirPath}/${BoostFolderName}.tar.bz2")
if(NOT EXISTS ${ZipFilePath})
  message(STATUS "Downloading boost ${BoostVersion} to ${BoostDirPath}")
endif()

message(STATUS "ZipFilePath >> ${ZipFilePath}")
file(DOWNLOAD http://sourceforge.net/projects/boost/files/boost/${BoostVersion}/${BoostFolderName}.tar.bz2
     ${ZipFilePath}
     STATUS Status
     SHOW_PROGRESS
     )
     
execute_process(COMMAND ${CMAKE_COMMAND} -E tar xf ${ZipFilePath}
                  WORKING_DIRECTORY ${BoostDirPath}
                  RESULT_VARIABLE Result
                  )
                  
file(REMOVE ${ZipFilePath})

#file(WRITE ${BoostDirPath}/${BoostFolderName}/tools/build/src/user-config.jam "using darwin : 6.2.0 : ${CMAKE_CXX_COMPILER} : ;")

set(bootstrap "./bootstrap.sh") #"${BoostDirPath}/${BoostFolderName}/tools/build/bootstrap.sh")

execute_process(COMMAND ${bootstrap} WORKING_DIRECTORY ${BoostDirPath}/${BoostFolderName}/tools/build
                  RESULT_VARIABLE Result OUTPUT_VARIABLE Output ERROR_VARIABLE Error)
if(NOT Result EQUAL "0")
  message(FATAL_ERROR "Failed running ${b2Bootstrap}:\n${Output}\n${Error}\n")
endif()

set(buildB2 ./b2
					install
					--prefix=${CMAKE_SOURCE_DIR}/deps/boost/BoostBuild
					)

execute_process(COMMAND ${buildB2} WORKING_DIRECTORY ${BoostDirPath}/${BoostFolderName}/tools/build
                  RESULT_VARIABLE Result)
if(NOT Result EQUAL "0")
  message(FATAL_ERROR "Failed running ${buildB2}")
endif()

message(STATUS "CMAKE_CXX_COMPILER_ID=${CMAKE_CXX_COMPILER_ID}")

set(b2Args ${CMAKE_SOURCE_DIR}/deps/boost/BoostBuild/bin/b2
		   --prefix=${BOOST_ROOT}
		   --build-dir=${BoostDirPath}/build
		   --with-test
		   --layout=tagged
		   -d0
		   #toolset=gcc-5 #clang
		   #address-model=64
           link=shared
           threading=multi
           variant=release
           runtime-link=shared
           install
           --ignore-site-config
           )

if(CMAKE_CXX_COMPILER_ID MATCHES "^(Apple)?Clang$")
  message(STATUS "this is Clang compiler")
  file(WRITE ${BoostDirPath}/${BoostFolderName}/tools/build/src/user-config.jam "using clang : : ${CMAKE_CXX_COMPILER} : ;")
  list(APPEND b2Args toolset=clang)
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  message(STATUS "this is GNU compiler")
  file(WRITE ${BoostDirPath}/${BoostFolderName}/tools/build/src/user-config.jam "using gcc : : ${CMAKE_CXX_COMPILER} : ;")
  list(APPEND b2Args toolset=gcc)
endif()

file(MAKE_DIRECTORY ${BoostDirPath}/build)
           
execute_process(COMMAND ${b2Args} WORKING_DIRECTORY ${BoostDirPath}/${BoostFolderName}
                  RESULT_VARIABLE Result)
if(NOT Result EQUAL "0")
  message(FATAL_ERROR "Failed running ${b2Args}")
endif()

set(Boost_DEBUG ON)
set(Boost_DETAILED_FAILURE_MSG ON)

message(STATUS "BOOST_ROOT >> ${BOOST_ROOT}")

enable_testing()

set(Boost_USE_STATIC_LIBS		OFF)
set(Boost_USE_MULTITHREADED		ON)
set(Boost_USE_STATIC_RUNTIME    OFF)

set(Boost_NO_SYSTEM_PATHS ON)

find_package(Boost ${BoostVersion} EXACT COMPONENTS unit_test_framework)

if(Boost_FOUND)
  message(STATUS "BOOST FOUND :)")
  
  include_directories(${LIB_HEADERS} ${Boost_INCLUDE_DIRS})
  
  add_executable(test_executable
								main.cpp
								SomeClass_test.cpp
								)
								
  #target_include_directories(test_executable PRIVATE ${Boost_INCLUDE_DIRS})
  
  target_link_libraries(test_executable
						${Boost_UNIT_TEST_FRAMEWORK_LIBRARY}
						${LibName}
	)

  add_test(NAME test1 COMMAND test_executable)
  
endif()
