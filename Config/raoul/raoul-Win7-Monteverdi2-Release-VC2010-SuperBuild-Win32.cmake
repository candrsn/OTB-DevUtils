set(CTEST_BUILD_CONFIGURATION Release)
set(BUILD_DIR_NAME "Monteverdi2-SuperBuild-vc10-x86-Release")
set(CTEST_BUILD_NAME "Win7-${BUILD_DIR_NAME}")
set(CTEST_SITE "raoul.c-s.fr" )
set(CTEST_DASHBOARD_ROOT "C:/SuperBuild")
set(CTEST_CMAKE_GENERATOR "NMake Makefiles")
set(CTEST_TEST_TIMEOUT 1500)

set(CTEST_SOURCE_DIRECTORY  "C:/Users/jmalik/Dashboard/src/OTB-SuperBuild")
set(CTEST_BINARY_DIRECTORY  "${CTEST_DASHBOARD_ROOT}/build")
set(CTEST_INSTALL_DIRECTORY "${CTEST_DASHBOARD_ROOT}/install/")

set(CTEST_USE_LAUNCHERS TRUE)

set(DATA_ROOT C:/Users/jmalik/Dashboard/src)
set(SUPERBUILD_INITIAL_CACHE 
"CMAKE_INSTALL_PREFIX:PATH=${CTEST_INSTALL_DIRECTORY}
CMAKE_BUILD_TYPE:STRING=${CTEST_BUILD_CONFIGURATION}
OTB_DATA_ROOT:PATH=${DATA_ROOT}/OTB-Data
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
USE_SYSTEM_GLUT:BOOL=OFF
USE_SYSTEM_EXPAT:BOOL=OFF
ENABLE_QT4:BOOL=ON
BUILD_ICE:BOOL=ON
BUILD_MONTEVERDI2:BOOL=ON
BUILD_EXAMPLES=OFF
BUILD_TESTING=OFF
BUILD_ICE_APPLICATION:BOOL=ON
OTB_DATA_LARGEINPUT_ROOT:PATH=${DATA_ROOT}/OTB-LargeInput
CTEST_USE_LAUNCHERS:BOOL=${CTEST_USE_LAUNCHERS}")

##pull from OTB, Ice, Monteverdi2
#execute_process(COMMAND ${CMAKE_COMMAND} -E remove_directory ${CTEST_BINARY_DIRECTORY}/OTB/build)
execute_process(COMMAND ${CMAKE_COMMAND} -E remove_directory ${CTEST_BINARY_DIRECTORY}/ICE/build)
execute_process(COMMAND ${CMAKE_COMMAND} -E remove_directory ${CTEST_BINARY_DIRECTORY}/MONTEVERDI2/build)

ctest_start(Nightly)
ctest_update(SOURCE "${CTEST_SOURCE_DIRECTORY}")
file(WRITE "${CTEST_BINARY_DIRECTORY}/CMakeCache.txt" ${SUPERBUILD_INITIAL_CACHE})
ctest_configure (BUILD "${CTEST_BINARY_DIRECTORY}")

ctest_read_custom_files(${CTEST_BINARY_DIRECTORY}/MONTEVERDI2)

ctest_build (BUILD "${CTEST_BINARY_DIRECTORY}" TARGET MONTEVERDI2)
ctest_test (BUILD "${CTEST_BINARY_DIRECTORY}/MONTEVERDI2/build" ${CTEST_TEST_ARGS})

include(${CTEST_BINARY_DIRECTORY}/MONTEVERDI2/src/MONTEVERDI2/CTestConfig.cmake)

ctest_submit ()