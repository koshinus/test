function(raise_not_implemented FUNC_NAME)
	message(FATAL_ERROR "Function ${FUNC_NAME} is not implemented" )
endfunction()

if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  # using Clang
	function(compile_system_header_clang _HEADERS_LIST)
		raise_not_implemented("compile_system_header_clang")
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
	function build_app_from_modules_clang(_APP_NAME _CPP_MODULES_LIST)
		raise_not_implemented("build_app_from_modules_clang")
	endfunction()
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  # using GCC
	function(compile_system_header_gcc _HEADERS_LIST)
		execute_process(${CMAKE_CXX_COMPILER} -std=c++20 -fmodules-ts -xc++-system-header ${_HEADERS_LIST})
	endfunction()
	##################################################################################
	function(make_cpp_module_gcc _CPP_MODULE_NAME _CPP_MODULE_FILES)
		#message(FATAL_ERROR "Function make_cpp_module_gcc not implemented" )
		execute_process(${CMAKE_CXX_COMPILER} -std=c++20 -fmodules-ts ${_CPP_MODULE_FILES})
	endfunction()
	##################################################################################
	function(add_module_dependencies_gcc _CPP_MODULE_NAME _CPP_MODULE_FILES)
		message("GCC does not required for separate module compiling")
	endfunction()
	##################################################################################
	function build_app_from_modules_gcc(_APP_NAME _CPP_MODULES_LIST)
		execute_process(${CMAKE_CXX_COMPILER} -std=c++20 ${RUNTIME_OUTPUT_DIRECTORY }/*.o -o ${_APP_NAME})
	endfunction()
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
  # using Intel C++
	function(compile_system_header_intel _HEADERS_LIST)
		raise_not_implemented("compile_system_header_intel")
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
	function build_app_from_modules_intel(_APP_NAME _CPP_MODULES_LIST)
		raise_not_implemented("build_app_from_modules_intel")
	endfunction()
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
  # using Visual Studio C++
	function(compile_system_header_msvc _HEADERS_LIST)
		raise_not_implemented("compile_system_header_msvc")
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
	function build_app_from_modules_msvc(_APP_NAME _CPP_MODULES_LIST)
		raise_not_implemented("build_app_from_modules_msvc")
	endfunction()
endif()

function(compile_system_header _HEADERS_LIST)
if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  # using Clang
  compile_system_header_clang(${_HEADERS_LIST})
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  # using GCC
  compile_system_header_gcc(${_HEADERS_LIST})
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
  # using Intel C++
  compile_system_header_intel(${_HEADERS_LIST})
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
  # using Visual Studio C++
  compile_system_header_msvc(${_HEADERS_LIST})
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
if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  # using Clang
  add_module_dependencies_clang(${_CPP_MODULE_NAME} ${_CPP_MODULE_FILES})
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  # using GCC
  add_module_dependencies_gcc(${_CPP_MODULE_NAME} ${_CPP_MODULE_FILES})
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
  # using Intel C++
  add_module_dependencies_intel(${_CPP_MODULE_NAME} ${_CPP_MODULE_FILES})
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
  # using Visual Studio C++
  add_module_dependencies_msvc(${_CPP_MODULE_NAME} ${_CPP_MODULE_FILES})
endif()
endfunction()

function(build_app_from_modules _APP_NAME _CPP_MODULES_LIST)
if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  # using Clang
  build_app_from_modules_clang(${_APP_NAME} ${_CPP_MODULES_LIST})
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  # using GCC
  build_app_from_modules_gcc(${_APP_NAME} ${_CPP_MODULES_LIST})
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
  # using Intel C++
  build_app_from_modules_intel(${_APP_NAME} ${_CPP_MODULES_LIST})
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
  # using Visual Studio C++
  build_app_from_modules_msvc(${_APP_NAME} ${_CPP_MODULES_LIST})
endif()
endfunction()