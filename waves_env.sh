#!/bin/bash
# Gazebo Jetty environment setup for macOS (Homebrew)
# No GZ_VERSION needed — CMakeLists.txt auto-detects the latest Gazebo install

# Self-directory: works with both `source` and direct execution in bash/zsh
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"

# not usually required as should default to localhost address
export GZ_IP=127.0.0.1

# ensure the model and world files are found
export GZ_SIM_RESOURCE_PATH=\
$GZ_SIM_RESOURCE_PATH:\
$SCRIPT_DIR/gz-waves-models/models:\
$SCRIPT_DIR/gz-waves-models/world_models:\
$SCRIPT_DIR/gz-waves-models/worlds

# ensure the system plugins are found (compiled .dylib files)
export GZ_SIM_SYSTEM_PLUGIN_PATH=\
$GZ_SIM_SYSTEM_PLUGIN_PATH:\
$SCRIPT_DIR/gz-waves/build/lib

# ensure the gz-plugin system finds the rendering extension
export GZ_RENDERING_PLUGIN_PATH=\
$GZ_RENDERING_PLUGIN_PATH:\
$SCRIPT_DIR/gz-waves/build/lib

# ensure the gui plugin is found
export GZ_GUI_PLUGIN_PATH=\
$GZ_GUI_PLUGIN_PATH:\
$SCRIPT_DIR/gz-waves/build/lib
