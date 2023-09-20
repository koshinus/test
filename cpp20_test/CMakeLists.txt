cmake_minimum_required(VERSION 3.1.0)

project(Test VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

if(CMAKE_VERSION VERSION_LESS "3.7.0")
    set(CMAKE_INCLUDE_CURRENT_DIR ON)
endif()

#set(CMAKE_BUILD_PATH "${CMAKE_CURRENT_SOURCE_DIR}/bin")
set(CMAKE_BINARY_DIR ${CMAKE_CURRENT_SOURCE_DIR}/bin)
set(CPP20_CMAKE_SUPPORT ${CMAKE_CURRENT_SOURCE_DIR}/cpp20_cmake_support/Cpp20SupportFuncs.cmake)

#find_package(${CMAKE_CURRENT_SOURCE_DIR}/cpp20_cmake_support/Cpp20SupportFuncs REQUIRED)
include(${CPP20_CMAKE_SUPPORT})


#function(prepare_system_header _HEADERS_LIST)
#function(make_cpp_module _CPP_MODULE_NAME _CPP_MODULE_FILES)
#function(add_module_dependencies _CPP_MODULE_NAME _CPP_MODULES_LIST)
#function(build_app_from_modules _APP_NAME _CPP_MODULES_LIST)


message("${CMAKE_BINARY_DIR} ${CMAKE_CURRENT_SOURCE_DIR}")

set(MOD_HEADERS_LIST iostream)
set(MOD2_SOURCES modules/test1_1.cpp)
set(MOD1_SOURCES modules/test1.cpp)
set(MOD1_DEPS mod2)
set(MODULES_LIST mod1 mod2)
prepare_system_header(${MOD_HEADERS_LIST})
make_cpp_module(mod2 ${MOD2_SOURCES})
make_cpp_module(mod1 ${MOD1_SOURCES})
add_module_dependencies(mod1 ${MOD1_DEPS})
build_app_from_modules(${PROJECT_NAME} "modules/test2.cpp" ${MODULES_LIST})
#add_executable(${PROJECT_NAME} modules/test2.cpp)

