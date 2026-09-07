
gz_add_system(hydrodynamics
  SOURCES
    Collision.cc
    Hydrodynamics.cc
  PUBLIC_LINK_LIBS
    gz-common::gz-common
    gz-sim::gz-sim
)
