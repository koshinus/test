cmake_minimum_required(VERSION 3.1.0)

project(Test VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(CMAKE_VERSION VERSION_LESS "3.7.0")
    set(CMAKE_INCLUDE_CURRENT_DIR ON)
endif()

set(CMAKE_BINARY_DIR ${CMAKE_CURRENT_SOURCE_DIR}/bin)
set(CPP20_CMAKE_SUPPORT ${CMAKE_CURRENT_SOURCE_DIR}/cpp20_cmake_support/Cpp20SupportFuncs.cmake)

include(${CPP20_CMAKE_SUPPORT})

set(MOD_HEADERS_LIST iostream)
set(MOD1_SOURCES modules/test1.cpp)
set(MOD2_SOURCES modules/test2.cpp)
set(MOD2_DEPS mod1)
set(MODULES_LIST "mod1" "mod2")

prepare_system_header(${MOD_HEADERS_LIST})
make_cpp_module(mod1 ${MOD1_SOURCES})
make_cpp_module(mod2 ${MOD2_SOURCES})
add_module_dependencies(mod2 "${MOD2_DEPS}")
build_app_from_modules(${PROJECT_NAME} "modules/test_main.cpp" "${MODULES_LIST}")

