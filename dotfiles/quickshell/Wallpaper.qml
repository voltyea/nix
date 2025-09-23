import Quickshell
import QtQuick

Variants {
  model: Quickshell.screens
  delegate: Component {
    PanelWindow {
      required property var modelData
      screen: modelData
      anchors.left: true
      anchors.right: true
      anchors.top: true
      anchors.bottom: true
      aboveWindows: false
      exclusionMode: ExclusionMode.Ignore
      color: "transparent"
      Image {
        asynchronous: true
        source: `file://${Quickshell.env("HOME")}/.current_wallpaper`
        fillMode: Image.PreserveAspectCrop
        anchors.fill: parent
        smooth: true
        antialiasing: true
        cache: true
      }
      Image {
        asynchronous: true
        source: `file://${Quickshell.env("HOME")}/.config/quickshell/stary.png`
        fillMode: Image.PreserveAspectCrop
        anchors.fill: parent
        smooth: true
        antialiasing: true
        cache: true
      }
    }
  }
}
