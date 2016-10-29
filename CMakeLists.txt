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

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

set(LIB_HEADERS ${CMAKE_SOURCE_DIR}/include/${LibName})

enable_testing() #must be in root(top) CMakeLists.txt to avoid "No tests were found" message on Appveyor ci

# enable if doxygen found
find_package(Doxygen)
option(BUILD_DOCUMENTATION "Create and install the HTML based API documentation (requires Doxygen)" ${DOXYGEN_FOUND})
if(DOXYGEN_VERSION VERSION_LESS "1.8.0")
    message(WARNING "Doxygen version " ${DOXYGEN_VERSION} " is older than 1.8.0, disabling documentation build")
    set(BUILD_DOCUMENTATION FALSE)
endif()

if(BUILD_DOCUMENTATION)
    if(NOT DOXYGEN_FOUND)
        message(FATAL_ERROR "Doxygen is needed to build the documentation.")
    endif()
    
    set(BRIEF_DESCRIPTION "This is a library to transmit data over the internet.")
    set(OUTPUT_DIR ${CMAKE_CURRENT_BINARY_DIR}/doc)
    set(INPUT_DIRS "\
                    \"${CMAKE_CURRENT_SOURCE_DIR}/include\" \\ \
                    \"${CMAKE_CURRENT_SOURCE_DIR}/src\" \
                    ")
    message(STATUS "OUTPUT_DIR:${OUTPUT_DIR}")
    message(STATUS "INPUT_DIRS:${INPUT_DIRS}")
    message(STATUS "CMAKE_CURRENT_BINARY_DIR:${CMAKE_CURRENT_BINARY_DIR}")

    #configure doxygen configuration file
    set(doxyfile_in ${CMAKE_CURRENT_SOURCE_DIR}/doc/Doxyfile.in)
    set(doxyfile ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile)
    configure_file(${doxyfile_in} ${doxyfile} @ONLY)

    #doc build only target
    add_custom_target(doc ALL
        COMMAND ${DOXYGEN_EXECUTABLE} ${doxyfile}
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        COMMENT "Generating API documentation with Doxygen"
        VERBATIM)
        
    add_custom_command(TARGET doc
 	  POST_BUILD
 	  COMMAND "${CMAKE_MAKE_PROGRAM}"
 	  COMMENT	"Running LaTeX for Doxygen documentation in ${OUTPUT_DIR}/latex..."
 	  WORKING_DIRECTORY "${OUTPUT_DIR}/latex")

    #TODO where doc will be installed
    install(
        DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/doc/
        DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/doc 
        OPTIONAL)
endif()

add_subdirectory(src)
add_subdirectory(tests)
