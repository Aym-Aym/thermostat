import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Shapes 1.5

Window {
    width: 1920
    height: 1080
    visible: true
    title: qsTr("Hello World")

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#00b9ff"
            }

            GradientStop {
                position: 1
                color: "#7dd8ff"
            }
            orientation: Gradient.Horizontal
        }

        Item {
            id: widget_thermostat
            x: 25
            y: 25
            width: 250
            height: 400

            Rectangle {
                id: rectangle1
                radius: 10
                anchors.fill: parent

                gradient: Gradient {
                    GradientStop {
                        position: 0
                        color: "#0d000000"
                    }

                    GradientStop {
                        position: 0.76712
                        color: "#0d000000"
                    }

                    GradientStop {
                        position: 1
                        color: "#33000000"
                    }

                    orientation: Gradient.Vertical
                }

                Text {
                    id: name
                    color: "#ffffff"
                    text: qsTr("THERMOSTAT")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    horizontalAlignment: Text.AlignHCenter
                    anchors.topMargin: 10
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    font.family: "Arial"
                    font.bold: true
                }

                Item {
                    id: ac
                    width: 250
                    height: 250
                    anchors.top: name.bottom
                    anchors.topMargin: 0
                    clip: false

                    Shape {
                        anchors.fill: parent
                        layer.enabled: true
                        smooth: true
                        layer.samples: 8

                        ShapePath {
                            id: ac_background
                            fillColor: "#00000000"
                            strokeColor: "#1a000000"
                            strokeWidth: 10
                            capStyle: ShapePath.RoundCap

                            PathAngleArc {
                                centerX: 250 / 2
                                centerY: 250 / 2
                                radiusX: (250 - ac_background.strokeWidth) / 2 - 20
                                radiusY: (250 - ac_background.strokeWidth) / 2 - 20
                                startAngle: 120
                                sweepAngle: 360 - ((this.startAngle - 90) * 2)
                            }
                        }

                        ShapePath {
                            id: ac_cool
                            fillColor: "#00000000"
                            strokeColor: "#72aee1"
                            strokeWidth: 10
                            capStyle: ShapePath.RoundCap

                            PathAngleArc {
                                centerX: 250 / 2
                                centerY: 250 / 2
                                radiusX: (250 - ac_background.strokeWidth) / 2 - 20
                                radiusY: (250 - ac_background.strokeWidth) / 2 - 20
                                startAngle: 60
                                sweepAngle: -100
                            }
                        }

                        ShapePath {
                            id: ac_heat
                            fillColor: "#00000000"
                            strokeColor: "#e37070"
                            strokeWidth: 10
                            capStyle: ShapePath.RoundCap

                            PathAngleArc {
                                centerX: 250 / 2
                                centerY: 250 / 2
                                radiusX: (250 - ac_background.strokeWidth) / 2 - 20
                                radiusY: (250 - ac_background.strokeWidth) / 2 - 20
                                startAngle: 120
                                sweepAngle: 180 - ((this.startAngle - 90) * 2)
                            }
                        }
                    }

                    Shape {
                        anchors.fill: parent
                        ShapePath {
                            strokeColor: "#ffffff"
                            strokeWidth: 2
                            startX: 125; startY: 32
                            PathLine { x: 125; y: 18 }
                            capStyle: ShapePath.RoundCap
                        }
                        transform: Rotation {
                            origin.x: 125
                            origin.y: 125
                            angle: 15
                        }
                    }

                    Rectangle {
                        id: rectangle2
                        radius: 180
                        width: 160
                        height: 160
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: "#1a000000"

                        Text {
                            id: heat_text
                            color: "#ffffff"
                            text: qsTr("20.5°C")
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.weight: Font.Light
                            font.pointSize: 25
                            font.family: "Arial"
                            font.bold: true

                            Text {
                                width: parent.width / 2
                                visible: true
                                color: "#ffffff"
                                text: qsTr("20.5°C")
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.bottom: parent.bottom
                                horizontalAlignment: Text.AlignRight
                                clip: false
                                state: ""
                                anchors.leftMargin: -5
                                anchors.bottomMargin: 40
                            }

                            Text {
                                width: parent.width / 2
                                color: "#ffffff"
                                text: qsTr("20.5°C")
                                anchors.right: parent.right
                                anchors.bottom: parent.bottom
                                horizontalAlignment: Text.AlignLeft
                                anchors.rightMargin: -5
                                anchors.bottomMargin: 40
                            }
                        }
                    }



                    Rectangle {
                        id: rectangle
                        width: 20
                        height: 20
                        radius: 180
                        z: 1
                        color: "#ffffff"
                        x: getCircleX(200 + 120, 105 - (ac_cool.strokeWidth / 2)) + (ac.width / 2) - width / 2
                        y: getCircleY(200 + 120, 105 - (ac_cool.strokeWidth / 2)) + (ac.height / 2) - height / 2

                        function getCircleX(degree, radius) {
                            return Math.cos(degree * (Math.PI/180)) * radius;
                        }

                        function getCircleY(degree, radius) {
                            return Math.sin(degree * (Math.PI/180)) * radius;
                        }

                        Rectangle {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: 14
                            height: 14
                            radius: 180
                            color: "#dadada"
                        }
                    }


                    Rectangle {
                        width: 20
                        height: 20
                        radius: 180
                        z: 1
                        color: "#ffffff"
                        x: getCircleX(120 + 120, 105 - (ac_cool.strokeWidth / 2)) + (ac.width / 2) - width / 2
                        y: getCircleY(120 + 120, 105 - (ac_cool.strokeWidth / 2)) + (ac.height / 2) - height / 2

                        function getCircleX(degree, radius) {
                            return Math.cos(degree * (Math.PI/180)) * radius;
                        }

                        function getCircleY(degree, radius) {
                            return Math.sin(degree * (Math.PI/180)) * radius;
                        }

                        Rectangle {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: 14
                            height: 14
                            radius: 180
                            color: "#dadada"
                        }
                    }
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.1;height:1080;width:1920}
}
##^##*/
