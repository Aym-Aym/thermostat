import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15
import QtQml 2.15
//import Qt5Compat.GraphicalEffects


Item {
    id: control

    property int progressWidth: 10
    property int handleWidth: 10
    property int handleHeight: 10
    property int handleRadius: 5
    property bool snap: false
    property real startAngle: 0
    property real endAngle: 360
    property real minValue: 0.0
    property real maxValue: 1.0
    property real value: 0.0
    property real stepSize: 0.1
    property real maxHeatValue: 32
    property color progressColor: "#3a4ec4"
    property color handleColor: "#fefefe"
    property Component handle: null

    readonly property alias angle: internal.angle

    implicitWidth: 250; implicitHeight: 250

    Binding {
        target: control
        property: "value"
        value: control.snap? internal.snappedValue: internal.mapFromValue(startAngle, endAngle, minValue, maxValue, internal.angleProxy)
        when: internal.setUpdatedValue
        restoreMode: Binding.RestoreBinding
    }

    QtObject {
        id: internal

        property var centerPt: Qt.point(control.width / 2, control.height / 2)
        property bool setUpdatedValue: false
        property real angleProxy: control.startAngle
        property real snappedValue: 0.0
        property real baseRadius: Math.min(control.width, control.height) / 2 - control.progressWidth / 2
        property real actualSpanAngle: control.endAngle - control.startAngle

        readonly property real angle: internal.mapFromValue(control.minValue, control.maxValue, control.startAngle, control.endAngle, control.value)

        function mapFromValue(inMin, inMax, outMin, outMax, inValue) {
            return (inValue - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;
        }

        function updateAngle(angleVal) {
            if (angleVal < 0)
                angleVal += 360;

            if ((angleVal >= control.startAngle) && (angleVal <= control.endAngle) || (angleVal <= control.startAngle) && (angleVal >= control.endAngle)) {
                internal.setUpdatedValue = true;
                internal.angleProxy = Qt.binding(function() { return angleVal; });
                if(control.snap) {
                    var mappedValue = internal.mapFromValue(startAngle, endAngle, minValue, maxValue, internal.angleProxy)
                    var range = control.maxValue - control.minValue
                    var effectiveStep = 2
                    var actualVal = control.stepSize * Math.round(mappedValue / control.stepSize)

                    if (actualVal >= maxHeatValue) {
                        actualVal = maxHeatValue
                    }

                    internal.snappedValue = actualVal
                }
                internal.setUpdatedValue = false;
            }
        }
    }

    Shape {
        id: progressShape

        width: control.width; height: control.height

        ShapePath {
            id: progressShapePath

            strokeColor: control.progressColor
            fillColor: "transparent"
            strokeWidth: control.progressWidth
            capStyle: Qt.RoundCap

            PathAngleArc {
                radiusX: internal.baseRadius
                radiusY: internal.baseRadius
                centerX: control.width / 2
                centerY: control.height / 2
                startAngle: control.startAngle - 90
                sweepAngle: control.angle - control.startAngle
            }
        }
    }

//    Item {
//        id: orange_slider_bottom
//        width: control.width; height: control.height
////        transform: Rotation {
////                    origin.x: control.width / 2
////                    origin.y: control.height / 2
////                    angle: -33
////                }

//        Rectangle {
//            id: orange_slider_cap
//            width: 11; height: 11
//            color: "#ff0000"
////            y: 170 / 2
//            visible: false
//        }

//        Image {
//            id: ellipse_mask
//            source: "../../images/ellipse.svg"
//            fillMode: Image.PreserveAspectFit
//            anchors.fill:orange_slider_cap
//            visible: false
//            y: 170 / 2
//        }

//        OpacityMask {
//            anchors.fill: orange_slider_cap
//            source: orange_slider_cap
//            maskSource: ellipse_mask
//        }
//    }

//    Item {
//        id: orange_slider_top
//        width: 90; height: 90
//        transform: Rotation {
//                    origin.x: 90
//                    origin.y: 90
//                    angle: thermostat_widget.heatAngle - 30
//                }

//        Rectangle {
//            id: orange_slider_cap2
//            width: 11; height: 11
//            radius: 5.5
//            color: "#e8b261"
//            y: 170 / 2
//            visible: false
//        }

//        Image {
//            id: ellipse_mask2
//            source: "../../../images/ellipse.svg"
//            fillMode: Image.PreserveAspectFit
//            anchors.fill:orange_slider_cap2
//            visible: false
//            y: 170 / 2
//        }

//        OpacityMask {
//            anchors.fill: orange_slider_cap2
//            source: orange_slider_cap2
//            maskSource: ellipse_mask2
//        }


//        Image {
//            id: orange_handle
//            x: ellipse_mask2.x - 5; y: ellipse_mask2.y - 5
//            source: "../../../images/thermostat_slider_handle.png"
//            fillMode: Image.PreserveAspectFit

//            HoverHandler {
//                parent.opacity: hovered? 1: 0;

//                NumberAnimation on parent.opacity {
//                    to: parent.opacity === 0? 1: 0 ; duration: 500
//                }
//            }
//        }
//    }

    MouseArea {
        anchors.fill: parent
        enabled: true
        onClicked: {
            var outerRadius = Math.min(control.width, control.height)/ 2;
            var innerRadius = outerRadius - 20;
            var clickedDistance = (mouseX - internal.centerPt.x) * (mouseX - internal.centerPt.x) + (mouseY - internal.centerPt.y) * (mouseY - internal.centerPt.y);
            var innerRadius2 = (innerRadius * innerRadius);
            var outerRadius2 = (outerRadius * outerRadius);
            var isOutOfInnerRadius = clickedDistance > innerRadius2;
            var inInSideOuterRadius = clickedDistance <= outerRadius2;

            if (inInSideOuterRadius && isOutOfInnerRadius) {
                var angleDeg = Math.atan2(mouseY - internal.centerPt.y, mouseX - internal.centerPt.x) * 180 / Math.PI + 90;
                internal.updateAngle(angleDeg);
            }
        }
    }

    Item {
        id: handleItem

        x: control.width / 2 - width / 2; y: control.height / 2 - height / 2; z: 2
        width: control.handleWidth; height: control.handleHeight
        antialiasing: true
        transform: [
            Translate {
                y: -(Math.min(control.width, control.height) / 2) + control.progressWidth / 2
            },
            Rotation {
                angle: control.angle
                origin.x: handleItem.width / 2
                origin.y: handleItem.height / 2
            }
        ]

        Rectangle {
            id: heatHandle
            width: 10; height: 10
            color: "#ffffff"
            radius: 5
            visible: true
            antialiasing: true

//            HoverHandler {
//                parent.width: hovered? 20: 10
//                parent.height: hovered? 20: 10

//                NumberAnimation on parent.width {
//                    to: parent.width === 10? 20: 10 ; duration: 500
//                }

//                NumberAnimation on parent.height {
//                    to: parent.height === 10? 20: 10 ; duration: 500
//                }
//            }
        }

        MouseArea {
            id: mousePos

            function getValue() {
                var handlePoint = mapToItem(control, mousePos.mouseX, mousePos.mouseY);
                var angleDeg = Math.atan2(handlePoint.y - internal.centerPt.y, handlePoint.x - internal.centerPt.x) * 180 / Math.PI + 90;
                internal.updateAngle(angleDeg);
            }

            anchors.fill: parent
            onPositionChanged: getValue()
            onClicked: getValue()
            cursorShape: Qt.PointingHandCursor
        }

//        Rectangle {
//            id: handle
//            width: control.handleWidth
//            height: control.handleHeight
//            color: control.handleColor
//            radius: control.handleRadius
//            antialiasing: true
//            visible: false
//        }
    }
}


//import QtQuick 2.15
//import QtQuick.Controls 2.15
//import QtQuick.Layouts 2.15
//import Qt5Compat.GraphicalEffects
//import QtQuick.Shapes 2.15

//Item {
//    id: control

//    property int progressWidth: 10
//    property int handleWidth: 10
//    property int handleHeight: 10
//    property int handleRadius: 5
//    property bool snap: false
//    property real startAngle: 0
//    property real endAngle: 0
//    property real minValue: 0.0
//    property real maxValue: 1.0
//    property real stepSize: 0.1
//    property real value: 0.0
//    property color progressColor: "#ffffff"
//    property color handleColor: "#ff0000"
//    property Component handle: null

//    readonly property alias angle: internal.angle

//    implicitWidth: 250
//    implicitHeight: 250

//    Binding {
//        target: control
//        property: "value"
//        value: control.snap? internal.snappedValue: internal.mapFromValue(startAngle, endAngle, minValue, maxValue, internal.angleProxy)
//        when: internal.setUpdateValue
//        restoreMode: Binding.RestoreBinding
//    }


//    QtObject {
//        id: internal

//        property var centerPt: Qt.point(control.width / 2, control.height / 2)
//        property bool setUpdateValue: false
//        property real angleProxy: control.startAngle
//        property real snappedValue: 0.0
//        property real baseRadius: Math.min(control.width, control.height) / 2 - progressWidth / 2
//        property real actualSpanAngle: control.endAngle - control.startAngle

//        readonly property real angle: internal.mapFromValue(control.minValue, control.maxValue, control.startAngle, control.value)

//        function mapFromValue(inMin, inMax, outMin, outMax, inValue) {
//            return (inValue - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;
//        }

//        function updateAngle(angleValue) {
//            if (angleValue < 0)
//                angleValue += 360;

//            if ((angleValue >= control.startAngle) && (angleValue <= control.endAngle)) {
//                internal.setUpdateValue = true;
//                internal.angleProxy = Qt.binding(function() { return angleValue; });

//                if (control.snap) {
//                    var mappedValue = internal.mapFromValue(startAngle, endAngle, minValue, maxValue, internal.angleProxy);
//                    var range = control.maxValue - control.minValue;
//                    var effectiveStep = 2;
//                    var actualValue = control.stepSize * Math.round(mappedValue / control.stepSize);
//                    internal.snappedValue = actualVal;
//                }
//                internal.setUpdateValue = false;
//            }
//        }
//    }

//    Shape {
//        id: progressShape

//        width: control.width; height: control.height
//        layer.enabled: true
//        layer.samples: 8
//        visible: true

//        ShapePath {
//            id: progressShapePath

//            strokeColor: control.progressColor
//            fillColor: "transparent"
//            strokeWidth: control.progressWidth
//            capStyle: Qt.RoundCap

//            PathAngleArc {
//                radiusX: internal.baseRadius; radiusY: internal.baseRadius
//                centerX: control.width / 2; centerY: control.height / 2
//                startAngle: control.startAngle - 90
//                sweepAngle: internal.actualSpanAngle
//            }
//        }
//    }

//    MouseArea {
//        anchors.fill: parent
//        enabled: true
//        onClicked: {
//            var outerRadius = Math.min(control.width, control.height) / 2;
//            var innerRadius = outerRadius - progressWidth;
//            var clickedDistance = (mouseX - internal.centerPt.x) * (mouseX - internal.centerPt.x) + (mouseY - internal.centerPt.y) * (mouseY - internal.centerPt.y);
//            var innerRadius2 = (innerRadius * innerRadius);
//            var outerRadius2 = (outerRadius * outerRadius);
//            var isOutOfInnerRadius = clickedDistance > innerRadius2;
//            var isInsideOuterRadius = clickedDistance <= outerRadius2;

//            if (isInsideOuterRadius && isOutOfInnerRadius) {
//                var angleDeg = Math.atan2(mouseY - internal.centerPt.y, mouseX - internal.centerPt.x) * 180 / Math.PI + 90;
//                internal.updateAngle(angleDeg);
//            }
//        }
//    }

//    Item {
//        id: handleItem

//        x: control.width / 2 - width / 2; y: control.height / 2 - height / 2; z: 2
//        width: control.handleWidth; height: control.handleHeight
//        antialiasing: true
//        transform: [
//            Translate {
//                y: -(Math.min(control.width, control.height) / 2) + control.progressWidth / 2
//            },
//            Rotation {
//                angle: control.angle
//                origin.x: handleItem.width / 2; origin.y: handleItem.height / 2
//            }
//        ]

//        MouseArea {
//            id: mousePos
//            enabled: true

//            function getValue() {
//                var handlePoint = mapToItem(control, mousePos.mouseX, mousePos.mouseY);
//                var angleDeg = Math.atan2(handlePoint.y - internal.centerPt.y, handlePoint.x - internal.centerPt.x) * 180 / Math.PI + 90;
//                internal.updateAngle(angleDeg);
//            }

//            anchors.fill: parent
//            onPositionChanged: getValue()
//            onClicked: getValue()
//        }

//        Loader {
//            id: handleLoader

//            sourceComponent: control.handle ? handle : handleComponent
//        }
//    }

//    Component {
//        id: handleComponent

//        Rectangle {
//            width: control.handleWidth; height: control.handleHeight
//            color: control.handleColor
//            radius: control.handleRadius
//            antialiasing: true
//        }
//    }
//}
