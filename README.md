# linux-surface-performance-gui

**surface-settings:** GUI for linux-surface compatible distributions to set performance and GPU mode
for surface devices. Requires [linux-surface kernel](https://github.com/linux-surface/linux-surface) and [surface-control utility](https://github.com/linux-surface/surface-control). Requires zenity and notify-send if its not preinstalled in your distribution.

Compatible with

* Surface Book 2

>*Usage:* `surface-settings.sh`

Note: Works best if set as a .desktop file:

```
[Desktop Entry]
Comment=Change performance mode for surface device
Terminal=false
Name=Device Mode
Exec=sudo /your/path/surface-settings.sh
Type=Application
Icon=/your/path/device-mode-icon.svg

```
