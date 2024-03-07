import QtQuick 2.15
import QtQuick.Layouts 1.15

Item {
    id: weather_widget
    implicitWidth: parent.width
    implicitHeight: parent.height

    Image {
        source: "../../../images/icons/server_status.svg";
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 35
        fillMode: Image.PreserveAspectFit
        width: 45
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
    }

    Text {
        id: city_name
        color: "#ffffff"
        text: "AYMSERVER"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: current_status.left
        anchors.verticalCenterOffset: -17
        anchors.leftMargin: 0
        //            Layout.topMargin: 15
        //            anchors.top: parent.top
//            anchors.topMargin: 28
//            anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: 18
        font.styleName: "Light"
    }

    Text {
        id: current_status
        color: "#7B7D7F"
        text: "Status: <font color='lime'>ONLINE</font>"
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 3
        anchors.horizontalCenter: parent.horizontalCenter
        //            Layout.bottomMargin: 15
//            anchors.left: city_name.left
//            anchors.bottom: parent.bottom
//            anchors.leftMargin: 0
//            anchors.bottomMargin: 28
        font.pointSize: 12
    }

    Text {
        id: current_uptime
        color: "#7B7D7F"
        text: "Uptime: 2d, 03:15:42"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: current_status.left
        anchors.verticalCenterOffset: 20
        anchors.leftMargin: 0
        //            Layout.bottomMargin: 15
        //            anchors.left: city_name.left
//            anchors.bottom: parent.bottom
//            anchors.leftMargin: 0
//            anchors.bottomMargin: 28
        font.pointSize: 12
    }

    Image {
        source: "../../../images/icons/power.circle.fill.on.svg";
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        anchors.rightMargin: 35
        fillMode: Image.PreserveAspectFit
        width: 40
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
    }
}
