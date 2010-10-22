SET (CTEST_SOURCE_DIRECTORY "$ENV{HOME}/Projets/otb/src/Monteverdi")
SET (CTEST_BINARY_DIRECTORY "$ENV{HOME}/Projets/otb/build/debug/Monteverdi")
SET (CTEST_INSTALL_DIRECTORY "$ENV{HOME}/Projets/otb/install/Monteverdi-debug")

SET( CTEST_CMAKE_GENERATOR  "Eclipse CDT4 - Unix Makefiles" )
SET (CTEST_CMAKE_COMMAND "cmake" )
SET (CTEST_BUILD_COMMAND "/usr/bin/make -j3 -i -k install" )
SET (CTEST_SITE "PC8413.c-s.fr" )
SET (CTEST_BUILD_NAME "Ubuntu10.10-32bits-gcc4.5-Debug-Static")
SET (CTEST_BUILD_CONFIGURATION "Debug")
SET (CTEST_HG_COMMAND "/usr/bin/hg")
#SET (CTEST_HG_UPDATE_OPTIONS "-C")

SET(OTB_GDAL_INSTALL_DIR "$ENV{HOME}/Utils/bin/gdal-1.7.2")

SET (CTEST_INITIAL_CACHE "

BUILDNAME:STRING=${CTEST_BUILD_NAME}
SITE:STRING=${CTEST_SITE}

OTB_DATA_USE_LARGEINPUT:BOOL=ON
OTB_DATA_LARGEINPUT_ROOT:STRING=$ENV{HOME}/Projets/otb/src/OTB-LargeInput
OTB_DATA_ROOT:STRING=$ENV{HOME}/Projets/otb/src/OTB-Data

CMAKE_C_FLAGS:STRING= -Wall -Wextra
CMAKE_CXX_FLAGS:STRING= -Wall -Wextra -Wno-deprecated

CMAKE_BUILD_TYPE:STRING=${CTEST_BUILD_CONFIGURATION}
BUILD_TESTING:BOOL=ON

CMAKE_INSTALL_PREFIX:STRING=${CTEST_INSTALL_DIRECTORY}

OTB_DIR:STRING=$ENV{HOME}/Projets/otb/build/debug/OTB

")

SET (CTEST_ENVIRONMENT
 "DISPLAY=:0"
)

SET (CTEST_NOTES_FILES
${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}
${CTEST_BINARY_DIRECTORY}/CMakeCache.txt
)

ctest_empty_binary_directory (${CTEST_BINARY_DIRECTORY})
ctest_empty_binary_directory (${CTEST_BINARY_DIRECTORY})
FILE(WRITE "${CTEST_BINARY_DIRECTORY}/CMakeCache.txt" ${CTEST_INITIAL_CACHE})

ctest_start (Experimental)
ctest_configure (BUILD "${CTEST_BINARY_DIRECTORY}")
ctest_build (BUILD "${CTEST_BINARY_DIRECTORY}")
ctest_test (BUILD "${CTEST_BINARY_DIRECTORY}" PARALLEL_LEVEL 2)
ctest_submit ()

