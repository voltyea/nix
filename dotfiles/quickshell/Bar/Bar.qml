import Quickshell
import QtQuick
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick.Layouts
import QtQuick.Shapes

PanelWindow {
  anchors.left: true
  anchors.top: true
  anchors.bottom: true
  implicitWidth: 60
  color: "transparent"
  Rectangle {
    height: parent.height
    width: parent.width
    color: "#809ccfd8"
    radius: width / 2
    border.width: 5
    border.color: "#c4a7e7"
    antialiasing: true
    Rectangle {
      id: logo
      width: parent.width - 17
      height: width
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: parent.top
      anchors.topMargin: 7
      color: "#80c4a7e7"
      radius: width / 2
      Image {
        asynchronous: true
        source: `file://${Quickshell.env("HOME")}/.config/quickshell/luna.png`
        fillMode: Image.PreserveAspectCrop
        anchors.fill: parent
        smooth: true
        antialiasing: true
        cache: true
      }
    }
    Rectangle {
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: logo.bottom
      anchors.topMargin: 10
      height: childrenRect.height + 20.6
      width: parent.width - 20
      color: "#809ccfd8"
      border.width: 3
      border.color: "#c4a7e7"
      radius: width / 2
      Column {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 10
        spacing: 8
        Repeater {
          model: {
            let wsList = (Hyprland && Hyprland.workspaces) ? Hyprland.workspaces.values : [];
            let maxId = wsList.length > 0 ? Math.max(...wsList.map(w => w.id)) : 0;
            return Math.max(5, maxId);
          }
          Rectangle {
            height: 22
            width: height
            radius: height / 2
            property bool hoverOver: false
            property var wsList: (Hyprland && Hyprland.workspaces) ? Hyprland.workspaces.values : []
            property bool isActive: wsList.some(w => w.id === index + 1 && w.active)
            color: isActive ? "#3e8fb0" : hoverOver ? "#908caa" : "#e0def4"
            MouseArea {
              anchors.fill: parent
              hoverEnabled: true
              onEntered: hoverOver = true
              onExited: hoverOver = false
              onClicked: Hyprland.dispatch("workspace " + (index + 1))
            }
          }
        }
      }
    }
    Rectangle {
      height: 210
      width: 35
      radius: width / 2
      color: "#9ccfd8"
      anchors.verticalCenter: parent.verticalCenter
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.verticalCenterOffset: 100
      Shape {
        asynchronous: true
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        preferredRendererType: Shape.CurveRenderer
        antialiasing: true
        smooth: true
        horizontalAlignment: Shape.AlignHCenter
        verticalAlignment: Shape.AlignVCenter
        ShapePath {
          capStyle: ShapePath.RoundCap
          strokeWidth: 3
          strokeColor: "#3e8fb0"
          fillColor: "transparent"
          startX: 0; startY: 0
          //PathLine { x: 0; y: 160 }
          //PathLine { x: 10; y: 100 }
        PathCurve { x: 0; y: 160 }
        PathCurve { x: 10; y: 30 }
        //PathCurve { x: 0; y: 160 }
        //PathCurve { x: 0; y: 100 }
        }
      }
    }
  }
}
