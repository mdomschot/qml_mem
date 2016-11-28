import QtQuick 2.0

Rectangle {
    id: button

    color: "transparent"

    /** type:url Button icon */
    property url image
    /** type:url Button icon */
    property url pressedImage: ""
    /** This property holds whether autoRepeat is enabled. */
    property bool autoRepeat: false
    /** This property holds the interval of auto-repetition. */
    property int autoRepeatInterval: 50
    /** This property holds whether longPress is enabled. */
    property bool longPressEnabled: false

    /** type:bool This property holds whether the button is checkable.
        By default, the button is not checkable. */
    property bool checkable: false

    /** type:bool This property holds whether the button is checked.
        Only checkable buttons can be checked. By default, the button is unchecked. */
    property bool checked: false

    /* type:QSize This property holds the actual width and height of the loaded image. */
    property alias imageSize: image.sourceSize

    property alias imageObject: image
    property alias imageAnchors: image.anchors
    property alias imageScale: image.scale

    /**
     * Occurs when the button clicked.
     */
    signal clicked()

    /**
     * Occurs when the button pressed for a while
     */
    signal longPress()

    Behavior on scale { NumberAnimation { duration: 50 } }

    // Image
    Image {
        id: image

        anchors.centerIn: parent

        scale: {
            if (button.pressedImage.toString() !== "")
                return 1;

            return  mouseArea.pressed ? 0.95 : 1;
        }

        source: {
            if (button.pressedImage.toString() === "")
                return button.image;

            return mouseArea.pressed ? button.pressedImage : button.image;
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent

        onClicked: {
            if (checkable)
                checked = !checked;

            button.clicked();
        }

        onPressAndHold: {
            if (button.autoRepeat) {
                repeatTimer.start();
                return;
            }

            if (longPressEnabled)
                button.longPress()
            else
                onClicked(mouse)
        }

        onReleased: {
            if (repeatTimer.running)
                repeatTimer.stop();
        }

        onCanceled: {
            if (repeatTimer.running)
                repeatTimer.stop();
        }
    }

    Timer {
        id: repeatTimer

        interval: button.autoRepeatInterval
        running: false
        repeat: true

        onTriggered: button.clicked()
    }
}
