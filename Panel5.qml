import QtQuick 2.0

PanelBase {
    id: root

    anchors.fill: parent

    title: "Panel 5"
    color0: "#E5FFD6"
    color1: "#FFFFFF"

    Rectangle {
        id: titleBG

        anchors.fill: titleText

        color: "#9AFF5B"
    }

    Text {
        id: titleText

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        font.bold: true

        text: root.title
    }

    Item {
        id: contentArea

        anchors.fill: parent

        TextDelegate { myData: "index %1".arg(0); myIndex: 0 }
        TextDelegate { myData: "index %1".arg(1); myIndex: 1 }
        TextDelegate { myData: "index %1".arg(2); myIndex: 2 }
        TextDelegate { myData: "index %1".arg(3); myIndex: 3 }
        TextDelegate { myData: "index %1".arg(4); myIndex: 4 }
        TextDelegate { myData: "index %1".arg(5); myIndex: 5 }
        TextDelegate { myData: "index %1".arg(6); myIndex: 6 }
        TextDelegate { myData: "index %1".arg(7); myIndex: 7 }
        TextDelegate { myData: "index %1".arg(8); myIndex: 8 }
        TextDelegate { myData: "index %1".arg(9); myIndex: 9 }
        TextDelegate { myData: "index %1".arg(10); myIndex: 10 }
        TextDelegate { myData: "index %1".arg(11); myIndex: 11 }
        TextDelegate { myData: "index %1".arg(12); myIndex: 12 }
        TextDelegate { myData: "index %1".arg(13); myIndex: 13 }
        TextDelegate { myData: "index %1".arg(14); myIndex: 14 }
        TextDelegate { myData: "index %1".arg(15); myIndex: 15 }
        TextDelegate { myData: "index %1".arg(16); myIndex: 16 }
        TextDelegate { myData: "index %1".arg(17); myIndex: 17 }
        TextDelegate { myData: "index %1".arg(18); myIndex: 18 }
        TextDelegate { myData: "index %1".arg(19); myIndex: 19 }
        TextDelegate { myData: "index %1".arg(0); myIndex: 0 }
        TextDelegate { myData: "index %1".arg(1); myIndex: 1 }
        TextDelegate { myData: "index %1".arg(2); myIndex: 2 }
        TextDelegate { myData: "index %1".arg(3); myIndex: 3 }
        TextDelegate { myData: "index %1".arg(4); myIndex: 4 }
        TextDelegate { myData: "index %1".arg(5); myIndex: 5 }
        TextDelegate { myData: "index %1".arg(6); myIndex: 6 }
        TextDelegate { myData: "index %1".arg(7); myIndex: 7 }
        TextDelegate { myData: "index %1".arg(8); myIndex: 8 }
        TextDelegate { myData: "index %1".arg(9); myIndex: 9 }
        TextDelegate { myData: "index %1".arg(10); myIndex: 10 }
        TextDelegate { myData: "index %1".arg(11); myIndex: 11 }
        TextDelegate { myData: "index %1".arg(12); myIndex: 12 }
        TextDelegate { myData: "index %1".arg(13); myIndex: 13 }
        TextDelegate { myData: "index %1".arg(14); myIndex: 14 }
        TextDelegate { myData: "index %1".arg(15); myIndex: 15 }
        TextDelegate { myData: "index %1".arg(16); myIndex: 16 }
        TextDelegate { myData: "index %1".arg(17); myIndex: 17 }
        TextDelegate { myData: "index %1".arg(18); myIndex: 18 }
        TextDelegate { myData: "index %1".arg(19); myIndex: 19 }
    }
}
