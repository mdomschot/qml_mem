import QtQuick 2.0

PanelBase {
    id: root

    anchors.fill: parent

    title: "Panel 5"
    titleBGColor: "#9AFF5B"
    tableBGColor: "#FFFFFF"
    tableBGColorAlt: "#E5FFD6"

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

            //Repeater {
            //    model: 20
            //
            //    delegate: Loader {
            //        property string myData: "index %1".arg(index)
            //        property int myIndex: index
            //
            //        sourceComponent: internal.delegate
            //    }
            //    //delegate: internal.delegate
            //    //delegate: TextDelegate {
            //    //    myColor: root.tableBGColor
            //    //    myColorAlt: root.tableBGColorAlt
            //    //    myWidth: contentArea.width
            //    //    myData: "index %1".arg(index)
            //    //    myIndex: index
            //    //}
            //}
            TextDelegate { myColor: root.tableBGColor; myColorAlt: root.tableBGColorAlt; myWidth: contentArea.width; myData: "index %1".arg(0);  myIndex:  0 }
            TextDelegate { myColor: root.tableBGColor; myColorAlt: root.tableBGColorAlt; myWidth: contentArea.width; myData: "index %1".arg(1);  myIndex:  1 }
            TextDelegate { myColor: root.tableBGColor; myColorAlt: root.tableBGColorAlt; myWidth: contentArea.width; myData: "index %1".arg(2);  myIndex:  2 }
            TextDelegate { myColor: root.tableBGColor; myColorAlt: root.tableBGColorAlt; myWidth: contentArea.width; myData: "index %1".arg(3);  myIndex:  3 }
            TextDelegate { myColor: root.tableBGColor; myColorAlt: root.tableBGColorAlt; myWidth: contentArea.width; myData: "index %1".arg(4);  myIndex:  4 }
            TextDelegate { myColor: root.tableBGColor; myColorAlt: root.tableBGColorAlt; myWidth: contentArea.width; myData: "index %1".arg(5);  myIndex:  5 }
            TextDelegate { myColor: root.tableBGColor; myColorAlt: root.tableBGColorAlt; myWidth: contentArea.width; myData: "index %1".arg(6);  myIndex:  6 }
            TextDelegate { myColor: root.tableBGColor; myColorAlt: root.tableBGColorAlt; myWidth: contentArea.width; myData: "index %1".arg(7);  myIndex:  7 }
            TextDelegate { myColor: root.tableBGColor; myColorAlt: root.tableBGColorAlt; myWidth: contentArea.width; myData: "index %1".arg(8);  myIndex:  8 }
            TextDelegate { myColor: root.tableBGColor; myColorAlt: root.tableBGColorAlt; myWidth: contentArea.width; myData: "index %1".arg(9);  myIndex:  9 }
            TextDelegate { myColor: root.tableBGColor; myColorAlt: root.tableBGColorAlt; myWidth: contentArea.width; myData: "index %1".arg(10); myIndex: 10 }
            TextDelegate { myColor: root.tableBGColor; myColorAlt: root.tableBGColorAlt; myWidth: contentArea.width; myData: "index %1".arg(11); myIndex: 11 }
            TextDelegate { myColor: root.tableBGColor; myColorAlt: root.tableBGColorAlt; myWidth: contentArea.width; myData: "index %1".arg(12); myIndex: 12 }
            TextDelegate { myColor: root.tableBGColor; myColorAlt: root.tableBGColorAlt; myWidth: contentArea.width; myData: "index %1".arg(13); myIndex: 13 }
            TextDelegate { myColor: root.tableBGColor; myColorAlt: root.tableBGColorAlt; myWidth: contentArea.width; myData: "index %1".arg(14); myIndex: 14 }
            TextDelegate { myColor: root.tableBGColor; myColorAlt: root.tableBGColorAlt; myWidth: contentArea.width; myData: "index %1".arg(15); myIndex: 15 }
            TextDelegate { myColor: root.tableBGColor; myColorAlt: root.tableBGColorAlt; myWidth: contentArea.width; myData: "index %1".arg(16); myIndex: 16 }
            TextDelegate { myColor: root.tableBGColor; myColorAlt: root.tableBGColorAlt; myWidth: contentArea.width; myData: "index %1".arg(17); myIndex: 17 }
            TextDelegate { myColor: root.tableBGColor; myColorAlt: root.tableBGColorAlt; myWidth: contentArea.width; myData: "index %1".arg(18); myIndex: 18 }
            TextDelegate { myColor: root.tableBGColor; myColorAlt: root.tableBGColorAlt; myWidth: contentArea.width; myData: "index %1".arg(19); myIndex: 19 }
        }
    }
}
