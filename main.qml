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

    // Expose diagnostic information on the application.
    //Text {
    //    id: stats
    //
    //    anchors.left: parent.left
    //    anchors.verticalCenter: controls.verticalCenter
    //    anchors.margins: 9
    //
    //    font.family: "Lucida Console"
    //    font.pixelSize: 12
    //    font.bold: true
    //
    //    style: Text.Outline
    //    styleColor: "black"
    //    color: "yellow"
    //
    //    Timer {
    //        repeat: true
    //        running: true
    //        triggeredOnStart: true
    //        interval: 1000 / 5
    //
    //        onTriggered: {
    //            var fps = diagnostics.getFPS().toFixed(1)
    //            var memoryUsed = diagnostics.getMemoryUsed().toFixed(3)
    //
    //            var msg = "%2 FPS, %3 MB".arg(fps).arg(memoryUsed)
    //
    //            stats.text = msg
    //        }
    //    }
    //}

    // Exposes controls that allow the tester to change panels.
    Row {
        id: controls

        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 9
        spacing: 6



        //Button { text: "play (5)"; onClicked: player.start()              }
        //Button { text: "reload";   onClicked: g_app.reload()              }
        //Button { text: "GC";       onClicked: gc()                        }
        //Button { text: "Trim";     onClicked: cache.trimComponentCache()  }
        //Button { text: "Clear";    onClicked: cache.clearComponentCache() }
        //Button { text: "-";        onClicked: root.navigate(0); width: 30 }
        //Button { text: "1";        onClicked: root.navigate(1); width: 30 }
        //Button { text: "2";        onClicked: root.navigate(2); width: 30 }
        //Button { text: "3";        onClicked: root.navigate(3); width: 30 }
        //Button { text: "4";        onClicked: root.navigate(4); width: 30 }
        //Button { text: "5";        onClicked: root.navigate(5); width: 30 }
        //Button { text: "6";        onClicked: root.navigate(6); width: 30 }
    }

    Timer {
        running: true
        interval: 5000
        repeat: false

        onTriggered: player.start()
    }

    Timer {
        id: player

        interval: 100
        running: false
        repeat: true

        property int step: 0

        onTriggered: {
            root.navigate(step % 7)

            if(++step === 35) {
                step = 0
                //stop()
            }
        }
    }

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

    Timer {
        running: true
        repeat: true
        interval: 1000
        triggeredOnStart: true

        onTriggered: doLog(root.panel)
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

    Component.onCompleted: {
        var myString = ["car", "boat", "plane", "train"]

        for(var index = 0; index < myString.length; ++index) {
            console.log("[][][] %1".arg(myString[index]))
        }

        index = 0
        for(var vehicle = myString[index]; vehicle; vehicle = myString[++index]) {
            console.log("[][][] %1".arg(vehicle))
        }


    }
}
