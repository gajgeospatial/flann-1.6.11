###############################################################################
# Find Flann
#
# This sets the following variables:
# FLANN_FOUND - True if FLANN was found.
# FLANN_INCLUDE_DIRS - Directories containing the FLANN include files.
# FLANN_LIBRARIES - Libraries needed to use FLANN.
# FLANN_DEFINITIONS - Compiler flags for FLANN.

message("Specialied FindFlann Called")
if(NOT $ENV{FLANN_INCLUDE_DIR} STREQUAL "")
	set(FLANN_INCLUDE_DIR $ENV{FLANN_INCLUDE_DIR})
	if(NOT $ENV{FLANN_LIBRARY_DIR} STREQUAL "")
	   set(FLANN_LIBRARY_DIR $ENV{FLANN_LIBRARY_DIR})
	endif()
	if(NOT $ENV{FLANN_CPP_LIBRARY_DIR} STREQUAL "")
	   set(FLANN_CPP_LIBRARY_DIR $ENV{FLANN_CPP_LIBRARY_DIR})
	endif()
	if(NOT $ENV{FLANN_CUDA_LIBRARY_DIR} STREQUAL "")
	   set(FLANN_CUDA_LIBRARY_DIR $ENV{FLANN_CUDA_LIBRARY_DIR})
	endif()
	set(FLANN_INCLUDE_DIRS ${FLANN_INCLUDE_DIR})
	set(FLANN_LIBRARIES ${FLANN_LIBRARY_DIR} ${FLANN_CPP_LIBRARY_DIR} ${FLANN_CUDA_LIBRARY_DIR})
	set(FLANN_LIBRARY ${FLANN_LIBRARY_DIR})
	mark_as_advanced(FLANN_LIBRARY FLANN_INCLUDE_DIR)
	set(FLANN_FOUND TRUE)
else()
	find_package(PkgConfig)
	pkg_check_modules(PC_FLANN flann)
	set(FLANN_DEFINITIONS ${PC_FLANN_CFLAGS_OTHER})

	find_path(FLANN_INCLUDE_DIR flann/flann.hpp
		HINTS ${PC_FLANN_INCLUDEDIR} ${PC_FLANN_INCLUDE_DIRS})

	find_library(FLANN_LIBRARY flann
		HINTS ${PC_FLANN_LIBDIR} ${PC_FLANN_LIBRARY_DIRS})

	set(FLANN_INCLUDE_DIRS ${FLANN_INCLUDE_DIR})
	set(FLANN_LIBRARIES ${FLANN_LIBRARY})

	include(FindPackageHandleStandardArgs)
	find_package_handle_standard_args(Flann DEFAULT_MSG
		FLANN_LIBRARY FLANN_INCLUDE_DIR)

	mark_as_advanced(FLANN_LIBRARY FLANN_INCLUDE_DIR)
endif()
