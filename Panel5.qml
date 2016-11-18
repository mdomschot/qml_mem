import QtQuick 2.0

PanelBase {
    id: root

    anchors.fill: parent

    title: "Panel 5"
    titleBGColor: "#9AFF5B"
    tableBGColor: "#FFFFFF"
    tableBGColorAlt: "#E5FFD6"

    Rectangle {
        id: titleBG

        anchors.fill: titleText

        color: root.titleBGColor
    }

    Text {
        id: titleText

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        font.bold: true

        text: root.title
    }

    Column {
        id: contentArea

        anchors.fill: parent

        Repeater {
            model: 20
            delegate: TextDelegate {
                myColor: root.tableBGColor
                myColorAlt: root.tableBGColorAlt
                myWidth: contentArea.width
                myData: "index %1".arg(index)
                myIndex: index
            }
        }
    }
}
