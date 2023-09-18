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

find_package(Qt5 COMPONENTS Widgets Network REQUIRED)


#add_executable(Test
##    implementation/widget1.cpp
##    implementation/widget2.cpp
##    implementation/loader_window.cpp
##    coroutines/coroutine_test.cpp
##    coroutines/main.cpp
#    modules/all_headers.hpp
##    modules/module_header.hpp
#    modules/module_source.cpp
#    modules/main.cpp
#)

if(NOT (CMAKE_BUILD_TYPE STREQUAL "Debug"))
    #Do not open console window
    #target_link_options(Test PRIVATE -mwindows)
endif()

#target_link_libraries(Test Qt5::Widgets Qt5::Network)

if(MINGW)
    #target_compile_options(Test PUBLIC "-fcoroutines")
    #set(CMAKE_EXE_LINKER_FLAGS "-static-libgcc -static-libstdc++")
    #target_link_libraries(Test -static-libgcc -static-libstdc++)
    #target_link_libraries(Test -static gcc stdc++ winpthread)
    #set(CMAKE_EXE_LINKER_FLAGS "-Wl,-Bstatic -lstdc++ -lwinpthread -Wl,-Bdynamic")
endif()

################################################################################
# Add target to build iostream module
add_custom_target(std_modules ALL
    COMMAND ${CMAKE_COMMAND} -E echo "Building standard library modules"
    COMMAND g++ -fmodules-ts -std=c++20 -c -x c++-system-header iostream
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
)

# Function to set up modules in GCC
function (prepare_for_module TGT DEPS)
    target_compile_options(${TGT} PUBLIC -fmodules-ts)
    set_property(TARGET ${TGT} PROPERTY CXX_STANDARD 20)
    set_property(TARGET ${TGT} PROPERTY CXX_EXTENSIONS OFF)
    add_dependencies(${TGT} ${DEPS} std_modules)
endfunction()

# Program name and sources
set(TARGET Test)
set(SOURCES modules/main.cpp)
set(STDMODULES modules/all_headers.hpp)
set(TESTMODULES modules/module_source.cpp)

set(MODULE_TARGET2 std-modules)
add_library(${MODULE_TARGET2} OBJECT ${STDMODULES})
prepare_for_module(${MODULE_TARGET2} "")

# Setup program modules object library
set(MODULE_TARGET test-modules)
add_library(${MODULE_TARGET} OBJECT ${TESTMODULES})
prepare_for_module(${MODULE_TARGET} ${MODULE_TARGET2})

# Setup executable
add_executable(${TARGET} ${SOURCES})
prepare_for_module(${TARGET} ${MODULE_TARGET})

# Add modules to application using object library
target_link_libraries(${TARGET} PRIVATE ${MODULE_TARGET} ${MODULE_TARGET2})
