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
    property string name
    property real value

    id: dialog

    Column {
        width: parent.width

        DialogHeader { }

        TextField {
            id: nameField
            width: parent.width
            placeholderText: qsTr("Name")
            label:  qsTr("Name")
            text: name
            EnterKey.onClicked: valueField.focus = true
        }
        TextField {
            id: valueField
            width: parent.width
            placeholderText: qsTr("Value")
            label:  qsTr("Value")
            text: value !== 0 ? value.toFixed(2) : ""
            inputMethodHints: Qt.ImhFormattedNumbersOnly
            horizontalAlignment: TextInput.AlignRight
            validator: DoubleValidator {}
            EnterKey.onClicked: dialog.accept()
        }
    }

    onOpened: {
        nameField.forceActiveFocus();
    }

    onDone: {
        if (result === DialogResult.Accepted) {
            name = nameField.text
            value = Number(valueField.text.replace(',','.'));   // localization seems to be broken
        }
    }
}
