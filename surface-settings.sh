#!/bin/bash
#
#     <-- Surface Performance Selector -->
#   
# Simple GUI to set surface performance settings 
# for ubuntu or ubuntu-based distributions.
#
# Compatible with Nvidia performance base devices 
# with linux-surface kernel compatibility
#
# Requires linux-surface kernel and surface quick
# settings:
# -> Surface Book 2
#

battery_mode="FALSE"
default_mode="FALSE"
better_performance_mode="FALSE"
high_performance_mode="FALSE"
high_performance_gpu_mode="FALSE"
dgpu_off="FALSE"
dgpu_on="FALSE"

current_performance="---"
current_dgpu="---"
current_mode="$(sudo surface status)"

if [[ "$current_mode" == *"1"* ]] && [[ "$current_mode" == *"off"* ]]; then
  current_performance="Default"
  default_mode="TRUE"
elif [[ "$current_mode" == *"2"* ]] && [[ "$current_mode" == *"off"* ]]; then
  current_performance="Battery Saving"
  battery_mode="TRUE"
elif [[ "$current_mode" == *"3"* ]] && [[ "$current_mode" == *"off"* ]]; then
  current_performance="Better Performance"
  better_performance_mode="TRUE"
elif [[ "$current_mode" == *"4"* ]] && [[ "$current_mode" == *"off"* ]]; then
  current_performance="High Performance"
  high_performance_mode="TRUE"  
elif [[ "$current_mode" == *"4"* ]] && [[ "$current_mode" == *"on"* ]]; then
  current_performance="High Performance"
  high_performance_gpu_mode="TRUE"  
fi

if [[ "$current_mode" == *"off"* ]]; then
  current_dgpu="disabled"
  dgpu_off="TRUE"
else
  current_dgpu="enabled"
  dgpu_on="TRUE"
fi

# echo "$current_mode"

result="$(
zenity --height=280 --width=400 \
--list --radiolist \
--title="Surface Performance Settings" \
--text "• dGPU is ${current_dgpu}\n• Perfomance set to ${current_performance} mode" \
--column "Select" \
--column "Performance Modes" \
$battery_mode "Battery Saving" \
$default_mode "Default" \
$better_performance_mode "Better Performance" \
$high_performance_mode "High Performance (dGPU disabled)" \
$high_performance_gpu_mode "High Performance (dGPU enabled)" \
)"

if [ "$result" = "Default" ]; then  
  sudo surface dgpu set off
  sudo surface performance set 1
  notify-send "Surface - Default Mode" "Nvidia GPU disabled and system set to normal performance"
elif [ "$result" = "Battery Saving" ]; then  
  sudo surface dgpu set off
  sudo surface performance set 2
  notify-send "Surface - Battery Saving Mode" "Nvidia GPU disabled and system set to low performance"
elif [ "$result" = "Better Performance" ]; then
  sudo surface dgpu set off
  sudo surface performance set 3
  notify-send "Surface - Better Performance Mode" "Nvidia GPU disabled and system set to better performance"
elif [ "$result" = "High Performance (dGPU disabled)" ]; then
  sudo surface dgpu set off
  sudo surface performance set 4
  notify-send "Surface - High Performance Mode (dGPU disabled)" "Nvidia GPU disabled and system set to best performance"
elif [ "$result" = "High Performance (dGPU enabled)" ]; then
  sudo surface dgpu set on
  sudo surface performance set 4
  notify-send "Surface - High Performance Mode (dGPU enabled)" "Nvidia GPU enabled and system set to best performance"
fi
