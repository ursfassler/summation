import QtQuick 2.0
import Sailfish.Silica 1.0

//TODO let user decide about visual number precission/format
//TODO let user rename list
//TODO let user delete items
//TODO let user modify items

Page {
    property int showDigits: 2

    id: page

    SilicaListView {
        anchors.fill: parent

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

        delegate: BackgroundItem {
            x: Theme.paddingLarge
            width: ListView.view.width-2*Theme.paddingLarge
            height: Theme.itemSizeSmall
            Label {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: name
            }
            Label {
                anchors.right: parent.right
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
        }
    }
}
