pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Io

Singleton {

    Process {
      command: ["bash", "-c", "cava -p ~/.config/quickshell/cava/config"]
      running: true

      stdout: SplitParser {
  onRead: data => {
    const bars = data.split(";").map(parseInt)
    // Do something with the bars here
  }
}
    }
}
