SET (CTEST_SOURCE_DIRECTORY "D:/Developpement/OTB-hg/Monteverdi")
SET (CTEST_BINARY_DIRECTORY "D:/Developpement/OTB-NIGHTLY-VALIDATION/OSGEO-Release/binaries/Monteverdi-Debug")

SET (CTEST_CMAKE_GENERATOR  "Visual Studio 9 2008" )
SET (CTEST_CMAKE_COMMAND "C:/Program Files/CMake 2.8/bin/cmake.exe")
SET (CTEST_SITE "PC7450.c-s.fr" )
SET (CTEST_BUILD_NAME "WinXP-Visual2008Debug-Static")
SET (CTEST_BUILD_CONFIGURATION "Debug")
SET (CTEST_HG_COMMAND "C:/Program Files/Mercurial/hg.exe")
SET (CTEST_HG_UPDATE_OPTIONS "-C")

SET (OTB_INITIAL_CACHE "
BUILDNAME:STRING=${CTEST_BUILD_NAME}
SITE:STRING=${CTEST_SITE}

BUILD_TESTING:BOOL=ON
OTB_USE_CPACK:BOOL=ON

OTB_DATA_ROOT:STRING=D:/Developpement/OTB-hg/OTB-Data

GDAL_INCLUDE_DIR:PATH=C:/OSGeo4W/include
GDAL_LIBRARY:FILEPATH=C:/OSGeo4W/lib/gdal_i.lib

OTB_DIR:PATH=D:/Developpement/OTB-NIGHTLY-VALIDATION/OSGEO-Release/binaries/OTB-Debug
OTB_USE_CPACK:BOOL=ON

EXPAT_INCLUDE_DIR:PATH=C:/OSGeo4W/include
EXPAT_LIBRARY:FILEPATH=C:/OSGeo4W/lib/libexpat.lib

LIBLAS_INCLUDE_DIR:PATH=C:/OSGeo4W/include
LIBLAS_LIBRARY:FILEPATH=C:/OSGeo4W/lib/liblas_c.lib

")

ctest_empty_binary_directory (${CTEST_BINARY_DIRECTORY})

SET( OTB_PULL_RESULT_FILE "${CTEST_BINARY_DIRECTORY}/pull_result.txt" )
execute_process( COMMAND ${CTEST_HG_COMMAND} pull http://hg.orfeo-toolbox.org/Monteverdi-Nightly
                 WORKING_DIRECTORY "${CTEST_SOURCE_DIRECTORY}"
                 OUTPUT_VARIABLE   OTB_PULL_RESULT
                 ERROR_VARIABLE    OTB_PULL_RESULT )
file(WRITE ${OTB_PULL_RESULT_FILE} ${OTB_PULL_RESULT} )

SET (CTEST_NOTES_FILES
${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}
${CTEST_BINARY_DIRECTORY}/CMakeCache.txt
${OTB_PULL_RESULT_FILE}
)

ctest_start(Nightly)
ctest_update(SOURCE "${CTEST_SOURCE_DIRECTORY}")
file(WRITE "${CTEST_BINARY_DIRECTORY}/CMakeCache.txt" ${OTB_INITIAL_CACHE})
ctest_configure (BUILD "${CTEST_BINARY_DIRECTORY}")
ctest_read_custom_files(${CTEST_BINARY_DIRECTORY})
ctest_submit (PARTS Start Update Configure)
ctest_build (BUILD "${CTEST_BINARY_DIRECTORY}")
ctest_submit (PARTS Build)
ctest_test (BUILD "${CTEST_BINARY_DIRECTORY}")
ctest_submit ()
