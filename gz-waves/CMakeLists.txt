cmake_minimum_required(VERSION 3.10.2)

#============================================================================
# Initialize the project
#============================================================================
project(gz-waves1 VERSION 1.0.0)

#============================================================================
# Find gz-cmake (unversioned — auto-detects latest installed)
#============================================================================
find_package(gz-cmake REQUIRED)
set(GZ_CMAKE_VER ${gz-cmake_VERSION_MAJOR})

#============================================================================
# Configure the project
#============================================================================
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

gz_configure_project()

#============================================================================
# Include cmake
#============================================================================

include(${PROJECT_SOURCE_DIR}/cmake/URL.conf.cmake)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

#============================================================================
# Set project-specific options
#============================================================================

#============================================================================
# Search for project-specific dependencies
#============================================================================

#--------------------------------------
# Find gnuplot-iostream - the header is used by the examples in test/plots
include(Add_gnuplot-iostream)

# Use unversioned find_package for all Gazebo dependencies.
# Homebrew provides symlinks (e.g. gz-sim -> gz-sim10), so the latest
# installed version is auto-detected.
message(STATUS "Detecting installed Gazebo packages...")

#--------------------------------------
# Find gz-math
find_package(gz-math REQUIRED COMPONENTS eigen3)
set(GZ_MATH_VER ${gz-math_VERSION_MAJOR})
message(STATUS "  gz-math ${gz-math_VERSION}")

#--------------------------------------
# Find gz-plugin
find_package(gz-plugin REQUIRED COMPONENTS loader register)
set(GZ_PLUGIN_VER ${gz-plugin_VERSION_MAJOR})
message(STATUS "  gz-plugin ${gz-plugin_VERSION}")

#--------------------------------------
# Find gz-common
find_package(gz-common REQUIRED COMPONENTS graphics events profiler)
set(GZ_COMMON_VER ${gz-common_VERSION_MAJOR})
message(STATUS "  gz-common ${gz-common_VERSION}")

#--------------------------------------
# Find gz-msgs
find_package(gz-msgs REQUIRED)
set(GZ_MSGS_VER ${gz-msgs_VERSION_MAJOR})
message(STATUS "  gz-msgs ${gz-msgs_VERSION}")

#--------------------------------------
# Find gz-transport
find_package(gz-transport REQUIRED)
set(GZ_TRANSPORT_VER ${gz-transport_VERSION_MAJOR})
message(STATUS "  gz-transport ${gz-transport_VERSION}")

#--------------------------------------
# Find gz-rendering
find_package(gz-rendering REQUIRED COMPONENTS ogre2)
set(GZ_RENDERING_VER ${gz-rendering_VERSION_MAJOR})
message(STATUS "  gz-rendering ${gz-rendering_VERSION}")

#--------------------------------------
# Find gz-sim
find_package(gz-sim REQUIRED)
set(GZ_SIM_VER ${gz-sim_VERSION_MAJOR})
message(STATUS "  gz-sim ${gz-sim_VERSION}")

#--------------------------------------
# Find SDFormat
find_package(sdformat REQUIRED)
set(SDF_VER ${sdformat_VERSION_MAJOR})
message(STATUS "  sdformat ${sdformat_VERSION}")

#--------------------------------------
# Find OGRE
list(APPEND gz_ogre_components "RTShaderSystem" "Terrain" "Overlay" "Paging")

gz_find_package(GzOGRE VERSION 1.9.0
  COMPONENTS ${gz_ogre_components}
  REQUIRED_BY ogre
  PRIVATE_FOR ogre)

#--------------------------------------
# Find OGRE2: first try to find OGRE2 built with PlanarReflections support and
# fallback to look for OGRE2 without it. Both seems to works for gz-rendering.
# See https://github.com/gazebosim/gz-rendering/issues/597
gz_find_package(GzOGRE2 VERSION 2.3
    COMPONENTS HlmsPbs HlmsUnlit Overlay PlanarReflections
    PRIVATE_FOR ogre2
    QUIET)

if ("${OGRE2-PlanarReflections}" STREQUAL "OGRE2-PlanarReflections-NOTFOUND")
  message(STATUS "PlanarReflections component was not found. Try looking without it:")
  gz_find_package(GzOGRE2 VERSION 2.3
    COMPONENTS HlmsPbs HlmsUnlit Overlay
    REQUIRED_BY ogre2
    PRIVATE_FOR ogre2)
endif()

if (OGRE2_FOUND)
  set(HAVE_OGRE2 TRUE)
endif()

#####################################
# Define compile-time default variables
if(MSVC)
  set(GZ_RENDERING_PLUGIN_PATH ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_BINDIR})
else()
  set(GZ_RENDERING_PLUGIN_PATH ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR})
endif()

#--------------------------------------
# Find eigen3

find_package(EIGEN3 REQUIRED)

#--------------------------------------
# CGAL and its components...

find_package(CGAL REQUIRED COMPONENTS Core)

if(NOT CGAL_FOUND)
  message(STATUS "This project requires the CGAL library, and will not be compiled.")
  return()  
endif()

message("CGAL_VERSION_MAJOR: ${CGAL_VERSION_MAJOR}")

if (${CGAL_VERSION_MAJOR} LESS 6)
  # include helper file
  include(${CGAL_USE_FILE})
endif()

#--------------------------------------
# Find FFTW3 (double-precision) (GPL) as FFT library.

find_path(FFTW3-3_INCLUDE_DIR
  NAMES fftw3.h
  HINTS $ENV{FFTW3_DIR}/include
  PATHS /usr/local/include
        /usr/include
)

find_library(FFTW3-3_LIBRARY
  NAMES fftw3 libfftw3
  HINTS $ENV{FFTW3_DIR}/lib
  PATHS /usr/local/lib
        /usr/lib
)

add_definitions(-DUSE_FFTW3)
set(FFT_INCLUDE_DIRS ${FFTW3-3_INCLUDE_DIR})
set(FFT_LIBRARIES ${FFTW3-3_LIBRARY})

#--------------------------------------
# Find OpenCL

# find_package(OpenCL REQUIRED)

#--------------------------------------
# Find clFFT

# find_package(clFFT REQUIRED)

#============================================================================

# Location of "fake install folder" used in tests
# Defined here at root scope so it is available for tests in src and test folders
set(FAKE_INSTALL_PREFIX "${CMAKE_BINARY_DIR}/fake/install")

#============================================================================
# Configure the build
#============================================================================

gz_configure_build(QUIT_IF_BUILD_ERRORS)

# add_subdirectory(examples)

#============================================================================
# Create package information
#============================================================================
gz_create_packages()

#============================================================================
# Configure documentation
#============================================================================

# TODO: add documentation api.md.in files
