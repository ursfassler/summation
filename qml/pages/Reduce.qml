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

Dialog {

    id: dialog

    property string reduceText
    property int reduceMethod: -1
    property real sumValue
    property string sumText

    Column {
        width: parent.width

        DialogHeader {
            id: header
            acceptText: reduceText
            title: "Select reduce method"
        }

        Button {
            id: reduceDelete
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Delete all"
            onClicked: {
                reduceText = text;
                reduceMethod = 0;
            }
        }

        Button {
            id: reduceSum
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Sum: " + list.value.toFixed(2)
            onClicked: {
                var dialog = pageStack.push("EditItem.qml", {name:"∑", value: list.value});
                dialog.accepted.connect(function() {
                    reduceText = dialog.name + ": " + dialog.value;
                    reduceMethod = 1;
                    sumText = dialog.name;
                    sumValue = dialog.value;
                })
            }
        }

    }

    onDone: {
        if (result === DialogResult.Accepted) {
            switch(reduceMethod){
            case 0:
                list.clear();
                break;
            case 1:
                list.replace(sumText, sumValue);
                break;
            }

            name = nameField.text
            value = Number(valueField.text.replace(',','.'));   // localization seems to be broken
        }
    }
}
