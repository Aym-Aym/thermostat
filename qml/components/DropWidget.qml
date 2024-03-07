import QtQuick 2.15
import QtQuick.Layouts 2.15
import QtQuick.Shapes 2.15

DropArea {
    id: dragTarget

    property string key

    height: 209
    width: 253
    keys: [key]
    z: -1

//    console.log(dragTarget.containsDrag)

    onEntered: function(drag) {
        console.log(dragTarget.containsDrag)

        var dragRowSpanSize = drag.source.rowSpanSize
        var dragColumnSpanSize = drag.source.columnSpanSize
        var rowCount = parent.rows - 1

        if (rowCount !== Layout.row) {
            Layout.rowSpan = dragRowSpanSize
            implicitHeight = (209 * dragRowSpanSize) + (30 * (dragRowSpanSize - 1))
            implicitWidth = (253 * dragColumnSpanSize) + (30 * (dragColumnSpanSize - 1))
        }
    }

    onExited: {
        Layout.rowSpan = 1
        implicitHeight = 209
        implicitWidth = 253
//        dragTarget.keys = [key]
    }

    onDropped: function(drag){
        var dragRowSpanSize = drag.source.rowSpanSize
        var dragColumnSpanSize = drag.source.columnSpanSize

        Layout.rowSpan = dragRowSpanSize
        implicitHeight = (209 * dragRowSpanSize) + (30 * (dragRowSpanSize - 1))
        implicitWidth = (253 * dragColumnSpanSize) + (30 * (dragColumnSpanSize - 1))

//        dragTarget.keys = ["in_use"]
    }

    Rectangle {
        id: dropRectangle
        anchors.fill: parent
        color: dragTarget.containsDrag? "blue": "red"
        Layout.alignment: Qt.AlignTop
    }
}
