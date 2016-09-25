# запуск тестов
# 1. открываем окно терминала и переходим в папку проекта >> cd this_project_folder
# 2. создаем папку build >> mkdir build
# 3. переходим в созданную папку build >> cd build
# 4. запускаем команду для конфигурации проекта >> cmake -DBOOST_ROOT=$boost_installation_prefix ..
# 5. запускаем команду сборки проекта >> cmake --build .
# 6. переходим в папку tests >> cd tests
# 7. запускаем тесты >> ctest -V

# указываем минимальную версию cmake (если версия cmake страше, то произойдет аварийный выход)
cmake_minimum_required(VERSION ${cmake_version})

project(${LibName}_test)

set(Boost_DEBUG 1)

set(BOOST_INCLUDEDIR $ENV{BOOST_ROOT}/include/boost-1_60)
set(BOOST_LIBRARYDIR $ENV{BOOST_ROOT}/lib)
set(BOOST_ROOT $ENV{BOOST_ROOT})

#set(Boost_USE_STATIC_LIBS   ON)
#set(Boost_USE_MULTITHREADED ON)

set(CMAKE_INCLUDE_PATH ${CMAKE_INCLUDE_PATH} $ENV{BOOST_ROOT}/include/boost-1_60)
set(CMAKE_LIBRARY_PATH ${CMAKE_LIBRARY_PATH} $ENV{BOOST_ROOT}/lib)

enable_testing()

# replace XX with the version you have
#set(Boost_ADDITIONAL_VERSIONS "1_60")

#USE_STATIC_BOOST

ADD_LIBRARY(boost_unit_test_framework STATIC IMPORTED)
SET_TARGET_PROPERTIES(boost_unit_test_framework PROPERTIES
    IMPORTED_LOCATION $ENV{BOOST_ROOT}/lib/libboost_unit_test_framework-gcc48-mt-1_60.so) #libboost_unit_test_framework-gcc48-mt-s-1_60.a)

#set(Boost_NO_SYSTEM_PATHS TRUE) 
#if (Boost_NO_SYSTEM_PATHS)
#  set(BOOST_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/../../3p/boost")
#  set(BOOST_INCLUDE_DIRS "${BOOST_ROOT}/include")
#  set(BOOST_LIBRARY_DIRS "${BOOST_ROOT}/lib")
#endif (Boost_NO_SYSTEM_PATHS)
#find_package(Boost REQUIRED regex date_time system filesystem thread graph program_options)
#include_directories(${BOOST_INCLUDE_DIRS})

#list(APPEND Boost_LIBRARIES $ENV{BOOST_ROOT}/lib)
list(APPEND Boost_INCLUDE_DIR $ENV{BOOST_ROOT}/include/boost-1_60)

message(STATUS "boost_root_dir   :${BOOST_ROOT}")
message(STATUS "boost_include_dir:${BOOST_INCLUDEDIR}")
message(STATUS "boost_lib_dir    :${BOOST_LIBRARYDIR}")

# finds boost, triggers an error otherwise
#find_package(Boost 1.60.0 REQUIRED COMPONENTS unit_test_framework)

#set(HEADERS ${CMAKE_SOURCE_DIR}/include/${LibName})

# присоединяем пути для поиска заголовочных файлов в конец списка путей по умолчанию
# также есть возможность явно указать куда присоединить эти пути в начало или в конец
# для этого используются слова AFTER или BEFORE (смотри справку по cmake)
include_directories(BEFORE ${LIB_HEADERS} ${BOOST_INCLUDEDIR})

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
target_include_directories(test_executable PRIVATE ${BOOST_INCLUDEDIR}) #${Boost_INCLUDE_DIRS})
#target_include_directories(test_executable PRIVATE $ENV{BOOST_ROOT}/include/boost-1_60)

# indicates the link paths
target_link_libraries(test_executable 
										${boost_unit_test_framework} #${Boost_UNIT_TEST_FRAMEWORK_LIBRARY}
										${LibName}
										)

# declares a test with our executable
add_test(NAME test1 COMMAND test_executable)
