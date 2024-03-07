import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15
import Qt5Compat.GraphicalEffects
import QtQuick.Shapes 2.15

import "../../components"

Item {
    id: thermostat_widget

    property double heatAngle: (10.61 * heatTemp) - 96.48
    property double heatTemp: circular_slider_heat.value
    property double coolAngle: (-10.61 * coolTemp) + 339.48
    property double coolTemp: circular_slider_cool.value
    property double currentTemp: 22.5
    property bool heatSelectionValue: false
    property bool coolSelectionValue: false

    implicitWidth: childrenRect.width
    implicitHeight: childrenRect.height

    Image {
        id: thermostat_bg
        source: "../../../images/thermostat_none_bg.png"
        fillMode: Image.PreserveAspectFit

        Text {
            id: thermostat_widget_title
            color: "#ffffff"
            text: qsTr("THERMOSTAT")
            anchors.top: parent.top
            horizontalAlignment: Text.AlignLeft
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 13
            Layout.topMargin: -3
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            font.styleName: "Light"
            font.pointSize: 12
        }

        Image {
            id: thermostat_slider_bg
            anchors.top: thermostat_widget_title.bottom
            anchors.topMargin: 14
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../../../images/thermostat_slider_bg.png"
            fillMode: Image.PreserveAspectFit

//            Shape {
//                anchors.top: thermostat_slider_bg.top
//                anchors.topMargin: 90
//                anchors.horizontalCenter: parent.horizontalCenter
//                rotation: 148

//                ShapePath {
//                    strokeWidth: 10
//                    fillColor: "#00000000"
//                    strokeColor: "#e8b261"
//                    capStyle: ShapePath.RoundCap

//                    PathAngleArc {
//                        radiusX: 85; radiusY: 85
//                        startAngle: 0
//                        sweepAngle: thermostat_widget.heatAngle + 1//max 244
//                    }
//                }
//            }

            CircularSlider {
                id: circular_slider_cool
                anchors.top: thermostat_slider_bg.top
                anchors.horizontalCenter: parent.horizontalCenter
                width:  180; height: 180

                startAngle: 244
                endAngle: 0
                minValue: 32
                maxValue: 8
                value: 20
                snap: true
                stepSize: 0.5
                transform: Rotation {
                    origin.x: 90
                    origin.y: 90
                    angle: -122
                }
            }

            CircularSlider {
                id: circular_slider_heat
                anchors.top: thermostat_slider_bg.top
                anchors.horizontalCenter: parent.horizontalCenter
                width:  180; height: 180

                startAngle: 0
                endAngle: 244
                minValue: 8
                maxValue: 32
                maxHeatValue: circular_slider_cool.value - 2
                value: 12.5
                snap: true
                stepSize: 0.5
                progressColor: "#e8b261"
                transform: Rotation {
                    origin.x: 90
                    origin.y: 90
                    angle: -122
                }
            }

//            CircularSlider {
//                anchors.top: thermostat_slider_bg.top
////                anchors.topMargin: 90
//                anchors.horizontalCenter: parent.horizontalCenter
//                width:  180; height: 180

//                startAngle: 0
//                endAngle: -244
//                minValue: 0
//                maxValue: 32
//                value: 12
//                snap: true
//                stepSize: 0.5
//                progressColor: "red"
//                transform: Rotation {
//                    origin.x: 90
//                    origin.y: 90
//                    angle: 122
//                }
//            }

//            Shape {
//                anchors.top: thermostat_slider_bg.top
//                anchors.topMargin: 90
//                anchors.horizontalCenter: parent.horizontalCenter
//                rotation: 148

//                ShapePath {
//                    strokeWidth: 10
//                    fillColor: "#00000000"
//                    strokeColor: "#74bcff"
//                    capStyle: ShapePath.RoundCap

//                    PathAngleArc {
//                        radiusX: 85; radiusY: 85
//                        startAngle: 244 //max 244
//                        sweepAngle: -thermostat_widget.coolAngle //max 244
//                    }
//                }
//            }

//            Item {
//                id: blue_slider_bottom
//                width: 90; height: 90
//                transform: Rotation {
//                            origin.x: 90
//                            origin.y: 90
//                            angle: 213
//                        }

//                Rectangle {
//                    id: blue_slider_cap
//                    width: 11; height: 11
//                    color: "#74bcff"
//                    y: 170 / 2
//                    visible: false
//                }

//                Image {
//                    id: blue_ellipse_mask
//                    source: "../../../images/ellipse.svg"
//                    fillMode: Image.PreserveAspectFit
//                    anchors.fill: blue_slider_cap
//                    visible: false
//                    y: 170 / 2
//                }

//                OpacityMask {
//                    anchors.fill: blue_slider_cap
//                    source: blue_slider_cap
//                    maskSource: blue_ellipse_mask
//                }
//            }

//            Item {
//                id: blue_slider_top
//                width: 90; height: 90
//                transform: Rotation {
//                            origin.x: 90
//                            origin.y: 90
//                            angle: 244 - 33 - thermostat_widget.coolAngle
//                        }

//                Rectangle {
//                    id: blue_slider_cap2
//                    width: 11; height: 11
//                    color: "#74bcff"
//                    y: 170 / 2
//                    visible: false
//                }

//                Image {
//                    id: blue_ellipse_mask2
//                    source: "../../../images/ellipse.svg"
//                    fillMode: Image.PreserveAspectFit
//                    anchors.fill: blue_slider_cap2
//                    visible: false
//                    y: 170 / 2
//                }

//                OpacityMask {
//                    anchors.fill: blue_slider_cap2
//                    source: blue_slider_cap2
//                    maskSource: blue_ellipse_mask2
//                }
//            }

            Item {
                id: current_temp
                width: 90; height: 90
                transform: Rotation {
                            origin.x: 90
                            origin.y: 90
                            angle: (10.52 * thermostat_widget.currentTemp) - 125.7 // low: 9 (-31); hight: 32 (211)
                        }

                Rectangle {
                    id: current_temp_color
                    width: 11; height: 11
                    color: "#ffffff"
                    y: 170 / 2
                    visible: false
                }

                Image {
                    id: current_temp_ellipse_mask
                    source: "../../../images/ellipse.svg"
                    fillMode: Image.PreserveAspectFit
                    anchors.fill:current_temp_color
                    visible: false
                    y: 170 / 2
                }

                OpacityMask {
                    anchors.fill: current_temp_color
                    source: current_temp_color
                    maskSource: current_temp_ellipse_mask
                }
            }

            Text {
                function roundToNearestHalf(value) {
                    return Math.round(value * 2) / 2;
                }

                id: current_temp_value
                color: "#ffffff"
                text: qsTr(removeTrailingZeros(roundToNearestHalf(currentTemp)) + "°C")
                anchors.top: parent.top
                horizontalAlignment: Text.AlignLeft
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 52
                font.styleName: "Light"
                font.pointSize: 30



                function removeTrailingZeros(value) {
                    var str = value.toString();
                    str = str.replace(/\.?0+$/, '');
                    return str;
                }
            }

            Item {
                id: item1
                    anchors.top: current_temp_value.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.topMargin: 5

                    implicitWidth: parent.width

                    CursorRoundButton {
                        id: heat_selection_btn
                        implicitWidth: 58; implicitHeight: 45
                        anchors.horizontalCenter: parent.horizontalCenter
                        checkable: true
                        radius: 4
                        anchors.top: parent.top
                        anchors.topMargin: -5
                        anchors.horizontalCenterOffset: -30
                        background: Rectangle {
                            implicitWidth: 58; implicitHeight: 45
                            radius: 4
                            color: parent.checked? parent.hovered? "#40101010": "#40000000": parent.hovered? "#40101010": "#00000000"
                        }

                        onClicked: {
                            if (cool_selection_btn.checked) {
                                cool_selection_btn.checked = false
                            }
                        }
                    }

                    Text {
                        id: heat_temp_set_text
                        color: "#7b7d7f"
                        text: qsTr("Heat")
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenterOffset: -29
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.styleName: "Light"
                        font.pointSize: 12
                    }
                    Text {
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                        id: heat_temp_set_value
                        color: "#ffffff"
                        text: thermostat_widget.heatTemp + "°C"
                        anchors.top: heat_temp_set_text.bottom
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: heat_temp_set_text.horizontalCenter
                        anchors.topMargin: 2
                        font.styleName: "Light"
                        font.pointSize: 14
                    }

                    CursorRoundButton {
                        id: cool_selection_btn
                        implicitWidth: 58; implicitHeight: 45
                        anchors.horizontalCenter: parent.horizontalCenter
                        checkable: true
                        radius: 4
                        anchors.top: parent.top
                        anchors.topMargin: -5
                        anchors.horizontalCenterOffset: 30
                        background: Rectangle {
                            implicitWidth: 58; implicitHeight: 45
                            radius: 4
                            color: parent.checked? parent.hovered? "#40101010": "#40000000": parent.hovered? "#40101010": "#00000000"
                        }

                        onClicked: {
                            if (heat_selection_btn.checked) {
                                heat_selection_btn.checked = false
                            }
                        }
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                        id: cool_temp_set_text
                        color: "#7b7d7f"
                        text: qsTr("Cool")
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenterOffset: 29
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.styleName: "Light"
                        font.pointSize: 12
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                        id: cool_temp_set_value
                        color: "#ffffff"
                        text: thermostat_widget.coolTemp + "°C"
                        anchors.top: cool_temp_set_text.bottom
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: cool_temp_set_text.horizontalCenter
                        anchors.topMargin: 2
                        font.styleName: "Light"
                        font.pointSize: 14
                    }
                }
        }

        Rectangle {
            id: buttons
            anchors.top: thermostat_slider_bg.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            implicitHeight: childrenRect.height

            CursorRoundButton {
                width: 38; height: 38
                enabled: cool_selection_btn.checked || heat_selection_btn.checked? true: false
                anchors.horizontalCenterOffset: -29
                anchors.horizontalCenter: parent.horizontalCenter
                id: button_down
                background: Rectangle {
                    width: 38; height: 38
                    radius: 19
                    color: parent.enabled? parent.hovered? "#40101010": "#40000000": "#10000000"
                }

                contentItem: Image {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    source: "../../../images/icons/chevron.down.svg"
                    anchors.bottomMargin: 14
                    anchors.topMargin: 14
                    anchors.rightMargin: 11
                    anchors.leftMargin: 11
                    fillMode: Image.PreserveAspectFit
                    opacity: parent.enabled? 1: 0.4
                }

                onPressed: {
                    if (heat_selection_btn.checked) {
                        if (circular_slider_heat.value - 0.5 >= circular_slider_heat.minValue) {
                            circular_slider_heat.value = circular_slider_heat.value - 0.5
                        }
                    }

                    if (cool_selection_btn.checked) {
                        if (circular_slider_cool.value - 0.5 <= circular_slider_cool.minValue) {
                            circular_slider_cool.value = circular_slider_cool.value - 0.5

                        }
                    }
                }
            }

            CursorRoundButton {
                id: button_up
                width: 38; height: 38
                enabled: cool_selection_btn.checked || heat_selection_btn.checked? true: false
                anchors.horizontalCenterOffset: 29
                anchors.horizontalCenter: parent.horizontalCenter

                background: Rectangle {
                    radius: 19
                    color: parent.enabled? parent.hovered? "#40101010": "#40000000": "#10000000"
                }

                contentItem: Image {
                    width: 38; height: 38
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    source: "../../../images/icons/chevron.up.svg"
                    anchors.bottomMargin: 14
                    anchors.topMargin: 14
                    anchors.rightMargin: 11
                    anchors.leftMargin: 11
                    fillMode: Image.PreserveAspectFit
                    opacity: parent.enabled? 1: 0.4
                }

                onPressed: {
                    if (heat_selection_btn.checked) {
                        if (circular_slider_heat.value + 0.5 <= circular_slider_heat.maxValue) {
                            circular_slider_heat.value = circular_slider_heat.value + 0.5
                        }
                    }

                    if (cool_selection_btn.checked) {
                        if (circular_slider_cool.value + 0.5 >= circular_slider_cool.maxValue) {
                            circular_slider_cool.value = circular_slider_cool.value + 0.5
                        }
                    }
                }
            }
        }
        Rectangle {
            id: display_info
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: buttons.bottom
            anchors.topMargin: 13
            anchors.rightMargin: 13
            anchors.leftMargin: 13
            height: 69
            color: "#40000000"
            radius: 10

            Image {
                id: thermometer_img
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.verticalCenterOffset: -10
                source: "../../../images/icons/thermometer.medium.svg"
                anchors.leftMargin: 21
                fillMode: Image.PreserveAspectFit
                width: 12; height: 12
            }

            Text {
                id: outside_temp_text
                color: "#7B7D7F"
                text: "Outside temperature:"
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -10
                anchors.left: thermometer_img.right
                anchors.leftMargin: 5
                font.pointSize: 12
            }

            Text {
                id: outside_temp_value
                color: "#FFF"
                text: "5°C"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: outside_temp_text.right
                anchors.leftMargin: 10
                anchors.verticalCenterOffset: -10
                font.pointSize: 14
            }

            Image {
                id: drop
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.verticalCenterOffset: 10
                source: "../../../images/icons/drop.fill.svg"
                anchors.leftMargin: 21
                fillMode: Image.PreserveAspectFit
                width: 10; height: 10
            }

            Text {
                id: inside_humidity_text
                color: "#7B7D7F"
                text: "Inside humidity:"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: outside_temp_text.left
                anchors.leftMargin: 0
                anchors.verticalCenterOffset: 10
                font.pointSize: 12
            }

            Text {
                id: inside_humidity_value
                color: "#FFF"
                text: "100%"
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 10
                anchors.horizontalCenter: outside_temp_value.horizontalCenter
                font.pointSize: 14
            }
        }

        CursorRoundButton {
            id: heat_mode_btn
            width: 62; height: 34;
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 13
            anchors.leftMargin: 13

            background: Rectangle {
                color: parent.hovered? "#40101010": "#40000000"
                radius: 10
            }

            contentItem: Image {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                source: parent.hovered? "../../../images/icons/heat_mode_hover.png": "../../../images/icons/heat_mode.png"
                anchors.rightMargin: parent.hovered? -3: 10.7
                anchors.leftMargin: parent.hovered? -3: 10.7
                anchors.bottomMargin: parent.hovered? -3: 10.7
                anchors.topMargin: parent.hovered? -3: 10.7
                fillMode: Image.PreserveAspectFit
            }
        }

        CursorRoundButton {
            width: 63; height: 34;
            anchors.left: heat_mode_btn.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 13
            anchors.leftMargin: 15

            background: Rectangle {
                color: parent.hovered? "#40101010": "#40000000"
                radius: 10
            }

            contentItem: Image {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                source: parent.hovered? "../../../images/icons/eco_mode_hover.png": "../../../images/icons/eco_mode.png"
                anchors.rightMargin: parent.hovered? -3: 10.7
                anchors.leftMargin: parent.hovered? -3: 10.7
                anchors.bottomMargin: parent.hovered? -3: 10.7
                anchors.topMargin: parent.hovered? -3: 10.7
                fillMode: Image.PreserveAspectFit
            }
        }

        CursorRoundButton {
            width: 62; height: 34;
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 13
            anchors.rightMargin: 13

            background: Rectangle {
                id: bg_color
                color: parent.hovered? "#40101010": "#40000000"
                radius: 10
            }

            contentItem: Image {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    source: parent.hovered? "../../../images/icons/fan_mode_hover.png": "../../../images/icons/fan_mode.png"
                    anchors.rightMargin: parent.hovered? -3: 10.7
                    anchors.leftMargin: parent.hovered? -3: 10.7
                    anchors.bottomMargin: parent.hovered? -3: 10.7
                    anchors.topMargin: parent.hovered? -3: 10.7
                    fillMode: Image.PreserveAspectFit
            }

//            onClicked: {
//                bg_color.color = "#fff"
//            }
//            onReleased: {
//                bg_color.color = "#40000000"
//            }
        }
    }
}
