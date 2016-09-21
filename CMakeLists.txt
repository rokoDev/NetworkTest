# указываем минимальную версию cmake (если версия cmake страше, то произойдет аварийный выход)
cmake_minimum_required(VERSION 3.6.1) #3.6.1

#устанавливаем путь к модулям cmake
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake_modules)

# создаем строковую переменную с наименованием библиотеки
set(LibName "SimpleNet")

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

# указываем что стандарт языка С++ должен быть 11-м и делаем это требование обязательным 
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# устанавливаем флаги для C++ компилятора
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

# список путей по которым лежат include-файлы
set(LIB_HEADERS ${CMAKE_SOURCE_DIR}/include/${LibName})

add_subdirectory(src)
add_subdirectory(tests)
