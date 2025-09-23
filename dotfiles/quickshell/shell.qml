import Quickshell
import QtQuick
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick.Layouts
import QtQuick.Shapes
import "./Bar/"
//import "./cava/"

ShellRoot {
  Loader {
    active: true
    sourceComponent: Wallpaper{}
  }

  Loader {
    active: true
    sourceComponent: Bar{}
  }

}
