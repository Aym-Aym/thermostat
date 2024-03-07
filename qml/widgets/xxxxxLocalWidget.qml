import QtQuick 2.15

Item {
    id: widget

    property int rowSpanSize: 1
    property int columnSpanSize: 1

    MouseArea {
        id: mouseArea
        implicitWidth: widget_content.width
        implicitHeight: widget_content.height
        anchors.centerIn: parent
        onReleased: {
            parent = widget_content.Drag.target !== null ? widget_content.Drag.target: widget_content
            widget_content.Drag.drop()
        }
        drag.target: widget_content

        Rectangle {
            id: widget_content

            property int rowSpanSize: widget.rowSpanSize
            property int columnSpanSize: widget.columnSpanSize

            width: (253 * columnSpanSize) + (30 * (columnSpanSize - 1))
            height: (209 * rowSpanSize) + (30 * (rowSpanSize - 1))
            z: 10

            anchors {
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }
            color: "#cccccc"

            Drag.keys: [ "widget" ]
            Drag.active: mouseArea.drag.active
            Drag.hotSpot.x: 126.5
            Drag.hotSpot.y: 104.5

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
        }
    }
}
