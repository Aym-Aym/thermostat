import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15
import Qt5Compat.GraphicalEffects

import "widgets"
import "components"

Window {
    id: main_window
    width: 1194
    height: 834
    visible: true

    LinearGradient {
        id: linearGradient
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        start: Qt.point(0, 0)
        end: Qt.point(parent.width, parent.height)
        gradient: Gradient {
                GradientStop {
                position: 0
                color: "#201D37"
            }
            GradientStop {
                position: 1
                color: "#3F2953"
            }
        }

        RadialGradient {
            anchors.fill: parent
            horizontalOffset: -400
            verticalOffset: -250
            horizontalRadius: 390
            verticalRadius: horizontalRadius
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#4DFFB1CD"
                }
                GradientStop {
                    position: 1
                    color: "#00FFB1CD"
                }
            }
        }

        RadialGradient {
            anchors.fill: parent
            horizontalOffset: 350
            verticalOffset: 150
            horizontalRadius: 800
            verticalRadius: horizontalRadius - 400
            angle: 60
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#66DA8AFF"
                }
                GradientStop {
                    position: 1
                    color: "#00DA8AFF"
                }
            }
        }

        Rectangle {
            id: main_container
            color: "#80000000"
            radius: 30
            anchors.fill: parent
            anchors.rightMargin: 15
            anchors.leftMargin: 15
            anchors.bottomMargin: 15
            anchors.topMargin: 15

            Image {
                id: logo_img_mask
                width: 52
                height: 32
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 30
                anchors.topMargin: 20
                source: "../images/logo.svg"
                enabled: false
                visible: false
            }

            Rectangle {
                id: logo_color
                anchors.fill: logo_img_mask
                color: "#C3AEFF"
                visible: false
            }

            OpacityMask {
                id: logo_mask
                anchors.fill: logo_color
                source: logo_color
                maskSource: logo_img_mask
            }

            Text {
                id: app_title
                color: "#C3AEFF"
                text: "HOME DASHBOARD"
                anchors.left: logo_img_mask.right
                anchors.bottom: logo_img_mask.bottom
                font.pointSize: 20
                font.styleName: "UltraLight"
                anchors.bottomMargin: 0
                anchors.leftMargin: 20
            }

//            Rectangle {
//                color: "red"
//                anchors.left: parent.left
//                anchors.top: logo_img_mask.bottom
//                anchors.leftMargin: 30
//                anchors.topMargin: 30

//                width: 1104
//                height: 688
//            }

            GridLayout {
                id: widget_gridlayout
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: logo_img_mask.bottom
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 30
                anchors.topMargin: 30
                anchors.rightMargin: 30
                anchors.leftMargin: 30
                rowSpacing: 30
                columnSpacing: 30
                layoutDirection: Qt.LeftToRight
                flow: GridLayout.LeftToRight
                rows: 3
                columns: 4

                DropWidget {
                    key: "widget"
                    Layout.rowSpan: thermostat_widget.rowSpanSize
                    implicitHeight: thermostat_widget.height

                    LocalWidget {
                        id: thermostat_widget
//                        rowSpanSize: 2
                    }
                }

                DropWidget {
                    key: "widget2"
                }

                DropWidget {
                    key: "widget"
                    Layout.rowSpan: thermostat_widget2.rowSpanSize
                    implicitHeight: thermostat_widget2.height

                    LocalWidget {
                        id: thermostat_widget2
//                        rowSpanSize: 2
                    }
                }

                DropWidget {
                    key: "widget"
                }

                DropWidget {
                    key: "widget"
                }

                DropWidget {
                    key: "widget"
                }

                DropWidget {
                    key: "widget"
                }

                DropWidget {
                    key: "widget"
                }

                DropWidget {
                    key: "widget"
                }

                DropWidget {
                    key: "widget"
                }

                DropWidget {
                    key: "widget"
                }

                DropWidget {
                    key: "widget"
                }
            }
        }
    }
}
