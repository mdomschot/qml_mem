import QtQuick 2.0

Rectangle {
    id: barGraph

    /** type:int Bar Graph's maximum value */
    property alias maximum: range.maximum
    /** type:int Bar Graph's minimum value */
    property alias minimum: range.minimum
    /** type:int Bar Graph's current value */
    property alias value: range.value
    /** type:int Bar Graph's Normal threshold */
    property int normalLevel: 40
    /** type:int Bar Graph's Warning threshold */
    property int warningLevel: 60
    /** type:int Bar Graph's Alarm threshold */
    property int highLevel: 80
    property alias barColor: bar.color

    /**
     * Sets the Bar Graph's minimum to min and its maximum to max.
     * @param min Bar Graph's minimum value.
     * @param max Bar Graph's maximum value.
     */
    function setRange(min, max)
    {
        range.setRange(min, max)
    }

    /**
     * Sets the Bar Graph value.
     */
    function setValue(val)
    {
        range.setValue(val);
    }

    /**
     * Reset the Bar Graph value.
     */
    function reset()
    {
        range.reset();
    }

    QtObject {
        id: range

        property real value: 0
        property real maximum: 100
        property real minimum: 0
        property bool blockRecursion : false

        function setRange(min, max)
        {
            if (range.blockRecursion)
                return;

            range.blockRecursion = true;
            range.minimum = min;
            range.maximum = Math.max(min, max);
            range.blockRecursion = false;

            range.setValue(range.value);
        }

        function setValue(val)
        {
            if (range.blockRecursion)
                return;

            range.blockRecursion = true;
            range.value = Math.max(range.minimum, Math.min(val, range.maximum));
            range.blockRecursion = false;
        }

        function reset()
        {
            range.setValue(range.minimum);
        }
    }

    Rectangle {
        id: bar

        radius: barGraph.radius
        height: barGraph.height
        width: barWidth()

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        function barWidth()
        {
            var delta = range.maximum - range.minimum;

            if (delta === 0)
                return 0;

            return ((range.value - range.minimum) * barGraph.width) / delta;
        }
    }

    onMaximumChanged: {
        range.setRange(Math.min(minimum, maximum), maximum);
    }

    onMinimumChanged: {
        range.setRange(minimum, Math.max(maximum, minimum));
    }

    onValueChanged: {
        range.setValue(value);
    }
}
