# указываем минимальную версию cmake (если версия cmake страше, то произойдет аварийный выход)
cmake_minimum_required(VERSION 3.0.2)

# cmake_policy(SET CMP0048 NEW)

# указываем что стандарт языка С++ должен быть 11-м и делаем это требование обязательным 
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# устанавливаем флаги для C++ компилятора
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

add_subdirectory(src)
add_subdirectory(tests)
