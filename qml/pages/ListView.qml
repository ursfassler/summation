/**
 *  This file is part of Summation.
 *
 *  Summation is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  Summation is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Summation.  If not, see <http://www.gnu.org/licenses/>.
 */

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
