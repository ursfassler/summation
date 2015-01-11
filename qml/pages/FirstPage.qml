import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    SilicaListView {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: "Option 1"
                onClicked: console.log("Clicked option 1")
            }
            MenuItem {
                text: "Option 2"
                onClicked: console.log("Clicked option 2")
            }
        }

        header : BackgroundItem {
            Label {
                anchors.left: parent.left
                width: parent.width/2
                text: "Name"
            }
            Label {
                anchors.right: parent.right
                width: parent.width/2
                text: "Value"
            }
        }

        model: list
        /*
        ListModel {
            ListElement { name: "jackfruit"; value: 1.0 }
            ListElement { name: "orange"; value: 1.0 }
            ListElement { name: "lemon"; value: 1.0 }
            ListElement { name: "lychee"; value: 1.0 }
            ListElement { name: "apricots"; value: 1.0 }
            ListElement { name: "jackfruit"; value: 1.0 }
            ListElement { name: "orange"; value: 1.0 }
            ListElement { name: "lemon"; value: 1.0 }
            ListElement { name: "lychee"; value: 1.0 }
            ListElement { name: "apricots"; value: 1.0 }
            ListElement { name: "jackfruit"; value: 1.0 }
            ListElement { name: "orange"; value: 1.0 }
            ListElement { name: "lemon"; value: 1.0 }
            ListElement { name: "lychee"; value: 1.0 }
            ListElement { name: "apricots"; value: 1.0 }
        }
        */
        delegate: BackgroundItem {
            width: ListView.view.width
            height: Theme.itemSizeSmall

            TextField {
                anchors.left: parent.left
                width: parent.width/2
                text: name
            }

            TextField {
                anchors.right: parent.right
                width: parent.width/2
                text: value

                inputMethodHints: Qt.ImhFormattedNumbersOnly
            }
        }
    }
}
