#ADD_LIBRARY(boost_unit_test_framework SHARED IMPORTED)
#SET_TARGET_PROPERTIES(boost_unit_test_framework PROPERTIES
#    IMPORTED_LOCATION $ENV{BOOST_ROOT}/lib/libboost_unit_test_framework.so) #libboost_unit_test_framework-gcc48-mt-s-1_60.a)


# запуск тестов
# 1. открываем окно терминала и переходим в папку проекта >> cd this_project_folder
# 2. создаем папку build >> mkdir build
# 3. переходим в созданную папку build >> cd build
# 4. запускаем команду для конфигурации проекта >> cmake -DBOOST_ROOT=$boost_installation_prefix ..
# 5. запускаем команду сборки проекта >> cmake --build .
# 6. переходим в папку tests >> cd tests
# 7. запускаем тесты >> ctest -V

# указываем минимальную версию cmake (если версия cmake страше, то произойдет аварийный выход)
cmake_minimum_required(VERSION 3.6.1) #3.6.1

project(${LibName}_test)

set(Boost_DEBUG 1)

#set(BOOST_INCLUDEDIR $ENV{BOOST_ROOT}/include)
#set(BOOST_LIBRARYDIR $ENV{BOOST_ROOT}/lib)
#set(BOOST_ROOT $ENV{BOOST_ROOT})

#set(Boost_USE_STATIC_LIBS   ON)
#set(Boost_USE_MULTITHREADED ON)

set(CMAKE_INCLUDE_PATH ${CMAKE_INCLUDE_PATH} $ENV{BOOST_ROOT})
set(CMAKE_LIBRARY_PATH ${CMAKE_LIBRARY_PATH} $ENV{BOOST_ROOT}/lib)

#set(Boost_INCLUDE_DIR ${BOOST_INCLUDEDIR})

enable_testing()

# replace XX with the version you have
#set(Boost_ADDITIONAL_VERSIONS "1.60" "1.60.0")

# finds boost, triggers an error otherwise
#find_package(Boost 1.60 REQUIRED COMPONENTS unit_test_framework)

# присоединяем пути для поиска заголовочных файлов в конец списка путей по умолчанию
# также есть возможность явно указать куда присоединить эти пути в начало или в конец
# для этого используются слова AFTER или BEFORE (смотри справку по cmake)
include_directories("${LIB_HEADERS}")

#[[
get_cmake_property(_variableNames VARIABLES)
foreach (_variableName ${_variableNames})
    message(STATUS "${_variableName}=${${_variableName}}")
endforeach()
]]

# creates the executable
add_executable(test_executable
	main.cpp
	SomeClass_test.cpp
)

# indicates the include paths
#target_include_directories(test_executable PRIVATE ${Boost_INCLUDE_DIRS})

FIND_PACKAGE(Boost)
IF (Boost_FOUND)
	message(STATUS "boost found!!!!!")
    INCLUDE_DIRECTORIES(${Boost_INCLUDE_DIR})
    ADD_DEFINITIONS( "-DHAS_BOOST" )
ENDIF()

# indicates the link paths
target_link_libraries(test_executable 
										${Boost_UNIT_TEST_FRAMEWORK_LIBRARY}
										${LibName}
										)

# declares a test with our executable
add_test(NAME test1 COMMAND test_executable)
