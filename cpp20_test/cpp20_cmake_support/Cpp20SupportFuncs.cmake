function(raise_not_implemented FUNC_NAME)
    message(FATAL_ERROR "Function ${FUNC_NAME} is not implemented" )
endfunction()

function(link_to_target_recursively _target _module)
    message("Current module is ${_module}")
    foreach(_source IN ITEMS ${_module})
        message("Current source is ${_source}")
        if (NOT TARGET "${_source}")
            list(APPEND _source_list "${_source}")
        else()
            get_target_property(_type "${_source}" TYPE)
            if (_type STREQUAL "OBJECT_LIBRARY")
                list(APPEND _source_list "$<TARGET_OBJECTS:${_source}>")
            else()
                message(SEND_ERROR "my_add_executable: '${_source}' given as parameter is not a object-library target.")
            endif()
        endif()
    endforeach()
    #add_executable(${_target} ${_source_list})
    target_link_libraries(${_target} PUBLIC ${_source_list})
endfunction(link_to_target_recursively)

if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  # using Clang
        function(prepare_system_header_clang _HEADERS_LIST)
                raise_not_implemented("prepare_system_header_clang")
	endfunction()
	##################################################################################
	function(make_cpp_module_clang _CPP_MODULE_NAME _CPP_MODULE_FILES)
		raise_not_implemented("make_cpp_module_clang")
	endfunction()
	##################################################################################
	function(add_module_dependencies_clang _CPP_MODULE_NAME _CPP_MODULE_FILES)
		raise_not_implemented("add_module_dependencies_clang")
	endfunction()
	##################################################################################
        function (build_app_from_modules_clang _APP_NAME _MAIN_FUNC_FILE _CPP_MODULES_LIST)
		raise_not_implemented("build_app_from_modules_clang")
	endfunction()
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  # using GCC
    function(prepare_system_header_gcc _HEADERS_LIST)
    endfunction()
    ##################################################################################
    function(make_cpp_module_gcc _CPP_MODULE_NAME _CPP_MODULE_FILES)
        add_library(${_CPP_MODULE_NAME} OBJECT ${_CPP_MODULE_FILES})
        target_compile_options(${_CPP_MODULE_NAME} PUBLIC -c -std=c++20 -fmodules-ts)
    endfunction()
    ##################################################################################
    function(add_module_dependencies_gcc _CPP_MODULE_NAME _CPP_MODULE_FILES)
        message("GCC does not require separate module compiling. Args was: ${_CPP_MODULE_NAME} ${_CPP_MODULE_FILES}")
    endfunction()
    ##################################################################################
    function(build_app_from_modules_gcc _APP_NAME _MAIN_FUNC_FILE _CPP_MODULES_LIST)
        set(MODULES_OBJS_LIST "")
        foreach(module_target IN LISTS _CPP_MODULES_LIST)
            list(APPEND MODULES_OBJS_LIST $<TARGET_OBJECTS:${module_target}>)
        endforeach()
        message("[build_app_from_modules_gcc] Full object list is ${MODULES_OBJS_LIST}")
        add_executable(${_APP_NAME} ${_MAIN_FUNC_FILE} ${MODULES_OBJS_LIST})
        target_compile_options(${_APP_NAME} PUBLIC -std=c++20 -fmodules-ts)

#        message("[build_app_from_modules_gcc] Modules list is ${_CPP_MODULES_LIST}")
#        foreach(module_target IN LISTS _CPP_MODULES_LIST)
#            message("Current module is ${module_target}")
#            link_to_target_recursively(${_APP_NAME} ${module_target})
#        endforeach()
#        target_link_libraries(${_APP_NAME} PUBLIC
#            #${_CPP_MODULES_LIST}
#            ${CMAKE_BINARY_DIR}/CMakeFiles/mod1.dir/modules/test1.cpp.obj
#            ${CMAKE_BINARY_DIR}/CMakeFiles/mod2.dir/modules/test2.cpp.obj
#        )
    endfunction()
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
  # using Intel C++
        function(prepare_system_header_intel _HEADERS_LIST)
                raise_not_implemented("prepare_system_header_intel")
	endfunction()
	##################################################################################
	function(make_cpp_module_intel _CPP_MODULE_NAME _CPP_MODULE_FILES)
		raise_not_implemented("make_cpp_module_intel")
	endfunction()
	##################################################################################
	function(add_module_dependencies_intel _CPP_MODULE_NAME _CPP_MODULE_FILES)
		raise_not_implemented("add_module_dependencies_intel")
	endfunction()
	##################################################################################
        function(build_app_from_modules_intel _APP_NAME _MAIN_FUNC_FILE _CPP_MODULES_LIST)
		raise_not_implemented("build_app_from_modules_intel")
	endfunction()
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
  # using Visual Studio C++
        function(prepare_system_header_msvc _HEADERS_LIST)
                raise_not_implemented("prepare_system_header_msvc")
	endfunction()
	##################################################################################
	function(make_cpp_module_msvc _CPP_MODULE_NAME _CPP_MODULE_FILES)
		raise_not_implemented("make_cpp_module_msvc")
	endfunction()
	##################################################################################
	function(add_module_dependencies_msvc _CPP_MODULE_NAME _CPP_MODULE_FILES)
		raise_not_implemented("add_module_dependencies_msvc")
	endfunction()
	##################################################################################
        function(build_app_from_modules_msvc _APP_NAME _MAIN_FUNC_FILE _CPP_MODULES_LIST)
		raise_not_implemented("build_app_from_modules_msvc")
	endfunction()
endif()

function(prepare_system_header _HEADERS_LIST)
if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  # using Clang
  prepare_system_header_clang(${_HEADERS_LIST})
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  # using GCC
  prepare_system_header_gcc(${_HEADERS_LIST})
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
  # using Intel C++
  prepare_system_header_intel(${_HEADERS_LIST})
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
  # using Visual Studio C++
  prepare_system_header_msvc(${_HEADERS_LIST})
endif()
endfunction()

function(make_cpp_module _CPP_MODULE_NAME _CPP_MODULE_FILES)
if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  # using Clang
  make_cpp_module_clang(${_CPP_MODULE_NAME} ${_CPP_MODULE_FILES})
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  # using GCC
  make_cpp_module_gcc(${_CPP_MODULE_NAME} ${_CPP_MODULE_FILES})
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
  # using Intel C++
  make_cpp_module_intel(${_CPP_MODULE_NAME} ${_CPP_MODULE_FILES})
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
  # using Visual Studio C++
  make_cpp_module_msvc(${_CPP_MODULE_NAME} ${_CPP_MODULE_FILES})
endif()
endfunction()

function(add_module_dependencies _CPP_MODULE_NAME _CPP_MODULES_LIST)
    message("[add_module_dependencies] ${_CPP_MODULE_NAME} with source list ${_CPP_MODULES_LIST}")
if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  # using Clang
  add_module_dependencies_clang(${_CPP_MODULE_NAME} "${_CPP_MODULES_LIST}")
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  # using GCC
  add_module_dependencies_gcc(${_CPP_MODULE_NAME} "${_CPP_MODULES_LIST}")
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
  # using Intel C++
  add_module_dependencies_intel(${_CPP_MODULE_NAME} "${_CPP_MODULES_LIST}")
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
  # using Visual Studio C++
  add_module_dependencies_msvc(${_CPP_MODULE_NAME} "${_CPP_MODULES_LIST}")
endif()
endfunction()

function(build_app_from_modules _APP_NAME _MAIN_FUNC_FILE _CPP_MODULES_LIST)
    message("[build_app_from_modules] For application '${_APP_NAME}'"
        " with main file '${_MAIN_FUNC_FILE}' and modules list '${_CPP_MODULES_LIST}'")
if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  # using Clang
  build_app_from_modules_clang(${_APP_NAME} ${_MAIN_FUNC_FILE} "${_CPP_MODULES_LIST}")
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  # using GCC
  build_app_from_modules_gcc(${_APP_NAME} ${_MAIN_FUNC_FILE} "${_CPP_MODULES_LIST}")
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
  # using Intel C++
  build_app_from_modules_intel(${_APP_NAME} ${_MAIN_FUNC_FILE} "${_CPP_MODULES_LIST}")
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
  # using Visual Studio C++
  build_app_from_modules_msvc(${_APP_NAME} ${_MAIN_FUNC_FILE} "${_CPP_MODULES_LIST}")
endif()
endfunction()
