# указываем минимальную версию cmake (если версия cmake страше, то произойдет аварийный выход)
cmake_minimum_required(VERSION 3.0.2) #3.6.1

# создаем строковую переменную
set(LibName "SimpleNet")
set(LibName ${LibName} PARENT_SCOPE)

# даем нашей библиотеке имя и указываем список используемых языков программирования
# также эта команда устанавливает значение PROJECT_SOURCE_DIR в переменной <PROJECT-NAME>_SOURCE_DIR
# а также PROJECT_BINARY_DIR в переменной <PROJECT-NAME>_BINARY_DIR
# также между именем проекта и списком языков можно указать версию проекта
# значения PROJECT_VERSION, PROJECT_VERSION_MAJOR, PROJECT_VERSION_MINOR, PROJECT_VERSION_PATCH и PROJECT_VERSION_TWEAK
# можно прочесть в переменных <PROJECT-NAME>_VERSION, <PROJECT-NAME>_VERSION_MAJOR, <PROJECT-NAME>_VERSION_MINOR,
# <PROJECT-NAME>_VERSION_PATCH и <PROJECT-NAME>_VERSION_TWEAK соответственно
project(${LibName} 
		VERSION 1.0.0.0
		LANGUAGES CXX)



# вывод всех переменных CMAKE и их значений
#[[
get_cmake_property(_variableNames VARIABLES)
foreach (_variableName ${_variableNames})
    message(STATUS "${_variableName}=${${_variableName}}")
endforeach()
]]

set(LIB_HEADERS ${CMAKE_SOURCE_DIR}/include/${LibName})
set(LIB_HEADERS ${LIB_HEADERS} PARENT_SCOPE)

# присоединяем пути для поиска заголовочных файлов в конец списка путей по умолчанию
# также есть возможность явно указать куда присоединить эти пути в начало или в конец
# для этого используются слова AFTER или BEFORE (смотри справку по cmake)
include_directories("${LIB_HEADERS}")

# указываем путь куда установится библиотека
set(LIB_INSTALL_PATH ${CMAKE_SOURCE_DIR}/installed/lib)

# указываем путь куда установятся заголовочные файлы
set(HEADERS_INSTALL_PATH ${CMAKE_SOURCE_DIR}/installed/headers)

# создаю список исходников
set(SOURCES
			Rectangle.cpp
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
