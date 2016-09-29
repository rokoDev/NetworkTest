cmake_minimum_required(VERSION ${cmake_version})

project(${LibName} 
		VERSION 0.0.0.1
		LANGUAGES CXX)
		
## Git (and its revision)
find_package(Git QUIET) # if we don't find git or FindGit.cmake is not on the system we ignore it.
## GetGitRevisionDescription module to retreive branch and revision information from Git
## Starting with Git 1.9 the module will be part of official cMake distribution, until then it has to be
## part of the application
## The Git module will trigger a reconfiguration for each pull that will bring a new revision on the local repository
set (VCS_REVISION "-1")
if(GIT_FOUND)
    include(GetGitRevisionDescription)
    get_git_head_revision(GIT_REFSPEC GIT_SHA1)
    message(STATUS "GIT branch ${GIT_REFSPEC}")
    message(STATUS "GIT revision ${GIT_SHA1}")
    set (VCS_REVISION ${GIT_SHA1})
endif()

#[[
get_cmake_property(_variableNames VARIABLES)
foreach (_variableName ${_variableNames})
    message(STATUS "${_variableName}=${${_variableName}}")
endforeach()
]]

include_directories("${LIB_HEADERS}")

set(LIB_INSTALL_PATH ${CMAKE_SOURCE_DIR}/installed/lib)

set(HEADERS_INSTALL_PATH ${CMAKE_SOURCE_DIR}/installed/headers)

configure_file(config.cpp.in config.cpp)

set(SOURCES
			Rectangle.cpp
			${CMAKE_CURRENT_BINARY_DIR}/config.cpp
			)

ADD_LIBRARY(${LibName}_objects OBJECT ${SOURCES})


#add_library(${LibName} STATIC ${SOURCES})
add_library(${LibName} STATIC $<TARGET_OBJECTS:${LibName}_objects>)

set_target_properties( ${LibName} PROPERTIES 
						VERSION ${MAJOR_VERSION} 
						SOVERSION ${MINOR_VERSION} )

install(TARGETS ${LibName} DESTINATION ${LIB_INSTALL_PATH})

install(DIRECTORY ${LIB_HEADERS}/
	DESTINATION ${HEADERS_INSTALL_PATH}
	FILES_MATCHING
	PATTERN "*.h"
	PATTERN "*.hpp"
)
