# Client maintainer: julien.malik@c-s.fr
#RK: DONT EVEN THINK OF ACTIVATING SYSTEM LIBRARY AND MAKING OTB PACKAGE!
# THIS WILL REQUIRE SPECIFIC PATCHING IN GENERATED CMAKE FILES
# SEE otb.git/Packaging/install_cmake_files.cmake

set(dashboard_model Nightly)
set(CTEST_BUILD_CONFIGURATION Release)
set(CTEST_BUILD_NAME "Ubuntu14.04-64bits-SuperBuild")
set(dashboard_no_install 1)
include(${CTEST_SCRIPT_DIRECTORY}/hulk_common.cmake)

set(dashboard_root_name "tests")
set(dashboard_source_name "src/OTB/SuperBuild")
set(dashboard_binary_name "build/OTB-SuperBuild")

set(CTEST_INSTALL_DIRECTORY ${CTEST_DASHBOARD_ROOT}/install/OTB-SuperBuild)

set(dashboard_git_url "https://git@git.orfeo-toolbox.org/git/otb.git")
set(dashboard_update_dir ${CTEST_DASHBOARD_ROOT}/src/OTB)
#set(dashboard_git_branch sb-gdal-s2)

list(APPEND CTEST_TEST_ARGS 
  BUILD ${CTEST_DASHBOARD_ROOT}/${dashboard_binary_name}/OTB/build
)
list(APPEND CTEST_NOTES_FILES
  ${CTEST_DASHBOARD_ROOT}/${dashboard_binary_name}/OTB/build/CMakeCache.txt
  ${CTEST_DASHBOARD_ROOT}/${dashboard_binary_name}/OTB/build/otbConfigure.h
)

#CMAKE_CXX_FLAGS:STRING=-std=c++11
macro(dashboard_hook_init)
  set(dashboard_cache "${dashboard_cache}
CMAKE_INSTALL_PREFIX:PATH=${CTEST_INSTALL_DIRECTORY}
CMAKE_BUILD_TYPE:STRING=${CTEST_BUILD_CONFIGURATION}
OTB_DATA_ROOT:PATH=${CTEST_DASHBOARD_ROOT}/src/OTB-Data
DOWNLOAD_LOCATION:PATH=${CTEST_DASHBOARD_ROOT}/src/SuperBuild-archives
CTEST_USE_LAUNCHERS:BOOL=${CTEST_USE_LAUNCHERS}
CMAKE_C_COMPILER:PATH=/usr/bin/gcc-4.9
CMAKE_CXX_COMPILER:PATH=/usr/bin/g++-4.9
BUILD_TESTING:BOOL=ON
OTB_DATA_USE_LARGEINPUT:BOOL=ON
OTB_DATA_LARGEINPUT_ROOT:PATH=/home/otbval/Data/OTB-LargeInput
#disable to test update_pkg
QT4_SB_ENABLE_GTK:BOOL=OFF
OTB_ADDITIONAL_CACHE:STRING='-DModule_Mosaic:BOOL=ON;-DModule_otbGRM:BOOL=ON;-DModule_SertitObject:BOOL=ON'
")
endmacro()

macro(dashboard_hook_test)
set(ENV{LD_LIBRARY_PATH} ${CTEST_INSTALL_DIRECTORY}/lib)
endmacro()

execute_process(COMMAND ${CMAKE_COMMAND} -E remove_directory ${CTEST_INSTALL_DIRECTORY})
execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${CTEST_INSTALL_DIRECTORY})
execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${CTEST_INSTALL_DIRECTORY}/lib)
execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${CTEST_INSTALL_DIRECTORY}/bin)
execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${CTEST_INSTALL_DIRECTORY}/include)

include(${CTEST_SCRIPT_DIRECTORY}/../otb_common.cmake)
