import QtQuick 2.15
import Qt5Compat.GraphicalEffects

Item {
    id: thermostat_widget

    MouseArea {
        id: mouseArea

        width: widget_background.width
        height: widget_background.height
        anchors.centerIn: parent

        drag.target: widget_content

        onReleased: parent = widget_content.Drag.target !== null ? widget_content.Drag.target : thermostat_widget

        Item {
            id: widget_content

            Drag.keys: ["widgets"]
            Drag.active: mouseArea.drag.active

            Drag.hotSpot.x: 250
            Drag.hotSpot.y: 400
            states: State {
                when: mouseArea.drag.active
                AnchorChanges {
                    target: widget_content
                    anchors {
                        verticalCenter: undefined
                        horizontalCenter: undefined
                    }
                }
            }

            Rectangle {
                id: widget_background
                width: 250
                height: 400
                color: "#382f54"
                radius: 30

                clip: false

                Rectangle {
                    id: widget_right_corner
                    width: 30
                    height: 30
                    color: "#382F54"
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.rightMargin: 0
                }


                RadialGradient {
                    anchors.fill: parent
                    horizontalOffset: -105
                    verticalOffset: -180
                    horizontalRadius: 250
                    verticalRadius: horizontalRadius
                    gradient: Gradient {
                        GradientStop {
                            position: 0
                            color: "#8771C8"
                        }
                        GradientStop {
                            position: 1
                            color: "#008771C8"
                        }
                    }
                }

                LinearGradient {
                    anchors.fill: parent
                    start: Qt.point(0, 0)
                    end: Qt.point(0, parent.height)
                    gradient: Gradient {
                        GradientStop {
                            position: 0
                            color: "#0038264D"
                        }
                        GradientStop {
                            position: 0.75
                            color: "#0038264D"
                        }
                        GradientStop {
                            position: 1
                            color: "#8038264D"
                        }
                    }
                }
            }
        }
    }
}
