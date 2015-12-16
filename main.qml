import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

Window {
    id: root
    objectName: "window"
    visible: true
    width: 480
    height: 800

    color: "#161616"
    title: "Gallery for kid"

    function toPixels(percentage) {
        return percentage * Math.min(root.width, root.height);
    }

    property bool isScreenPortrait: height > width
    property color lightFontColor: "#222"
    property color darkFontColor: "#e7e7e7"
    readonly property color lightBackgroundColor: "#cccccc"
    readonly property color darkBackgroundColor: "#161616"

    Text {
        id: textSingleton
    }

    MainToolbar {
        id: toolbar
    }

    Label {
        id: title
        text: root.title
        color: "white"
        height: root.height * 0.125
        font.pixelSize: Math.max(textSingleton.font.pixelSize, root.toPixels(0.04))
        font.family: openSans.name
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    FontLoader {
        id: openSans
        source: "qrc:/fonts/OpenSans-Regular.ttf"
    }

    property Component settingsMenu: SettingsMenuView {
    }

    StackView {
        id: stackView
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: toolbar.bottom

        initialItem: GalleryHierarchyView {
        }
    }
}

