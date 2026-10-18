import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Calculadora

ApplicationWindow {
    id: window
    width: 680
    height: 540
    minimumWidth: 480
    minimumHeight: 500
    visible: true
    title: "Copland OS Enterprise v1.0.5 - [ Calculator ]"

    // 🌌 1. Wallpaper de Fundo (com overlay escuro transparente)
    background: Item {
        Image {
            anchors.fill: parent
            source: "Images/wallpaper.jpg"
            fillMode: Image.PreserveAspectCrop
        }

        Rectangle {
            anchors.fill: parent
            color: "#b0000000" // Opacidade para destacar as janelas do Copland OS
        }
    }

    Calculadora {
        id: display_calculadora
    }

    // --- CORES DO COPLAND OS ---
    readonly property color cyanMain: "#00d8d8"
    readonly property color cyanDim: "#007777"
    readonly property color bgSolid: "#f0000000"

    // --- COMPONENTE DE BOTÃO RETRÔ COPLAND OS ---
    component CoplandButton: Button {
        id: btn
        property color borderCol: cyanMain
        property color textCol: cyanMain
        property bool filled: false

        implicitHeight: 38
        Layout.fillWidth: true
        // FORÇA LARGURA IGUAL PARA TODAS AS COLUNAS DO GRIDLAYOUT
        Layout.preferredWidth: Layout.columnSpan

        contentItem: Text {
            text: btn.text
            font.family: "Courier New"
            font.pixelSize: 15
            font.bold: true
            color: btn.down ? "#000000" : (btn.filled ? "#000000" : btn.textCol)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        background: Rectangle {
            color: btn.down ? cyanMain : (btn.filled ? cyanMain : (btn.hovered ? "#3300d8d8" : "#cc000000"))
            border.color: btn.borderCol
            border.width: 1
            radius: 0 // Cantos retos afiados
        }
    }

    // --- ESTRUTURA DA INTERFACE ---
    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // 🟢 BARRA SUPERIOR (HEADER)
        Rectangle {
            Layout.fillWidth: true
            height: 28
            color: bgSolid

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                spacing: 10

                Text { text: "☤"; font.pixelSize: 14; color: cyanMain }
                Text { text: "Status"; font.family: "Courier New"; font.pixelSize: 12; color: cyanMain }
                Text { text: "|"; color: cyanDim }
                Text { text: "Navi Pass"; font.family: "Courier New"; font.pixelSize: 12; color: cyanMain }
                Text { text: "|"; color: cyanDim }
                Text { text: "About"; font.family: "Courier New"; font.pixelSize: 12; color: cyanMain }

                Item { Layout.fillWidth: true }

                Text { text: "Copland OS v6.0"; font.family: "Courier New"; font.pixelSize: 11; color: cyanDim }
            }

            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 1
                color: cyanMain
            }
        }

        // 🟢 ÁREA CENTRAL (DESKTOP + JANELA DA CALCULADORA)
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            // Marca d'água no centro
            Column {
                anchors.centerIn: parent
                spacing: 5

                Text {
                    text: "Copland OS Enterprise"
                    font.family: "Courier New"
                    font.pixelSize: 32
                    font.bold: true
                    color: cyanMain
                    opacity: 0.20
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Text {
                    text: "Product by Tachibana Lab"
                    font.family: "Courier New"
                    font.pixelSize: 15
                    color: "#a000a0"
                    opacity: 0.30
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            // Janela da Calculadora
            Rectangle {
                width: Math.min(parent.width - 40, 360)
                height: 410
                anchors.centerIn: parent
                color: "#e6000000" // Fundo semi-transparente para ver o wallpaper
                border.color: cyanMain
                border.width: 1

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 0

                    // Barra de Título [ □ ][ □ ][ □ ] [ Calculator ]
                    Rectangle {
                        Layout.fillWidth: true
                        height: 26
                        color: "#cc000000"

                        Rectangle {
                            anchors.bottom: parent.bottom
                            width: parent.width
                            height: 1
                            color: cyanMain
                        }

                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: 8
                            anchors.rightMargin: 8
                            spacing: 4

                            Rectangle { width: 10; height: 10; color: "transparent"; border.color: cyanMain; border.width: 1 }
                            Rectangle { width: 10; height: 10; color: "transparent"; border.color: cyanMain; border.width: 1 }
                            Rectangle { width: 10; height: 10; color: "transparent"; border.color: cyanMain; border.width: 1 }

                            Item { Layout.fillWidth: true }

                            Text {
                                text: "[ Calculator ]"
                                font.family: "Courier New"
                                font.pixelSize: 13
                                font.bold: true
                                color: cyanMain
                            }

                            Item { Layout.fillWidth: true }
                        }
                    }

                    // Teclado e Visor
                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.margins: 12
                        spacing: 10

                        // Visor estilo Console
                        Rectangle {
                            Layout.fillWidth: true
                            height: 85
                            color: "#aa000000"
                            border.color: cyanMain
                            border.width: 1

                            ColumnLayout {
                                anchors.fill: parent
                                anchors.margins: 6
                                spacing: 0

                                Text {
                                    text: "Profile ... autoconfigure.cf\nConnecting to ... 210.322.330.1\nConnected!"
                                    font.family: "Courier New"
                                    font.pixelSize: 9
                                    color: cyanDim
                                }

                                Item { Layout.fillHeight: true }

                                TextField {
                                    id: display
                                    Layout.fillWidth: true
                                    readOnly: true
                                    text: ""
                                    font.family: "Courier New"
                                    font.pixelSize: 22
                                    font.bold: true
                                    color: cyanMain
                                    horizontalAlignment: Text.AlignRight
                                    background: Item {}
                                }
                            }
                        }

                        // Teclado com colunas uniformes
                        GridLayout {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            columns: 4
                            rowSpacing: 6
                            columnSpacing: 6

                            CoplandButton {
                                text: "Clear"
                                onClicked: display.text = ""
                            }
                            CoplandButton {
                                text: "("
                                onClicked: display.text += "("
                            }
                            CoplandButton {
                                text: ")"
                                onClicked: display.text += ")"
                            }
                            CoplandButton {
                                text: "÷"
                                onClicked: display.text += "/"
                            }

                            CoplandButton { text: "7"; onClicked: display.text += "7" }
                            CoplandButton { text: "8"; onClicked: display.text += "8" }
                            CoplandButton { text: "9"; onClicked: display.text += "9" }
                            CoplandButton { text: "*"; onClicked: display.text += "*" }

                            CoplandButton { text: "4"; onClicked: display.text += "4" }
                            CoplandButton { text: "5"; onClicked: display.text += "5" }
                            CoplandButton { text: "6"; onClicked: display.text += "6" }
                            CoplandButton { text: "-"; onClicked: display.text += "-" }

                            CoplandButton { text: "1"; onClicked: display.text += "1" }
                            CoplandButton { text: "2"; onClicked: display.text += "2" }
                            CoplandButton { text: "3"; onClicked: display.text += "3" }
                            CoplandButton { text: "+"; onClicked: display.text += "+" }

                            CoplandButton { text: "."; onClicked: display.text += "." }
                            CoplandButton { text: "0"; onClicked: display.text += "0" }
                            CoplandButton {
                                text: "="
                                Layout.columnSpan: 2
                                borderCol: cyanMain
                                filled: true
                                onClicked: display.text = display_calculadora.calculo(display.text)
                            }
                        }
                    }
                }
            }
        }

        // 🟢 BARRA INFERIOR (FOOTER / STATUS BAR)
        Rectangle {
            Layout.fillWidth: true
            height: 26
            color: bgSolid

            Rectangle {
                anchors.top: parent.top
                width: parent.width
                height: 1
                color: cyanMain
            }

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                spacing: 8

                Text { text: "Connection: OK"; font.family: "Courier New"; font.pixelSize: 11; color: cyanMain }
                Text { text: "|"; color: cyanDim }

                Text { text: "User: lain"; font.family: "Courier New"; font.pixelSize: 11; color: cyanMain }
                Text { text: "|"; color: cyanDim }

                Text { text: "Mainnet"; font.family: "Courier New"; font.pixelSize: 11; color: cyanMain }

                Item { Layout.fillWidth: true }

                Text { text: "|"; color: cyanDim }
                Text { text: "Language: 日本語"; font.family: "Courier New"; font.pixelSize: 11; color: cyanMain }
                Text { text: "|"; color: cyanDim }

                Text { text: "23:00:48"; font.family: "Courier New"; font.pixelSize: 11; color: cyanMain }
            }
        }
    }
}