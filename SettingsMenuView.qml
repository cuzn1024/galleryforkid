import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4

Rectangle {
    ListView {
        id: commonSettingsView
        anchors.top: parent.top
        height: count * root.height * 0.125
        model: ListModel {
            ListElement {
                title: "Home"
            }
            ListElement {
                title: "Profile"
            }
            ListElement {
                title: "Add"
            }
        }

        delegate: Button {
            width: root.width
            height: root.height * 0.125
            text: title

            style: BlackButtonStyle {
                fontColor: root.darkFontColor
                rightAlignedIconSource: "qrc:/images/icon-go.png"
            }

            onClicked: {
                switch (index)
                {
                case 2:
                    popup.visible = true;
                    break;
                }
            }
        }
    }

    Rectangle {
        id: popup
        color: "gray"
        width: 300
        height: 300
        x: (root.width - width) / 2
        y: (root.height - height) / 2
        z: 100
        opacity: 0.8
        visible: false

        GridLayout {
            id: popupGridLayout
            columns: 2
            rows: 2
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 5
            columnSpacing: 2
            rowSpacing: 2

            Label {
                id: userName
                Layout.fillWidth: true
                Layout.fillHeight: true
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                text: "user name *"
            }

            TextField {
                id: txtUserName
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Label {
                id: password
                Layout.fillWidth: true
                Layout.fillHeight: true
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                text: "password *"
            }

            TextField {
                id: txtPassword
                Layout.fillWidth: true
                Layout.fillHeight: true
                echoMode: TextInput.PasswordEchoOnEdit
            }
        }

        Row {
//            anchors.top: popupGridLayout.bottom
            anchors.left: popupGridLayout.left
            anchors.right: popupGridLayout.right
            anchors.bottom: popup.bottom

            Button {
                id: addButton
                text: "Add"

                onClicked: {
                    gallery.createGallery("", "");
                }
            }

            Button {
                id: cancelButton
                text: "Cancel"
                onClicked: {
                    popup.visible = false
                }
            }
        }
    }

    Rectangle {
        id: separator
        anchors.top: commonSettingsView.bottom
        width: root.width
        height: root.height * 0.0625
        color: "#666"
    }

    ListView {
        id: sdkSettingsView
        anchors.top: separator.bottom
        anchors.bottom: root.bottom
        model: ListModel {
        }

        delegate: Button {
            width: root.width
            height: root.height * 0.125
            text: title

            style: BlackButtonStyle {
                fontColor: root.darkFontColor
                rightAlignedIconSource: "qrc:/images/icon-go.png"
            }

            onClicked: {
            }
        }
    }
}

