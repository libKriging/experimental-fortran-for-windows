cmake_minimum_required(VERSION 3.15)
project(cppexe CXX)

set(CPP_SRC main.cpp)

set(MAINFFPATH "${CMAKE_SOURCE_DIR}/../fortran/build/installed")
set(flib_DIR "${MAINFFPATH}/lib/cmake/flib")

find_package(flib CONFIG REQUIRED)
add_executable(cppexe ${CPP_SRC})
target_link_libraries(cppexe flib::flib)

enable_testing()
add_test(NAME cppexe COMMAND cppexe)