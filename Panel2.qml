import QtQuick 2.0

PanelBase {
    id: root

    anchors.fill: parent

    title: "Panel 2"

    QtObject {
        id: internal

        property Component delegate: Rectangle {
            color: myIndex % 2 === 1 ? "#D6E5FF" : "#FFFFFF"

            width: contentArea.width
            height: childrenRect.height

            Text {
                text: myData

                font.capitalization: Font.Capitalize
                color: "#111111"
            }
        }
    }

    Rectangle {
        id: titleBG

        anchors.fill: titleText

        color: "#5B9AFF"
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
                id: content

                model: 20

                delegate: Loader {
                    property string myData: "index %1".arg(index)
                    property int myIndex: index

                    sourceComponent: internal.delegate
                }
            }
        }
    }
}
