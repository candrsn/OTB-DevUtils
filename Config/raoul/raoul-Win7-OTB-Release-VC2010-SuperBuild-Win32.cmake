set(CTEST_BUILD_CONFIGURATION Release)
set(BUILD_DIR_NAME "OTB-SuperBuild-vc10-x86-Release")
set(CTEST_BUILD_NAME "Win7-${BUILD_DIR_NAME}")
set(CTEST_SITE "raoul.c-s.fr" )
set(CTEST_DASHBOARD_ROOT "C:/SuperBuild")
set(CTEST_CMAKE_GENERATOR "NMake Makefiles")
set(CTEST_BUILD_COMMAND "jom OTB")
set(CTEST_TEST_TIMEOUT 1500)

set(CTEST_SOURCE_DIRECTORY  "C:/Users/jmalik/Dashboard/src/OTB/SuperBuild")
set(CTEST_BINARY_DIRECTORY  "${CTEST_DASHBOARD_ROOT}/build")
set(CTEST_INSTALL_DIRECTORY "${CTEST_DASHBOARD_ROOT}/install")
set(CTEST_GIT_COMMAND "C:/Program Files (x86)/Git/bin/git.exe")
set(CTEST_CMAKE_COMMAND "C:/Program Files (x86)/CMake 2.8/bin/cmake.exe")
set(CTEST_HG_COMMAND "C:/Program Files (x86)/Mercurial/hg.exe")
set(CTEST_HG_UPDATE_OPTIONS "-C")

set(DATA_ROOT C:/Users/jmalik/Dashboard/src)
set(SUPERBUILD_INITIAL_CACHE 
"CMAKE_INSTALL_PREFIX:PATH=${CTEST_INSTALL_DIRECTORY}
CMAKE_BUILD_TYPE:STRING=${CTEST_BUILD_CONFIGURATION}
OTB_DATA_ROOT:PATH=${DATA_ROOT}/OTB-Data
DOWNLOAD_LOCATION:PATH=Z:/otb/DataForTests/SuperBuild-archives
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
ENABLE_QT4:BOOL=ON
BUILD_EXAMPLES:BOOL=OFF
BUILD_TESTING:BOOL=ON
BUILD_ICE:BOOL=OFF
BUILD_MONTEVERDI2:BOOL=OFF
BUILD_ICE_APPLICATION:BOOL=OFF
OTB_DATA_LARGEINPUT_ROOT:PATH=${DATA_ROOT}/OTB-LargeInput
CTEST_USE_LAUNCHERS:BOOL=${CTEST_USE_LAUNCHERS}")

#clear otb install
execute_process(COMMAND ${CMAKE_COMMAND} -E remove_directory ${CTEST_INSTALL_DIRECTORY})
execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${CTEST_INSTALL_DIRECTORY})
execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${CTEST_INSTALL_DIRECTORY}/lib)
execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${CTEST_INSTALL_DIRECTORY}/bin)
execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${CTEST_INSTALL_DIRECTORY}/include)
#execute_process(COMMAND ${CMAKE_COMMAND} -E remove_directory ${CTEST_INSTALL_DIRECTORY}/include/otb)
#execute_process(COMMAND ${CMAKE_COMMAND} -E remove_directory ${CTEST_INSTALL_DIRECTORY}/lib/otb)

ctest_empty_binary_directory ( ${CTEST_BINARY_DIRECTORY} )
#empty otb build directory
#ctest_empty_binary_directory ( ${CTEST_BINARY_DIRECTORY}/OTB )

ctest_start(Nightly)
ctest_update(SOURCE "${CTEST_SOURCE_DIRECTORY}")
file(WRITE "${CTEST_BINARY_DIRECTORY}/CMakeCache.txt" ${SUPERBUILD_INITIAL_CACHE})
ctest_configure (BUILD "${CTEST_BINARY_DIRECTORY}")

ctest_read_custom_files(${CTEST_BINARY_DIRECTORY})

ctest_build (BUILD "${CTEST_BINARY_DIRECTORY}" TARGET OTB)
ctest_test (BUILD "${CTEST_BINARY_DIRECTORY}/OTB/build" ${CTEST_TEST_ARGS})

SET (CTEST_NOTES_FILES
${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}
${CTEST_BINARY_DIRECTORY}/CMakeCache.txt
${CTEST_BINARY_DIRECTORY}/OTB/build/CMakeCache.txt
${CTEST_BINARY_DIRECTORY}/OTB/build/otbConfigure.h
)
ctest_submit ()
