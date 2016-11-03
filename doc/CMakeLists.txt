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
                    \"${PROJECT_SOURCE_DIR}/include\" \\ \
                    \"${PROJECT_SOURCE_DIR}/src\" \
                    ")
    message(STATUS "OUTPUT_DIR:${OUTPUT_DIR}")
    message(STATUS "INPUT_DIRS:${INPUT_DIRS}")
    message(STATUS "CMAKE_CURRENT_SOURCE_DIR:${CMAKE_CURRENT_SOURCE_DIR}")
    message(STATUS "PROJECT_SOURCE_DIR:${PROJECT_SOURCE_DIR}")
    message(STATUS "CMAKE_CURRENT_BINARY_DIR:${CMAKE_CURRENT_BINARY_DIR}")
    message(STATUS "CMAKE_MAKE_PROGRAM:${CMAKE_MAKE_PROGRAM}")

    #configure doxygen configuration file
    set(doxyfile_in ${PROJECT_SOURCE_DIR}/doc/Doxyfile.in)
    set(doxyfile ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile)
    configure_file(${doxyfile_in} ${doxyfile} @ONLY)

    #doc build only target
    add_custom_target(doc ALL
        COMMAND ${DOXYGEN_EXECUTABLE} ${doxyfile}
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        COMMENT "Generating API documentation with Doxygen"
        VERBATIM)

    #TODO where doc will be installed
#    install(
#        DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/doc/
#        DESTINATION ${CMAKE_CURRENT_SOURCE_DIR} #/installed/doc 
#        OPTIONAL)
endif()