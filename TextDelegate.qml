import QtQuick 2.0

Rectangle {
    color: myIndex % 2 === 1 ? color0 : color1

    width: contentArea.width
    height: childrenRect.height

    property string myData: ""
    property int myIndex: 0

    Text {
        text: myData

        font.capitalization: Font.Capitalize
        color: "#111111"
    }
}
