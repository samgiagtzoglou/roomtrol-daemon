import Qt 4.6
import WesControl 1.0
Item {
    anchors.fill: parent
    anchors.horizontalCenter: parent.horizontalCenter

    Image {
        id: backgroundImage
        source: "images/background.png"
        height: 558
        width: 438
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
    }
    Volume {
        id: volumeController
        volume: sliderImage.level
    }
    Item {
        id: sliderContainer
        y: 20
        x: 368
        height: 465
        width: 16

        Image {
            property double level
            id: sliderImage
            y: 300
            level: (100-Math.round(y/(433) * 100 + 2.5))/100

            source: "images/slider.png"
            anchors.horizontalCenter: parent.horizontalCenter
            width: 32
            height: 51.4
        }
        MouseRegion {
            id: sliderMouseRegion
            anchors.fill: parent
            drag.target: sliderImage
            drag.axis: "y"
            drag.ymin: -sliderImage.height/2 + 14
            drag.ymax: parent.height - sliderImage.height/2 - 17
        }
    }

    MouseRegion {
        id: muteButtonArea
        y: 500
        width:69
        height: 31
        x: 343
        onClicked: {
            muteLightRect.state = muteLightRect.state == "" ? "muteOnState" : ""
        }
        Rectangle {
            id: muteLightRect
            color: "#E82725"
            opacity: 0.0
            opacity: SequentialAnimation {
                id: muteLightAnimation
                running: false
                repeat: true
                NumberAnimation {
                    to: 0.6
                    duration: 600
                }
                PauseAnimation { duration: 1000 }
                NumberAnimation {
                    to: 0.0
                    duration: 600
                }
            }
            height: 8.5
            width: 38
            y: 6
            radius: 3
            anchors.horizontalCenter: parent.horizontalCenter
            states: [
                State {
                    name: "muteOnState"
                    PropertyChanges {
                        target: muteLightAnimation
                        running: true
                    }
                    PropertyChanges {
                        target: muteLightRect
                        opacity: 0
                    }
                    PropertyChanges {
                        target: blurredSpeakerImage
                        opacity: 0
                    }
                }
            ]
        }
    }
    Image {
        id: blurredSpeakerImage
        width: 162
        height: 160
        y: 287
        x: 93
        source: "images/blurred_speaker.png"
        opacity: SequentialAnimation {
            running: muteLightRect.state != "muteOnState"
            repeat: true
            NumberAnimation { to: sliderImage.level; duration: 300 }
            NumberAnimation { to: 0; duration: 300 }
            PauseAnimation { duration: 400 }
            NumberAnimation { to: sliderImage.level; duration: 300 }
            NumberAnimation { to: 0; duration: 300 }
            PauseAnimation { duration: 400 }
            NumberAnimation {to: sliderImage.level; duration: 300 }
            PauseAnimation { duration: 100 }
            NumberAnimation {to: 0; duration: 300 }
        }
    }
}
