
set(GZ-RENDERING_LIBRARY_DIRS
  ${GZ-RENDERING_INCLUDE_DIRS}/../../../lib/gz-rendering-${GZ_RENDERING_VER}/engine-plugins)

link_directories(${GZ-RENDERING_LIBRARY_DIRS})

#################################################
gz_add_component(rendering
  SOURCES
    BaseRenderEngineExtension.cc
    DisplacementMap.cc
    OceanGeometry.cc
    OceanVisual.cc
    RenderEngineExtension.cc
    RenderEngineExtensionManager.cc
    RenderEngineExtensionPlugin.cc
    SceneNodeFactory.cc
  GET_TARGET_NAME
    rendering_target
)

set_property(
  SOURCE RenderEngineExtensionManager.cc
  PROPERTY COMPILE_DEFINITIONS
  GZ_RENDERING_PLUGIN_PATH="${GZ_RENDERING_PLUGIN_PATH}"
)

target_link_libraries(${rendering_target}
  PUBLIC
    gz-common::gz-common
    gz-rendering::gz-rendering
  PRIVATE
    gz-plugin::loader  
)

#################################################
# this must be the only component that directly depends on ogre2
gz_add_component(rendering-ogre2
  SOURCES
    Ogre2DisplacementMap.cc
    Ogre2DynamicMesh.cc
    Ogre2OceanGeometry.cc
    Ogre2OceanVisual.cc
    Ogre2RenderEngineExtension.cc
    Ogre2SceneNodeFactory.cc
  GET_TARGET_NAME
    rendering_ogre2_target
  DEPENDS_ON_COMPONENTS
    ${rendering_target}
)

target_link_directories(${rendering_ogre2_target}
  PUBLIC
    ${GZ-RENDERING_LIBRARY_DIRS}
)

target_link_libraries(${rendering_ogre2_target}
  PUBLIC
    ${rendering_target}
    gz-common::gz-common
    gz-rendering::gz-rendering
    gz-rendering::ogre2
    GzOGRE2::GzOGRE2
  PRIVATE
    gz-plugin::register
)

# Suppress an Ogre warning about adding _DEBUG to precompiler definitions.
# TODO: set conditional on the cmake build type. 
target_compile_definitions(${rendering_ogre2_target}
  PUBLIC
    OGRE_IGNORE_UNKNOWN_DEBUG
)

#################################################
gz_add_system(waves-visual
  SOURCES
    WavesVisual.cc
  PUBLIC_LINK_LIBS
    ${rendering_target}
    gz-common::gz-common
    gz-sim::gz-sim
)

#################################################
gz_add_system(waves-model
  SOURCES
    WavesModel.cc
  PUBLIC_LINK_LIBS
    gz-common::gz-common
    gz-sim::gz-sim
)
