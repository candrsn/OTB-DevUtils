# -----------------------------------------------------------------------------
# Nihtly script for OpenJPEG trunk
# This will retrieve/compile/run tests/upload to cdash OpenJPEG
# Results will be available at: http://my.cdash.org/index.php?project=OPENJPEG
# ctest -S PC8908_OpenJPEG_trunk_Nightly.cmake -V
# Author: mickael.savinaud@c-s.fr
# Date: 2011-06-17
# -----------------------------------------------------------------------------

cmake_minimum_required(VERSION 2.8)

# Set where to find srr and test data and where to build binaries.
SET (CTEST_SOURCE_DIRECTORY       "C:/OpenJPEG/nightly/opj-trunk")
SET (CTEST_BINARY_DIRECTORY       "C:/OpenJPEG/nightly/build/OpenJPEG_trunk-release")
SET (CTEST_SOURCE_DATA_DIRECTORY  "C:/OpenJPEG/opj-data")

# User inputs:
SET( CTEST_CMAKE_GENERATOR      "Visual Studio 9 2008" )      # What is your compilation apps ?
SET( CTEST_CMAKE_COMMAND        "C:/Program Files/CMake 2.8/bin/cmake.exe" )
SET( CTEST_SITE                 "PC8908.c-s.fr" )             # Generally the output of hostname
SET( CTEST_BUILD_CONFIGURATION  Release)                        # What type of build do you want ?
SET( CTEST_BUILD_NAME           "WinXP-VS2008-32bits-trunk-${CTEST_BUILD_CONFIGURATION}") # Build Name
SET( ENV{CFLAGS} "-Wall" )                                    # All warnings ...

# Here we used the OSGeo4W environement for tiff and png, lcms2 is builded from provided sources
set( CACHE_CONTENTS "
CMAKE_BUILD_TYPE:STRING=${CTEST_BUILD_CONFIGURATION}

BUILD_TESTING:BOOL=TRUE
BUILD_EXAMPLES:BOOL=TRUE

OPJ_DATA_ROOT:PATH=${CTEST_SOURCE_DATA_DIRECTORY}

" )

# Update method 
# repository: http://openjpeg.googlecode.com/svn/trunk/ (openjpeg-read-only)
# need to use https for CS machine
set( CTEST_UPDATE_COMMAND   "svn")

# 3. cmake specific:
#set( CTEST_NOTES_FILES      "${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}")

ctest_empty_binary_directory( "${CTEST_BINARY_DIRECTORY}" )
file(WRITE "${CTEST_BINARY_DIRECTORY}/CMakeCache.txt" "${CACHE_CONTENTS}")

# Perform the Nightly build
ctest_start(Nightly TRACK Nightly-trunk)
ctest_update(SOURCE "${CTEST_SOURCE_DIRECTORY}")
ctest_configure(BUILD "${CTEST_BINARY_DIRECTORY}")
ctest_build(BUILD "${CTEST_BINARY_DIRECTORY}")
ctest_test(BUILD "${CTEST_BINARY_DIRECTORY}")
ctest_submit()

