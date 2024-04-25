import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import QtQml
import Qt.labs.platform
import FluentUI
import example
import "qrc:///example/qml/component"
import "qrc:///example/qml/global"

FluWindow {

    id:window
    title: '北京海王中新商业数据分析平台'
    // width: Screen.width * 0.8
    // height: Screen.height * 0.8
    // minimumWidth: Screen.width * 0.6
    // minimumHeight: Screen.height * 0.6
    width: 1600
    height: 800
    minimumWidth: 1600
    minimumHeight: 800
    launchMode: FluWindowType.SingleTask
    fitsAppBarWindows: true

    // 顶部应用栏
    appBar: QBDAppBar {
        width: window.width
        height: 40
        showDark: true  // 顶部应用栏是否显示夜间模式切换按钮
        darkClickListener:(button)=>handleDarkChanged(button)
        closeClickListener: ()=>{dialog_close.open()} // 退出系统监听
        z:7
    }

    // 检查系统更新事件
    FluEvent{
        name: "checkUpdate"
        onTriggered: {
            // checkUpdate(false)
        }
    }

    // 懒加载
    onLazyLoad: {
        // tour.open()
    }

    // 组件初始化完成后执行
    Component.onCompleted: {
        // checkUpdate(true)
    }

    // 组件销毁前执行
    Component.onDestruction: {
        FluRouter.exit()
    }

    // 系统托盘图标
    SystemTrayIcon {
        id:system_tray
        visible: true // 系统托盘是否可见
        icon.source: "qrc:/example/res/image/favicon.ico" // 系统托盘名称
        tooltip: AppInfo.appName // 系统托盘名称
        // 系统托盘右键显示菜单
        menu: Menu {
            MenuItem {
                text: "退出"
                onTriggered: {
                    FluRouter.exit() // 系统退出函数
                }
            }
        }
        // 当用户激活系统托盘图标时，会发出此信号。 Reason 参数指定系统托盘图标是如何激活的
        onActivated:
            (reason)=>{
                if(reason === SystemTrayIcon.Trigger){
                    window.show()
                    window.raise()
                    window.requestActivate()
                }
            }
    }

    // 定时事件
    Timer{
        id: timer_window_hide_delay
        interval: 150 // 设置触发之间的时间间隔，以毫秒为单位
        onTriggered: { // 触发事件
            window.hide() // 显示操作引导窗口
        }
    }

    // 关闭前弹出的提醒窗口
    QBDContentDialog{
        id: dialog_close
        title: "退出"
        message: "确定退出系统吗"
        negativeText: "最小化"
        buttonFlags: FluContentDialogType.NegativeButton | FluContentDialogType.NeutralButton | FluContentDialogType.PositiveButton
        // 最小化时，弹出的提示
        onNegativeClicked: {
            system_tray.showMessage("友情提示","系统已隐藏至托盘,点击托盘可再次激活窗口");
            timer_window_hide_delay.restart()
        }
        positiveText: "确认"
        neutralText: "取消"
        onPositiveClicked:{
            // 退出操作
            UserSlot.logout()
            console.log("......系统退出......")
            FluRouter.exit(0)
        }
    }


    // 右击菜单弹出的组件
    Component{
        id: nav_item_right_menu
        FluMenu{
            width: 186
            FluMenuItem{
                text: "在独立窗口打开"
                font: FluTextStyle.Caption
                onClicked: {
                    FluRouter.navigate("/pageWindow",{title:modelData.title,url:modelData.url})
                }
            }
        }
    }

    // 点击左上角图表，提供可翻转的表面
    Flipable{
        id: flipable
        anchors.fill: parent
        property bool flipped: false
        property real flipAngle: 0
        transform: Rotation {
            id: rotation
            origin.x: flipable.width/2
            origin.y: flipable.height/2
            axis { x: 0; y: 1; z: 0 }
            angle: flipable.flipAngle

        }
        states: State {
            PropertyChanges { target: flipable; flipAngle: 180 }
            when: flipable.flipped
        }
        transitions: Transition {
            NumberAnimation { target: flipable; property: "flipAngle"; duration: 1000 ; easing.type: Easing.OutCubic}
        }
        back: Item{
            anchors.fill: flipable
            visible: flipable.flipAngle !== 0
            Row{
                id:layout_back_buttons
                z:8
                anchors{
                    top: parent.top
                    left: parent.left
                    topMargin: FluTools.isMacos() ? 20 : 5
                    leftMargin: 5
                }
                FluIconButton{
                    iconSource: FluentIcons.ChromeBack
                    width: 30
                    height: 30
                    iconSize: 13
                    onClicked: {
                        flipable.flipped = false
                    }
                }
                FluIconButton{
                    iconSource: FluentIcons.Sync
                    width: 30
                    height: 30
                    iconSize: 13
                    onClicked: {
                        loader.reload()
                    }
                }
                Component.onCompleted: {
                    window.setHitTestVisible(layout_back_buttons)
                }
            }
            FluRemoteLoader{
                id:loader
                lazy: true
                anchors.fill: parent
                source: "https://zhu-zichu.gitee.io/Qt_174_LieflatPage.qml"
            }
        }
        front: Item{
            id:page_front
            visible: flipable.flipAngle !== 180
            anchors.fill: flipable
            // 左侧菜单
            FluNavigationView{
                property int clickCount: 0
                id:nav_view
                width: parent.width
                height: parent.height
                cellHeight: 38 // 左侧菜单栏高度
                cellWidth: 220 // 左侧菜单栏宽度
                z:999
                //Stack模式，每次切换都会将页面压入栈中，随着栈的页面增多，消耗的内存也越多，内存消耗多就会卡顿，这时候就需要按返回将页面pop掉，释放内存。该模式可以配合FluPage中的launchMode属性，设置页面的启动模式
                //                pageMode: FluNavigationViewType.Stack
                //NoStack模式，每次切换都会销毁之前的页面然后创建一个新的页面，只需消耗少量内存
                pageMode: FluNavigationViewType.NoStack
                items: ItemsOriginal
                footerItems:ItemsFooter
                topPadding:{
                    if(window.useSystemAppBar){
                        return 0
                    }
                    return FluTools.isMacos() ? 20 : 0
                }
                displayMode: GlobalModel.displayMode
                logo: "qrc:/example/res/image/favicon.ico"
                title: '北京海王中新商业数据分析平台' // 菜单栏顶部的名称
                // 点击左上角图表事件
                // onLogoClicked:{
                //     clickCount += 1
                //     showSuccess("%1:%2".arg(qsTr("Click Time")).arg(clickCount))
                //     if(clickCount === 5){
                //         loader.reload()
                //         flipable.flipped = true
                //         clickCount = 0
                //     }
                // }
                // 搜索框
                // autoSuggestBox:FluAutoSuggestBox{
                //     iconSource: FluentIcons.Search
                //     items: ItemsOriginal.getSearchData()
                //     placeholderText: qsTr("Search")
                //     onItemClicked:
                //         (data)=>{
                //             ItemsOriginal.startPageByItem(data)
                //         }
                // }
                // 组件初始化完成后
                Component.onCompleted: {
                    // 左侧菜单
                    ItemsOriginal.navigationView = nav_view
                    ItemsOriginal.paneItemMenu = nav_item_right_menu
                    ItemsFooter.navigationView = nav_view
                    ItemsFooter.paneItemMenu = nav_item_right_menu
                    window.setHitTestVisible(nav_view.buttonMenu)
                    window.setHitTestVisible(nav_view.buttonBack)
                    window.setHitTestVisible(nav_view.imageLogo)
                    setCurrentIndex(0)
                }
            }
        }
    }


    Component{
        id: com_reveal
        CircularReveal{
            id: reveal
            target: window.contentItem
            anchors.fill: parent
            onAnimationFinished:{
                //动画结束后释放资源
                loader_reveal.sourceComponent = undefined
            }
            onImageChanged: {
                changeDark()
            }
        }
    }


    FluLoader{
        id:loader_reveal
        anchors.fill: parent
    }

    // function distance(x1,y1,x2,y2){
    //     return Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))
    // }

    // 黑/白主题切换
    function handleDarkChanged(button){
        if(!FluTheme.animationEnabled || window.fitsAppBarWindows === false){
            changeDark()
        }else{
            if(loader_reveal.sourceComponent){
                return
            }
            loader_reveal.sourceComponent = com_reveal
            var target = window.contentItem
            var pos = button.mapToItem(target,0,0)
            var mouseX = pos.x
            var mouseY = pos.y
            var radius = Math.max(distance(mouseX,mouseY,0,0),distance(mouseX,mouseY,target.width,0),distance(mouseX,mouseY,0,target.height),distance(mouseX,mouseY,target.width,target.height))
            var reveal = loader_reveal.item
            reveal.start(reveal.width*Screen.devicePixelRatio,reveal.height*Screen.devicePixelRatio,Qt.point(mouseX,mouseY),radius)
        }
    }

    // function changeDark(){
    //     if(FluTheme.dark){
    //         FluTheme.darkMode = FluThemeType.Light
    //     }else{
    //         FluTheme.darkMode = FluThemeType.Dark
    //     }
    // }

    // Shortcut {
    //     sequence: "F5"
    //     context: Qt.WindowShortcut
    //     onActivated: {
    //         if(flipable.flipped){
    //             loader.reload()
    //         }
    //     }
    // }

    // Shortcut {
    //     sequence: "F6"
    //     context: Qt.WindowShortcut
    //     onActivated: {
    //         tour.open()
    //     }
    // }

    // FluTour{
    //     id: tour
    //     finishText: qsTr("Finish")
    //     nextText: qsTr("Next")
    //     previousText: qsTr("Previous")
    //     steps:{
    //         var data = []
    //         if(!window.useSystemAppBar){
    //             data.push({title:qsTr("Dark Mode"),description: qsTr("Here you can switch to night mode."),target:()=>appBar.buttonDark})
    //         }
    //         data.push({title:qsTr("Hide Easter eggs"),description: qsTr("Try a few more clicks!!"),target:()=>nav_view.imageLogo})
    //         return data
    //     }
    // }

    // FpsItem{
    //     id:fps_item
    // }

    // FluText{
    //     text: "fps %1".arg(fps_item.fps)
    //     opacity: 0.3
    //     anchors{
    //         bottom: parent.bottom
    //         right: parent.right
    //         bottomMargin: 5
    //         rightMargin: 5
    //     }
    // }

    // FluContentDialog{
    //     property string newVerson
    //     property string body
    //     id: dialog_update
    //     title: qsTr("Upgrade Tips")
    //     message:qsTr("FluentUI is currently up to date ")+ newVerson +qsTr(" -- The current app version") +AppInfo.version+qsTr(" \nNow go and download the new version？\n\nUpdated content: \n")+body
    //     buttonFlags: FluContentDialogType.NegativeButton | FluContentDialogType.PositiveButton
    //     negativeText: qsTr("Cancel")
    //     positiveText: qsTr("OK")
    //     onPositiveClicked:{
    //         Qt.openUrlExternally("https://github.com/zhuzichu520/FluentUI/releases/latest")
    //     }
    // }

    // NetworkCallable{
    //     id:callable
    //     property bool silent: true
    //     onStart: {
    //         console.debug("start check update...")
    //     }
    //     onFinish: {
    //         console.debug("check update finish")
    //         FluEventBus.post("checkUpdateFinish");
    //     }
    //     onSuccess:
    //         (result)=>{
    //             var data = JSON.parse(result)
    //             console.debug("current version "+AppInfo.version)
    //             console.debug("new version "+data.tag_name)
    //             if(data.tag_name !== AppInfo.version){
    //                 dialog_update.newVerson =  data.tag_name
    //                 dialog_update.body = data.body
    //                 dialog_update.open()
    //             }else{
    //                 if(!silent){
    //                     showInfo(qsTr("The current version is already the latest"))
    //                 }
    //             }
    //         }
    //     onError:
    //         (status,errorString)=>{
    //             if(!silent){
    //                 showError(qsTr("The network is abnormal"))
    //             }
    //             console.debug(status+";"+errorString)
    //         }
    // }

    // function checkUpdate(silent){
    //     callable.silent = silent
    //     Network.get("https://api.github.com/repos/zhuzichu520/FluentUI/releases/latest")
    //     .go(callable)
    // }

}
