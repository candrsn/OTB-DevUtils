SET (ENV{DISPLAY} ":0.0")

SET (dashboard_model Nightly)
string(TOLOWER ${dashboard_model} lcdashboard_model)

SET (CTEST_BUILD_CONFIGURATION Release)

SET (CTEST_SOURCE_DIRECTORY "$ENV{HOME}/Dashboard/${lcdashboard_model}/Monteverdi2-${CTEST_BUILD_CONFIGURATION}/src")
SET (CTEST_BINARY_DIRECTORY "$ENV{HOME}/Dashboard/${lcdashboard_model}/Monteverdi2-ReleaseBranch-${CTEST_BUILD_CONFIGURATION}/build")
SET (CTEST_INSTALL_DIRECTORY "$ENV{HOME}/Dashboard/${lcdashboard_model}/Monteverdi2-ReleaseBranch-${CTEST_BUILD_CONFIGURATION}/install")

SET( CTEST_CMAKE_GENERATOR  "Unix Makefiles" )
SET (CTEST_CMAKE_COMMAND "cmake" )
SET (CTEST_BUILD_COMMAND "/usr/bin/make -j8 -i -k" )
SET (CTEST_SITE "leod.c-s.fr")
SET (CTEST_BUILD_NAME "MacOSX10.8-${CTEST_BUILD_CONFIGURATION}-ReleaseBranch")
SET (CTEST_HG_COMMAND "/opt/local/bin/hg")
SET (CTEST_HG_UPDATE_OPTIONS "-C mvd2_release")
SET (CTEST_USE_LAUNCHERS ON)

SET (CTEST_INITIAL_CACHE "

BUILDNAME:STRING=${CTEST_BUILD_NAME}
SITE:STRING=${CTEST_SITE}
CTEST_USE_LAUNCHERS:BOOL=ON

CMAKE_LIBRARY_PATH:PATH=/opt/local/lib
CMAKE_INCLUDE_PATH:PATH=/opt/local/include

BUILD_SHARED_LIBS:BOOL=OFF
CMAKE_BUILD_TYPE:STRING=${CTEST_BUILD_CONFIGURATION}
BUILD_TESTING:BOOL=ON
CMAKE_INSTALL_PREFIX:STRING=${CTEST_INSTALL_DIRECTORY}

OTB_DATA_USE_LARGEINPUT:BOOL=ON
OTB_DATA_LARGEINPUT_ROOT:STRING=$ENV{HOME}/Data/OTB-LargeInput
OTB_DATA_ROOT:STRING=$ENV{HOME}/Data/OTB-Data

CMAKE_C_FLAGS:STRING= -Wall -Wno-uninitialized -Wno-unused-variable
CMAKE_CXX_FLAGS:STRING= -Wall -Wno-deprecated -Wno-uninitialized -Wno-unused-variable -Wno-gnu -Wno-overloaded-virtual -Wno-\\\\#warnings
#CMAKE_OSX_ARCHITECTURES:STRING=i386
CMAKE_MACOSX_RPATH:BOOL=1

OTB_DIR:STRING=$ENV{HOME}/Dashboard/${lcdashboard_model}/OTB-${CTEST_BUILD_CONFIGURATION}/build

#ICE_INCLUDE_DIR=$ENV{HOME}/Dashboard/nightly/Ice-Release/install/include/otb
#ICE_LIBRARY=$ENV{HOME}/Dashboard/nightly/Ice-Release/install/lib/otb/libOTBIce.dylib
ICE_INCLUDE_DIR:PATH=/Users/otbval/Dashboard/nightly/Ice-Release/src/Code
ICE_LIBRARY:FILEPATH=/Users/otbval/Dashboard/nightly/Ice-Release/build/bin/libOTBIce.dylib

Monteverdi2_USE_CPACK:BOOL=ON

")


SET (CTEST_NOTES_FILES
${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}
${CTEST_BINARY_DIRECTORY}/CMakeCache.txt
)

ctest_empty_binary_directory (${CTEST_BINARY_DIRECTORY})
ctest_start(${dashboard_model})
ctest_update(SOURCE "${CTEST_SOURCE_DIRECTORY}")
file(WRITE "${CTEST_BINARY_DIRECTORY}/CMakeCache.txt" ${CTEST_INITIAL_CACHE})
ctest_configure (BUILD "${CTEST_BINARY_DIRECTORY}")
ctest_read_custom_files(${CTEST_BINARY_DIRECTORY})
ctest_build (BUILD "${CTEST_BINARY_DIRECTORY}")
unset(CTEST_BUILD_COMMAND)
ctest_build(TARGET "packages")
ctest_test (BUILD "${CTEST_BINARY_DIRECTORY}" PARALLEL_LEVEL 4)
ctest_submit ()
