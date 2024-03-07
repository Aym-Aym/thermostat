import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15
import Qt5Compat.GraphicalEffects
import QtQuick.Shapes 2.15

import "widgets/thermostat"
import "widgets/weather"
import "widgets/server_status"
import "components"

Window {
    id: main_window
    width: 1194
    height: 834
    maximumHeight: height
    maximumWidth: width
    minimumHeight: height
    minimumWidth: width
    visible: true

    Image {
        id: window_bg
        x: -4
        y: 0
        source: "../images/bg.svg"
        fillMode: Image.PreserveAspectFit

        Image {
            id: content_bg
            x: 83
            y: 0
            source: "../images/content_bg.png"
            fillMode: Image.PreserveAspectFit

            ColumnLayout {
                id: main_layout

                property string shadowColor: "#25000000"
                property int shadowVerticalOffset: 5

                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 46
                anchors.topMargin: 59

                RowLayout {
                    layoutDirection: Qt.LeftToRight
                    Layout.fillHeight: false
                    Layout.fillWidth: false
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    spacing: 19

                    Item {
                        id: server_widget

                        implicitWidth: childrenRect.width
                        implicitHeight: childrenRect.height

                        Image {
                            id: server_bg
                            source: "../images/server_bg.png"
                            fillMode: Image.PreserveAspectFit

                            ServerStatus {

                            }
                        }

                        DropShadow {
                            anchors.fill: server_bg
                            horizontalOffset: 0
                            verticalOffset: main_layout.shadowVerticalOffset
                            radius: 10
                            samples: 17
                            color: main_layout.shadowColor
                            source: server_bg
                        }
                    }

                    Item {
                        id: weather_widget

                        implicitWidth: childrenRect.width
                        implicitHeight: childrenRect.height

                        Image {
                            id: weather_bg
                            source: "../images/weather_bg.png"
                            fillMode: Image.PreserveAspectFit

                            Weather {

                            }
                        }

                        DropShadow {
                            anchors.fill: weather_bg
                            horizontalOffset: 0
                            verticalOffset: main_layout.shadowVerticalOffset
                            radius: 10
                            samples: 17
                            color: main_layout.shadowColor
                            source: weather_bg
                        }
                    }

                    Item {
                        width: 147
                        Layout.topMargin: 16
                        Layout.leftMargin: 13
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

                        ColumnLayout {
                            Text {
                                id: time_txt
                                color: "#ffffff"
                                text: qsTr("05:58PM")
                                horizontalAlignment: Text.AlignLeft
                                font.styleName: "Thin"
                                font.pointSize: 35
                            }
                            Text {
                                id: date_txt
                                color: "#7b7d7f"
                                text: qsTr("Saturday, September 23")
                                horizontalAlignment: Text.AlignLeft
                                Layout.topMargin: -3
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                font.styleName: "Light"
                                font.pointSize: 12
                            }
                        }
                    }
                }

                RowLayout {
                    Layout.topMargin: 46
                    layoutDirection: Qt.LeftToRight
                    Layout.fillHeight: false
                    Layout.fillWidth: false
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    spacing: 19

                    Thermostat {
                        id: thermostat_widget

//                        DropShadow {
//                            anchors.fill: thermostat_widget
//                            horizontalOffset: 0
//                            verticalOffset: main_layout.shadowVerticalOffset
//                            radius: 10
//                            samples: 17
//                            color: main_layout.shadowColor
//                            source: thermostat_widget
//                        }
                    }

                    Item {
                        id: sensors_widget
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop

                        implicitWidth: childrenRect.width
                        implicitHeight: childrenRect.height

                        Image {
                            id: sensors_bg
                            source: "../images/home_sensors_bg.png"
                            fillMode: Image.PreserveAspectFit
                        }

                        DropShadow {
                            anchors.fill: sensors_bg
                            horizontalOffset: 0
                            verticalOffset: main_layout.shadowVerticalOffset
                            radius: 10
                            samples: 17
                            color: main_layout.shadowColor
                            source: sensors_bg
                        }
                    }

                    Item {
                        id: wifi_devices_widget

                        implicitWidth: childrenRect.width
                        implicitHeight: childrenRect.height

                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop

                        Image {
                            id: wifi_devices_bg
                            source: "../images/wifi_devices_bg.png"
                            fillMode: Image.PreserveAspectFit
                        }

                        DropShadow {
                            anchors.fill: wifi_devices_bg
                            horizontalOffset: 0
                            verticalOffset: main_layout.shadowVerticalOffset
                            radius: 10
                            samples: 17
                            color: main_layout.shadowColor
                            source: wifi_devices_bg
                        }
                    }
                }
            }
        }
    }
}
