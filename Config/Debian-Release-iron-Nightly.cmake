SET( CMAKE_BUILD_TYPE "Release" CACHE STRING "debianRelease" FORCE )
SET( BUILD_TESTING ON CACHE BOOL "debianRelease" FORCE )
SET( BUILD_EXAMPLES ON CACHE BOOL "debianRelease" FORCE )
SET( OTB_USE_CURL ON CACHE BOOL "debianRelease" FORCE )
SET( OTB_USE_EXTERNAL_EXPAT ON CACHE BOOL "debianRelease" FORCE )
SET( USE_FFTWD ON CACHE BOOL "debianRelease" FORCE )
SET( USE_FFTWF ON CACHE BOOL "debianRelease" FORCE )
SET( OTB_DATA_ROOT "/home/christop/OTB/trunk/OTB-Data" CACHE STRING "debianRelease" FORCE )
SET( CMAKE_C_FLAGS " -Wall -Wno-uninitialized -Wno-unused-variable" CACHE STRING "debianRelease" FORCE )
SET( CMAKE_CXX_FLAGS " -Wall -Wno-deprecated -Wno-uninitialized -Wno-unused-variable" CACHE STRING "debianRelease" FORCE )
SET( CMAKE_EXE_LINKER " " CACHE STRING "debianRelease" FORCE )
SET( MAKECOMMAND "/usr/bin/make -i -j 8" CACHE STRING "debianRelease" FORCE )
SET( OTB_GL_USE_ACCEL ON CACHE BOOL "debianRelease" FORCE )
SET( ITK_USE_REVIEW ON CACHE BOOL "debianRelease" FORCE )
SET( ITK_USE_OPTIMIZED_REGISTRATION_METHODS ON CACHE BOOL "Multithreaded registration" FORCE )

SET( CMAKE_INSTALL_PREFIX "/home/otbtesting/OTB/tmp" CACHE STRING "Used for package generation" FORCE )
SET( CPACK_BINARY_DEB ON CACHE BOOL "Generate debian package" FORCE )
SET( CPACK_DEBIAN_PACKAGE_ARCHITECTURE "amd64" CACHE STRING "Debian Architecture" FORCE)
