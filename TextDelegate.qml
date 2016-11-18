import QtQuick 2.0

Rectangle {
    property color myColor: "#FFFFFF"
    property color myColorAlt: "#DDEEFF"
    property real myWidth: 100
    property string myData: ""
    property int myIndex: 0

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
