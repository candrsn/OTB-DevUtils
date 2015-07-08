# Client maintainer: julien.malik@c-s.fr
set(OTB_PROJECT OTB) # OTB / Monteverdi / Monteverdi2
set(OTB_ARCH x86) # x86 / amd64
set(CTEST_BUILD_CONFIGURATION Release)
set(CTEST_BUILD_TARGET INSTALL)
set(CTEST_BUILD_COMMAND "jom OTB")
set(CTEST_BUILD_NAME "Win7-OTB-SuperBuild-vc10-x86-Release")

set(dashboard_source_name ${CTEST_DASHBOARD_ROOT}/src/OTB/SuperBuild)
set(dashboard_update_dir ${CTEST_DASHBOARD_ROOT}/src/OTB)
set(CTEST_BINARY_DIRECTORY "C:/SuperBuild/build")
set(CTEST_INSTALL_PREFIX "C:/SuperBuild/install")

include(${CTEST_SCRIPT_DIRECTORY}/raoul_common.cmake)

list(APPEND CTEST_TEST_ARGS 
  BUILD ${CTEST_BINARY_DIRECTORY}/OTB/build
)
list(APPEND CTEST_NOTES_FILES
  ${CTEST_BINARY_DIRECTORY}/OTB/build/CMakeCache.txt
  ${CTEST_BINARY_DIRECTORY}/OTB/build/otbConfigure.h
)

macro(dashboard_hook_init)
  set(dashboard_cache "${dashboard_cache}
CMAKE_INSTALL_PREFIX:PATH=${CTEST_INSTALL_DIRECTORY}
CMAKE_BUILD_TYPE:STRING=${CTEST_BUILD_CONFIGURATION}
OTB_DATA_ROOT:PATH=${CTEST_DASHBOARD_ROOT}/src/OTB-Data
DOWNLOAD_LOCATION:PATH=${CTEST_DASHBOARD_ROOT}/src/SuperBuild-archives
ENABLE_OTB_LARGE_INPUTS:BOOL=ON
USE_SYSTEM_ZLIB:BOOL=OFF
USE_SYSTEM_QT4:BOOL=OFF
USE_SYSTEM_BOOST:BOOL=OFF
USE_SYSTEM_CURL:BOOL=OFF
USE_SYSTEM_OSSIM:BOOL=OFF
USE_SYSTEM_PNG:BOOL=OFF
USE_SYSTEM_TIFF:BOOL=OFF
USE_SYSTEM_GLFW:BOOL=OFF
USE_SYSTEM_GLEW:BOOL=OFF
USE_SYSTEM_EXPAT:BOOL=OFF
USE_SYSTEM_SWIG:BOOL=OFF
OTB_WRAP_JAVA:BOOL=OFF
OTB_USE_QT4:BOOL=ON
BUILD_EXAMPLES:BOOL=OFF
BUILD_TESTING:BOOL=ON
BUILD_ICE:BOOL=OFF
BUILD_MONTEVERDI2:BOOL=OFF
BUILD_ICE_APPLICATION:BOOL=OFF
OTB_DATA_LARGEINPUT_ROOT:PATH=${CTEST_DASHBOARD_ROOT}/src/OTB-LargeInput
CTEST_USE_LAUNCHERS:BOOL=${CTEST_USE_LAUNCHERS}
")
endmacro()

#Remove install dir
execute_process(COMMAND ${CMAKE_COMMAND} -E remove_directory ${CTEST_INSTALL_DIRECTORY})
execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${CTEST_INSTALL_DIRECTORY})
execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${CTEST_INSTALL_DIRECTORY}/lib)
execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${CTEST_INSTALL_DIRECTORY}/bin)
execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${CTEST_INSTALL_DIRECTORY}/include)

include(${CTEST_SCRIPT_DIRECTORY}/../otb_common.cmake)
