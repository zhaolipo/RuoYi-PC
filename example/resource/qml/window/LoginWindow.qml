import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import FluentUI
import "qrc:///example/qml/component"


QBDWindow {

    id:loginWindow
    windowIcon: "" // 去除窗口图表
    title: "" //
    leftWidth: 500
    leftColor: Qt.rgba(32/255,32/255,32/255,1)
    width: 850
    height: 500
    fixSize: true

    Component.onCompleted: {
        textbox_uesrname.text = "admin"
        // textbox_uesrname.text = "ry"
        textbox_password.text =  "admin123"
        // textbox_password.focus =  true
        FluTheme.darkMode = FluThemeType.Dark  // FluThemeType.System FluThemeType.Dark FluThemeType.Light
    }

    RowLayout {
        id: layout
        anchors.fill: parent

        // 左侧
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumWidth: 500
            Layout.preferredWidth: 500
            Layout.maximumWidth: 500
            FluImage{
                width: 500
                height: 510
                source: "qrc:/example/res/image/left_logo.png"
            }
        }

        // 右侧
        Rectangle {
            Layout.fillWidth: true

            ColumnLayout{

                anchors{
                    left: parent.left
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }

                FluText{
                    text: AppInfo.appName
                    font.bold: true
                    font.pointSize: 18
                    font.letterSpacing: 4
                    horizontalAlignment: Text.AlignHCenter
                    Layout.preferredWidth: 260
                    Layout.alignment: Qt.AlignHCenter
                }

                FluTextBox{
                    id:textbox_uesrname
                    Layout.topMargin: 40
                    placeholderText: "请输入账号"
                    Layout.preferredWidth: 260
                    Layout.alignment: Qt.AlignHCenter
                }

                FluTextBox{
                    id:textbox_password
                    Layout.topMargin: 30
                    Layout.preferredWidth: 260
                    placeholderText: "请输入密码"
                    echoMode:TextInput.Password
                    Layout.alignment: Qt.AlignHCenter
                }

                FluFilledButton{
                    id: loginButton
                    text:"登录"
                    Layout.alignment: Qt.AlignHCenter
                    font.pointSize: 12
                    font.letterSpacing: 4
                    Layout.topMargin: 30
                    Layout.preferredWidth: 260
                    onClicked:{
                        if(textbox_uesrname.text === ""){
                            showError("请输入账号")
                            return
                        }
                        if(textbox_password.text === ""){
                            showError("请输入密码")
                            return
                        }
                        var result = LoginSlot.login(textbox_uesrname.text, textbox_password.text)
                        if(result.code == 200){
                            // 初始化当前登录用户的信息
                            UserSlot.getInfo()
                            // 跳转到首页
                            FluRouter.navigate("/")
                            // 关闭登录页面
                            loginWindow.close()
                        }else{
                            showError(result.msg)
                            return
                        }
                    }
                }

            }

        }
    }
}
