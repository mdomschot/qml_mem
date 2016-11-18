import QtQuick 2.1
import QtQuick.Window 2.0
import QtQuick.Controls 1.2
import Sandbox 1.0

Item {
    id: root

    visible: true

    width: 818
    height: 525

    property int log: 1
    property int panel: 0

    // This flag allows us to enable/disable the caching mechanism.
    property bool useCache: false

    // Exposes diagnostic information.
    Diagnostics {
        id: diagnostics
    }

    // Exposes a pocket where we can store panel while they are not in use.
    Cache {
        id: cache
    }

    // This is where panels 1-6 will exist while they are alive.
    Item {
        id: panelArea

        anchors.top: parent.top
        anchors.bottom: controls.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 9
        anchors.bottomMargin: 6
        anchors.leftMargin: 9
        anchors.rightMargin: 9

        property var item: undefined
        property string source: ""
    }

    // Exposes controls for the tester.
    Column {
        id: controls

        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 9
        spacing: 6

        enabled: !player.running

        Row {
            spacing: 6

            Text   { text: "Actions & Settings:"; width: 120; anchors.verticalCenter: parent.verticalCenter }
            Button { text: "Reload";             onClicked: g_app.reload()              }
            Button { text: "GC";                 onClicked: gc()                        }
            Button { text: "Trim";               onClicked: cache.trimComponentCache()  }
            Button { text: "Clear";              onClicked: cache.clearComponentCache() }
            Button { text: "Use Panel Cache";    onClicked: root.useCache = !root.useCache; checkable: true; checked: root.useCache }
        }

        Row {
            spacing: 6

            Text   { text: "Panel Navigation:"; width: 120; anchors.verticalCenter: parent.verticalCenter }
            Button { text: "Run Test (5 Loops)"; onClicked: player.start()              }
            Button { text: "-";                  onClicked: root.navigate(0); width: 30 }
            Button { text: "1";                  onClicked: root.navigate(1); width: 30 }
            Button { text: "2";                  onClicked: root.navigate(2); width: 30 }
            Button { text: "3";                  onClicked: root.navigate(3); width: 30 }
            Button { text: "4";                  onClicked: root.navigate(4); width: 30 }
            Button { text: "5";                  onClicked: root.navigate(5); width: 30 }
            Button { text: "6";                  onClicked: root.navigate(6); width: 30 }
        }
    }

    Timer {
        id: player

        interval: 100
        running: false
        repeat: true

        property int step: 0

        onTriggered: {
            root.navigate(step % 7)

            if(++step === 36) {
                step = 0
                stop()
            }
        }
    }

    // When we navigate to a new panel, we log 3 times.
    // 1) Before doing anything (so the current panel).
    // 2) After unloading the current panel (so while there is not current panel).
    // 3) After loading the new panel.
    // So if you are transitioning to and/or from 'no panel', then you will see more than
    // one log message for 'no panel' (the '-').
    function navigate(nextPanel) {
        doLog()

        // Get rid of the old panel.
        if(panelArea.item) {
            if(useCache) {
                cache.giveItem(panelArea.source, panelArea.item)
            }
            else {
                panelArea.item.destroy()
            }

            panelArea.item = undefined
            panelArea.source = ""
        }

        // Ensure that we log while in transition.
        panel = 0
        gc()
        doLog()
        panel = nextPanel

        if(panel > 0) {
            var panelSource = "Panel%1.qml".arg(panel)

            // Create the new panel.
            if(cache.hasItem(panelSource)) {
                panelArea.item = cache.takeItem(panelSource)
                panelArea.item.parent = panelArea
                panelArea.item.visible = true
                panelArea.source = panelSource
            }
            else {
                var component = Qt.createComponent(Qt.resolvedUrl(panelSource), this)
                panelArea.item = component.createObject(panelArea, { })
                panelArea.source = panelSource
                component.destroy()
            }
        }

        doLog()
    }

    // This produces an output that is good for a spreadsheet.  It uses space as a delimeter, and
    // multiple delimiters in succession to align columns properly.
    function doLog() {
        if(log === 1) {
            console.log("xxx - 1 2 3 4 5 6")
        }

        var memoryUsed = diagnostics.getMemoryUsed().toFixed(3)

        var msgs = ["", "", "", "", "", "", ""]
        msgs[panel] = memoryUsed

        var msg = "xxx%1 %2 %3 %4 %5 %6 %7 %8".arg(log)
                                           .arg(msgs[0])
                                           .arg(msgs[1])
                                           .arg(msgs[2])
                                           .arg(msgs[3])
                                           .arg(msgs[4])
                                           .arg(msgs[5])
                                           .arg(msgs[6])

        console.log(msg)

        ++log
    }
}
