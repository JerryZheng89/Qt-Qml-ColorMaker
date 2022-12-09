import QtQuick 2.0
import QtQuick.Window 2.15
import QtQuick.Controls
import an.qt.ColorMaker 1.0


Window {
    width: 360
    height: 360
    visible: true
    //color: "gray";
    title: qsTr("Hello World")

    ColorMaker {
        id: colorMaker;
        color: Qt.green;
    }

//    Rectangle {
//        width: 360;
//        height: 360;
//        //color: "gray"
        Text {
            id: timeLabel;
            anchors.left: parent.left;
            anchors.leftMargin: 4;
            anchors.top: parent.top;
            anchors.topMargin: 4;
            font.pixelSize: 26;
        }


        Rectangle {
            id: colorRect;
            anchors.centerIn: parent;
            width: 200;
            height: 200;
            color: "blue";
        }

        Button {
            id: start;
            text: "start";

            anchors.left: parent.left;
            anchors.leftMargin: 4;
            anchors.bottom: parent.bottom;
            anchors.bottomMargin: 4;
            background: Rectangle{
                color:"gray";
            }
            onClicked: {
                colorMaker.start();
            }
        }
        Button {
            id: stop;
            text: "stop";
            background: Rectangle{
                color:"gray";
            }
            anchors.left: start.right;
            anchors.leftMargin: 4;
            anchors.bottom: start.bottom;
            onClicked: {
                colorMaker.stop();
            }
        }



        Button {
            id: colorAlgorithm;
            text: "RandomRGB";
            background: Rectangle{
                color:"gray";
            }
            anchors.left: stop.right;
            anchors.leftMargin: 4;
            anchors.bottom: start.bottom;

            function changeAlgorithm(button, algorithm){
                switch(algorithm)
                {
                case 0:
                    button.text = "RandomRGB";
                    break;
                case 1:
                    button.text = "RandomRed";
                    break;
                case 2:
                    button.text = "RandomGreen";
                    break;
                case 3:
                    button.text = "RandomBlue";
                    break;
                case 4:
                    button.text = "LinearIncrease";
                    break;
                }
            }

            onClicked: {
                var algorithm = (colorMaker.algorithm() + 1) % 5;
                changeAlgorithm(colorAlgorithm, algorithm);
                colorMaker.setAlgorithm(algorithm);
            }
        }

        Button {
            id: quit;
            text: "quit";
            background: Rectangle{
                color:"gray";
            }
            anchors.left: colorAlgorithm.right;
            anchors.leftMargin: 4;
            anchors.bottom: start.bottom;
            onClicked: {
                Qt.quit();
            }
        }

        Component.onCompleted: {
            colorMaker.color = Qt.rgba(0,180,120, 255);
            colorMaker.setAlgorithm(ColorMaker.LinearIncrease);
            changeAlgorithm(colorAlgorithm, colorMaker.algorithm());
        }

        Connections {
            target: colorMaker;
            function onCurrentTime(strTime) {
                timeLabel.text = strTime;
                timeLabel.color = colorMaker.timeColor;
            }
        }

        Connections {
            target: colorMaker;
            function onColorChanged(color) {
                colorRect.color = color;
            }
        }

//    }
}
