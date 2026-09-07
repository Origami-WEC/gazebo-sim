
set(GZ-RENDERING_LIBRARY_DIRS
  ${GZ-RENDERING_INCLUDE_DIRS}/../../../lib/gz-rendering-${GZ_RENDERING_VER}/engine-plugins)

link_directories(${GZ-RENDERING_LIBRARY_DIRS})

gz_add_system(dynamic-geometry
  SOURCES
    DynamicGeometry.cc
  PUBLIC_LINK_LIBS
    gz-common::gz-common
    gz-rendering::gz-rendering
    gz-rendering::ogre2
    gz-sim::gz-sim
    GzOGRE2::GzOGRE2
  PRIVATE_COMPILE_DEFS
    OGRE_IGNORE_UNKNOWN_DEBUG
)
