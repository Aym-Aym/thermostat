import QtQuick 2.15
import QtQuick.Controls 2.15

RoundButton {
    MouseArea {
        cursorShape: Qt.PointingHandCursor
        id: mouseArea
        anchors.fill: parent
        onPressed: mouse => {
            mouse.accepted = false
        }
    }
}
