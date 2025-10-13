#!/bin/bash
# Gazebo Garden environment setup

# for future use - to support multiple Gazebo versions
export GZ_VERSION=ionic

# not usually required as should default to localhost address
export GZ_IP=127.0.0.1

# ensure the model and world files are found
export GZ_SIM_RESOURCE_PATH=\
$GZ_SIM_RESOURCE_PATH:\
$HOME/workspace/gazebo/ws/src/asv_wave_sim/gz-waves-models/models:\
$HOME/workspace/gazebo/ws/src/asv_wave_sim/gz-waves-models/world_models:\
$HOME/workspace/gazebo/ws/src/asv_wave_sim/gz-waves-models/worlds

# ensure the system plugins are found
export GZ_SIM_SYSTEM_PLUGIN_PATH=\
$GZ_SIM_SYSTEM_PLUGIN_ATH:\
$HOME/workspace/gazebo/ws/install/lib

# ensure the gui plugin is found
export GZ_GUI_PLUGIN_PATH=\
$GZ_GUI_PLUGIN_PATH:\
$HOME/workspace/gazebo/ws/src/asv_wave_sim/gz-waves/src/gui/plugins/waves_control/build
