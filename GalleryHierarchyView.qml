import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

    ListView {
        id: commonSettingsView
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

