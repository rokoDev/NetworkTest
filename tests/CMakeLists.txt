# запуск тестов
# 1. открываем окно терминала и переходим в папку проекта >> cd this_project_folder
# 2. создаем папку build >> mkdir build
# 3. переходим в созданную папку build >> cd build
# 4. запускаем команду для конфигурации проекта >> cmake -DBOOST_ROOT=$boost_installation_prefix ..
# 5. запускаем команду сборки проекта >> cmake --build .
# 6. переходим в папку tests >> cd tests
# 7. запускаем тесты >> ctest -V

# указываем минимальную версию cmake (если версия cmake страше, то произойдет аварийный выход)
cmake_minimum_required(VERSION 3.6.1)

project(${LibName}_test)

enable_testing()

# replace XX with the version you have
set(Boost_ADDITIONAL_VERSIONS "1.60" "1.60.0")

# finds boost, triggers an error otherwise
find_package(Boost 1.60 REQUIRED COMPONENTS unit_test_framework)

#set(HEADERS ${CMAKE_SOURCE_DIR}/include/${LibName})

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
target_include_directories(test_executable PRIVATE ${Boost_INCLUDE_DIRS})

# indicates the link paths
target_link_libraries(test_executable 
										${Boost_UNIT_TEST_FRAMEWORK_LIBRARY}
										${LibName}
										)

# declares a test with our executable
add_test(NAME test1 COMMAND test_executable)
