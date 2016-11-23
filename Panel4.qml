import QtQuick 2.0

PanelBase {
    id: root

    anchors.fill: parent

    title: "Panel 4"
    titleBGColor: "#5BFF9A"
    tableBGColor: "#FFFFFF"
    tableBGColorAlt: "#D6FFE5"

    QtObject {
        id: internal

        property Component delegate: Rectangle {
            property color myColor: root.tableBGColor
            property color myColorAlt: root.tableBGColorAlt
            property real myWidth: contentArea.width
            //property string myData: "index %1".arg(index)
            //property int myIndex: index

            width: myWidth
            height: childrenRect.height
            color: myIndex % 2 === 1 ? myColorAlt : myColor

            Text {
                anchors.left: parent.left
                anchors.right: parent.right

                text: myData
                font.capitalization: Font.Capitalize
                color: "#111111"
            }
        }
    }

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

    Flickable {
        id: flickable

        anchors.top: titleText.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        contentWidth: contentArea.width
        contentHeight: contentArea.height

        clip: true

        Column {
            id: contentArea

            width: flickable.width

            Repeater {
                model: 80

                delegate: Loader {
                    property string myData: "index %1".arg(index)
                    property int myIndex: index

                    sourceComponent: internal.delegate
                }
            }
        }
    }
}
