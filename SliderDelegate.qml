import QtQuick 2.0

Item {
    id: sliderControl

    /** type:int Maximum value */
    property alias maximum: sliderBar.maximum
    /** type:int Minimum value */
    property alias minimum: sliderBar.minimum
    /** type:int Current value */
    property alias value: sliderBar.value
    /** type:real This property holds the step value */
    property double step: 1.0
    /** type:bool Show or not a min/max values */
    property bool showMinMaxValues: false
    /** type:bool Always show value tooltip */
    property bool toolTipAlwaysVisible: false
    /** type:string Units of measure */
    property string units: ""
    /** type:function A method that takes a number and returns a formatted string */
    property var formatter: undefined

    property int topMargin: 18 + 5

    height: implicitHeight
    implicitHeight: 50 + topMargin

    implicitWidth: 24 * 2 + 24 * 4 + 5 * 2

    Item {
        anchors.fill: parent
        anchors.topMargin: topMargin

        // Minus Button
        PushButton {
            id: minusButton

            anchors.left: parent.left
            anchors.top: parent.top
            width: Math.max(24, minusButtonLabel.implicitWidth)
            height: 24 + minusButtonLabel.implicitHeight
            imageAnchors.verticalCenterOffset: -minusButtonLabel.implicitHeight / 2

            image: "qrc:/Min.png"
            pressedImage: "qrc:/Min_Sel.png"

            autoRepeat: true

            onClicked: {
                toolTip.show(0);
                hideTimer.restart();

                sliderBar.setValue(sliderBar.value - sliderControl.step);
            }

            Text {
                id: minusButtonLabel
                text: {
                    var minimumString = formatter ? formatter(minimum) : minimum.toString()

                    return units.length > 0 ? "%1 %2".arg(minimumString).arg(units) :
                                         (showMinMaxValues ? "MIN %1".arg(minimumString) :
                                                             "MIN")
                }

                anchors.bottom: parent.bottom

                font.pixelSize: showMinMaxValues || units.length > 0 ? 11 : 14
                font.weight: Font.Normal

                color: "#000000"
            }
        }

        //Slide Rail
        Item {
            id: slideRail

            anchors.left: minusButton.right
            anchors.right: plusButton.left
            anchors.top: parent.top

            height: 24

            function valueFromPosition(xPos)
            {
                var range = sliderBar.maximum - sliderBar.minimum;
                var wd = sliderBar.width - handle.width

                hideTimer.restart();

                return (wd > 0 ? (xPos * range / wd) : 0)  + sliderBar.minimum
            }

            Image {
                source: "qrc:/SliderBar.png"
                height: sourceSize.height

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }

            BarGraph {
                id: sliderBar

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                height: 7

                radius: 0

                color: "transparent"
                barColor: "transparent"

                MouseArea {
                    id: sliderBarMouseArea

                    anchors.fill: parent

                    onPressed: {
                        sliderBar.setValue(slideRail.valueFromPosition(mouseX));
                    }
                }
            }

            Image {
                id: handle

                x: currentPosition()
                y: sliderBar.y + (sliderBar.height - handle.height) / 2

                width: 24
                height: 24

                source: mouseArea.pressed ? "qrc:/SlideBall.png" : "qrc:/SlideBall_Sel.png"

                function currentPosition()
                {
                    var range = sliderBar.maximum - sliderBar.minimum;

                    if (range === 0)
                        return 0;

                    return ((sliderBar.value - sliderBar.minimum)  * (sliderBar.width - width)) / range;
                }

                onXChanged: {
                    if (x >= 0 && mouseArea.drag.active)
                        sliderBar.setValue(slideRail.valueFromPosition(x));
                }

                MouseArea {
                    id: mouseArea

                    anchors.fill: parent

                    drag.target: handle
                    drag.axis: Drag.XAxis
                    drag.minimumX: 0
                    drag.maximumX: slideRail.width - handle.width

                    onPositionChanged: {
                        if (pressed) {
                            if (showTimer.running) {
                                showTimer.stop();
                                hideTimer.restart();
                            }

                            toolTip.show(0);
                        }
                    }

                    onPressed: {
                        showTimer.restart();
                    }

                    onReleased: {
                        showTimer.stop();
                    }
                }
            }

            Rectangle {
                id: toolTip

                border.color: "dimgray"
                border.width: 1
                color: "transparent"

                visible: sliderControl.toolTipAlwaysVisible

                y: handle.y - toolTip.height - 5 + 1
                x: handle.x
                width: Math.max(24, toolTipLabel.paintedWidth * 1.2)
                height: 18

                radius: 6

                function show(duration) {
                    if (!sliderControl.toolTipAlwaysVisible) {
                        toolTip.visible = true;
                        fadein.duration = duration;
                        fadein.start();
                    }
                }

                function hide(duration) {
                    if (!sliderControl.toolTipAlwaysVisible) {
                        fadeout.duration = duration;
                        fadeout.start();
                    }
                }

                Text {
                    id: toolTipLabel
                    anchors.fill: parent

                    font.pixelSize: 12
                    font.weight: Font.Normal

                    color: "#000000"

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    text: formatter ? formatter(sliderBar.value) : roundToResolution(sliderBar.value).toString()

                    function roundToResolution(valueToRound) {
                        return Math.floor(valueToRound*(1/sliderControl.step)+0.5)/(1/sliderControl.step)
                    }
                }

                NumberAnimation {
                    id: fadein

                    target: toolTip
                    property: "opacity"
                    easing.type: Easing.InOutQuad

                    from: 0
                    to: 1

                    onStopped: {
                        toolTip.visible = true;
                    }
                }

                NumberAnimation {
                    id: fadeout

                    target: toolTip
                    property: "opacity"
                    easing.type: Easing.InOutQuad

                    from: 1
                    to: 0

                    onStopped: {
                        toolTip.visible = false;
                    }
                }
            }

            Timer {
                id: hideTimer

                interval: 3000;
                repeat: false

                onTriggered: {
                    toolTip.hide(100);
                }
            }

            Timer {
                id: showTimer

                interval: 800;
                repeat: false

                onTriggered: {
                    toolTip.show(100);

                    hideTimer.restart();
                }
            }
        }

        // Plus Button
        PushButton {
            id: plusButton

            anchors.right: parent.right
            anchors.top: parent.top
            width: Math.max(24, plusButtonLabel.implicitWidth)
            height: 24 + plusButtonLabel.implicitHeight
            imageAnchors.verticalCenterOffset: -plusButtonLabel.implicitHeight / 2

            image: "qrc:/Max.png"
            pressedImage: "qrc:/Max_Sel.png"

            autoRepeat: true

            onClicked: {
                toolTip.show(0);
                hideTimer.restart();
                sliderBar.setValue(sliderBar.value + sliderControl.step);
            }

            Text {
                id: plusButtonLabel
                text: {
                    var maximumString = formatter ? formatter(maximum) : maximum.toString()

                    return units.length > 0 ? "%1 %2".arg(maximumString).arg(units) :
                                         (showMinMaxValues ? "MAX %1".arg(maximumString) :
                                                             "MAX")
                }

                anchors.bottom: parent.bottom

                font.pixelSize: showMinMaxValues || units.length > 0 ? 11 : 14
                font.weight: Font.Normal

                color: "#000000"
            }
        }
    }
}
