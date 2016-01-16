# Client maintainer: julien.malik@c-s.fr
set(dashboard_model Nightly)
set(CTEST_DASHBOARD_ROOT "/home/otbval/Dashboard")
set(CTEST_SITE "hulk.c-s.fr")
set(CTEST_BUILD_CONFIGURATION Release)
set(CTEST_BUILD_NAME "Ubuntu14.04-64bits-SoftwareGuide")
set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
set(CTEST_BUILD_COMMAND "/usr/bin/make -i -k" )
set(CTEST_TEST_ARGS PARALLEL_LEVEL 4)
set(CTEST_TEST_TIMEOUT 500)
set(CTEST_USE_LAUNCHERS ON)
set(CTEST_GIT_COMMAND "/usr/bin/git")

set(dashboard_root_name "tests")
set(dashboard_source_name "src/OTB-Documents/SoftwareGuide")
set(dashboard_binary_name "build/OTB-Documents/SoftwareGuide")

#set(dashboard_fresh_source_checkout OFF)
set(dashboard_git_url "https://git@git.orfeo-toolbox.org/git/otb-documents.git")
set(dashboard_update_dir ${CTEST_DASHBOARD_ROOT}/src/OTB-Documents)
set(dashboard_git_branch master)

macro(dashboard_hook_init)
  set(dashboard_cache "${dashboard_cache}

BUILDNAME:STRING=${CTEST_BUILD_NAME}
SITE:STRING=${CTEST_SITE}
CTEST_USE_LAUNCHERS:BOOL=OFF

CMAKE_BUILD_TYPE:STRING=${CTEST_BUILD_CONFIGURATION}
GENERATE_WRAPPING_DOC:BOOL=ON

OTB-Wrapping_SOURCE_DIR:PATH=$ENV{HOME}/Dashboard/src/OTB-Wrapping

CMAKE_C_FLAGS:STRING= -Wall
CMAKE_CXX_FLAGS:STRING= -Wall -Wno-cpp

OTB_DATA_LARGEINPUT_ROOT:STRING=$ENV{HOME}/Data/OTB-LargeInput
OTB_DATA_ROOT:STRING=$ENV{HOME}/Dashboard/src/OTB-Data
#OTB_DATA_PATHS:STRING=$ENV{HOME}/Dashboard/src/OTB-Data/Examples::$ENV{HOME}/Dashboard/src/OTB-Data/Input

OTB_DIR:STRING=$ENV{HOME}/Dashboard/install/OTB-stable/lib/cmake/OTB-5.2
OTB_SOURCE_DIR:PATH=$ENV{HOME}/Dashboard/src/OTB
OpenCV_DIR:PATH=/usr/share/OpenCV
")
endmacro()

#set(dashboard_no_test 1)
#set(dashboard_no_submit 1)

execute_process(COMMAND ${CMAKE_COMMAND} -D GIT_COMMAND:PATH=${CTEST_GIT_COMMAND} -D TESTED_BRANCH:STRING=release-5.2 -P ${CTEST_SCRIPT_DIRECTORY}/../git_updater.cmake
                        WORKING_DIRECTORY $ENV{HOME}/Dashboard/src/OTB)

include(${CTEST_SCRIPT_DIRECTORY}/../otb_common.cmake)
