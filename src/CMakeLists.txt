# указываем минимальную версию cmake (если версия cmake страше, то произойдет аварийный выход)
cmake_minimum_required(VERSION 3.0.2) #3.6.1

# даем нашей библиотеке имя и указываем список используемых языков программирования
# также эта команда устанавливает значение PROJECT_SOURCE_DIR в переменной <PROJECT-NAME>_SOURCE_DIR
# а также PROJECT_BINARY_DIR в переменной <PROJECT-NAME>_BINARY_DIR
# также между именем проекта и списком языков можно указать версию проекта
# значения PROJECT_VERSION, PROJECT_VERSION_MAJOR, PROJECT_VERSION_MINOR, PROJECT_VERSION_PATCH и PROJECT_VERSION_TWEAK
# можно прочесть в переменных <PROJECT-NAME>_VERSION, <PROJECT-NAME>_VERSION_MAJOR, <PROJECT-NAME>_VERSION_MINOR,
# <PROJECT-NAME>_VERSION_PATCH и <PROJECT-NAME>_VERSION_TWEAK соответственно
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

# вывод всех переменных CMAKE и их значений
#[[
get_cmake_property(_variableNames VARIABLES)
foreach (_variableName ${_variableNames})
    message(STATUS "${_variableName}=${${_variableName}}")
endforeach()
]]

# присоединяем пути для поиска заголовочных файлов в конец списка путей по умолчанию
# также есть возможность явно указать куда присоединить эти пути в начало или в конец
# для этого используются слова AFTER или BEFORE (смотри справку по cmake)
include_directories("${LIB_HEADERS}")

# указываем путь куда установится библиотека
set(LIB_INSTALL_PATH ${CMAKE_SOURCE_DIR}/installed/lib)

# указываем путь куда установятся заголовочные файлы
set(HEADERS_INSTALL_PATH ${CMAKE_SOURCE_DIR}/installed/headers)

# создаем файл с версией библиотеки
configure_file(config.cpp.in config.cpp)

# создаю список исходников
set(SOURCES
			Rectangle.cpp
			${CMAKE_CURRENT_BINARY_DIR}/config.cpp
			)

# создаю объектные файлы чтобы потом не пересоздавать их когда буду собирать библиотеку и исполнительный файл для тестов
ADD_LIBRARY(${LibName}_objects OBJECT ${SOURCES})


# собираем библиотеку (если надо создать исполняемый файл, то надо вызвать 'add_executable')
#add_library(${LibName} STATIC ${SOURCES})
add_library(${LibName} STATIC $<TARGET_OBJECTS:${LibName}_objects>)

# создаем символические ссылки.
# Это действие будет активировано при выполнении команды ‘make install’
set_target_properties( ${LibName} PROPERTIES 
						VERSION ${MAJOR_VERSION} 
						SOVERSION ${MINOR_VERSION} )

# установка. Это действие будет активировано при выполнении команды ‘make install’
install(TARGETS ${LibName} DESTINATION ${LIB_INSTALL_PATH})

# копируем заголовочные файлы из папки ${LIB_HEADERS} в папку ${HEADERS_INSTALL_PATH}
install(DIRECTORY ${LIB_HEADERS}/
	DESTINATION ${HEADERS_INSTALL_PATH}
	FILES_MATCHING
	PATTERN "*.h"
	PATTERN "*.hpp"
)
