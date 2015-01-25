import QtQuick 2.0
import Sailfish.Silica 1.0

//TODO let user decide about visual number precission/format

Page {
    property int showDigits: 2

    id: page

    SilicaListView {
        id: listView
        anchors.fill: parent
        property Item contextMenu : contextMenuComponent.createObject(listView)

        VerticalScrollDecorator {}

        PullDownMenu {
            MenuItem {
                text: qsTr("Add Entry")
                onClicked: {
                    var dialog = pageStack.push("EditItem.qml")
                    dialog.accepted.connect(function() {
                        list.add(dialog.name, dialog.value);
                    })
                }
            }
        }

        header : PageHeader {
            width: parent.width
            title: "∑ = " + list.value.toFixed(showDigits)
        }

        model: list

        delegate: Item {
            id: myListItem
            property bool menuOpen: listView.contextMenu != null && listView.contextMenu.parent === myListItem

            width: ListView.view.width
            height: menuOpen ? listView.contextMenu.height + contentItem.height : contentItem.height

            BackgroundItem {
                id: contentItem
                width: parent.width
                Label {
                    anchors.left: parent.left
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.verticalCenter: parent.verticalCenter
                    text: name
                    color: myListItem.highlighted ? Theme.highlightColor
                                                : Theme.primaryColor
                }
                Label {
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.paddingLarge
                    anchors.verticalCenter: parent.verticalCenter
                    text: value.toFixed(showDigits)
                }
                onClicked: {
                    var dialog = pageStack.push("EditItem.qml", {name: name, value: value});
                    dialog.accepted.connect(function() {
                        name = dialog.name;
                        value = dialog.value;
                    })
                }
                onPressAndHold: {
                    listView.contextMenu.current = model
                    listView.contextMenu.show(myListItem)
                }
            }
        }
        Component {
            id: contextMenuComponent
            ContextMenu {
                property QtObject current
                MenuItem {
                    text: qsTr("Delete")
                    onClicked: {
                        listView.model.remove(current.index)
                    }
                }
            }
        }
    }
}
