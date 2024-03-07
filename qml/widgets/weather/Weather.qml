import QtQuick 2.15
import QtQuick.Layouts 1.15

Item {
    id: weather_widget
    implicitWidth: parent.width
    implicitHeight: parent.height

    Image {
        source: "../../../images/weather/801d.svg";
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 39
        fillMode: Image.PreserveAspectFit
        width: 84
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
    }

    ColumnLayout {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        spacing: 0
        anchors.bottomMargin: 20
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter

            Text {
                id: city_name
                color: "#ffffff"
                text: "VANCOUVER, BC"
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                //            Layout.topMargin: 15
                //            anchors.top: parent.top
    //            anchors.topMargin: 28
    //            anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 18
                font.styleName: "Light"
            }

            Text {
                id: current_weather
                color: "#7B7D7F"
                text: "Mostly cloudy"
                Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
    //            Layout.bottomMargin: 15
    //            anchors.left: city_name.left
    //            anchors.bottom: parent.bottom
    //            anchors.leftMargin: 0
    //            anchors.bottomMargin: 28
                font.pointSize: 12
            }
    }

    ColumnLayout {
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        spacing: 0
        anchors.topMargin: 14
        anchors.bottomMargin: 20
        anchors.rightMargin: 38

        Text {
            id: current_temp
            color: "#ffffff"
            text: "5°C"
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
//            Layout.topMargin: 15
//            anchors.right: parent.right
//            anchors.top: parent.top
//            anchors.rightMargin: 38
//            anchors.topMargin: 18
            font.pointSize: 40
            font.styleName: "Thin"
        }

        Text {
            id: min_max_temp
            color: "#7B7D7F"
            text: "H:12° L:2°"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            //            Layout.bottomMargin: 30
//            anchors.left: current_temp.left
//            anchors.bottom: parent.bottom
//            anchors.leftMargin: 0
//            anchors.bottomMargin: 20
            font.pointSize: 12
        }
    }

//    Text {
//        id: current_weather_text
//        color: "#7B7D7F"
//        text: "Mostly cloudy"
//        anchors.left: city_name.left
//        anchors.bottom: parent.bottom
//        anchors.leftMargin: 0
//        anchors.bottomMargin: 28
//        font.pointSize: 12
//    }
}
