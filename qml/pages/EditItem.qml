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
            text: value.toFixed(2)
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
        if (result == DialogResult.Accepted) {
            name = nameField.text
            value = Number(valueField.text.replace(',','.'));   // localization seems to be broken
        }
    }
}
