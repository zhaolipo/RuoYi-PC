import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls
import FluentUI
import "qrc:///example/qml/component"
import "qrc:///example/qml/js/JSTools.js" as JSTools

FluContentPage {
    id: root
    anchors.fill: parent
    signal checkBoxChanged
    // 当前页面显示的数据数组
    property var dataSource: []
    property bool seletedAll: true
    // 查询参数
    property var queryParams: {
        "pageNum": 1,
        "pageSize": 25,
        "ipaddr": "",
        "userName": "",
        "status": "0"
    }

    // 组件初始完成后自动执行
    Component.onCompleted: {
        initData()
    }

    // 表格：选择行事件
    onCheckBoxChanged: {
        // table_view.rows 表格的总行数
        // 循环表格中每一行
        for (var i = 0; i < table_view.rows; i++) {
            // 如果有一行没有选中就返回 false
            if (false === table_view.getRow(i).checkbox.options.checked) {
                root.seletedAll = false
                return
            }
        }
        // 否则返回 false
        root.seletedAll = true
    }


    FluFrame {
        id: page_area
        anchors.fill: parent

        // 查询条件表单
        FluFrame {
            id: query_form
            width: parent.width
            height: 60
            padding: 10

            RowLayout{
                spacing : 40
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 20
                anchors.rightMargin : 20
                RowLayout{
                    FluText{
                        text: "登录地址："
                    }
                    FluTextBox{
                        id: query_ipaddr
                        implicitWidth: 200
                        placeholderText: "请输入登录地址"
                    }
                }
                RowLayout{
                    FluText{
                        text: "用户名称："
                    }
                    FluTextBox{
                        id: query_userName
                        implicitWidth: 200
                        placeholderText: "请输入用户名称"
                    }
                }

                RowLayout{
                    FluText{
                        text: "登录状态："
                    }
                    FluComboBox {
                        id: query_status
                        implicitWidth: 200
                        textRole: "text"
                        model: ListModel {
                            id: cbItems
                            ListElement {
                                text: "正常"; value: "0"
                            }
                            ListElement {
                                text: "停用"; value: "1"
                            }
                        }
                        onCurrentIndexChanged: {

                        }
                    }
                }



                FluFilledButton {
                    text: "搜索"
                    onClicked: {
                        // root.queryParams['postCode'] = query_postCode.text
                        // root.queryParams['postName'] = query_postName.text
                        // root.queryParams['status'] = query_status.selectValue.value
                        // initData()
                        // table_view.resetPosition()
                    }
                }

                FluFilledButton {
                    text: "重置"
                    onClicked: {
                        // query_postCode.text = ""
                        // query_postName.text = ""
                        // root.queryParams = {
                        //     "pageNum": 1,
                        //     "pageSize": 25,
                        //     "postCode": "",
                        //     "postName": "",
                        //     "status": "0"
                        // }
                        // initData()
                        // table_view.resetPosition()
                    }
                }
            }
        }

        // 操作按钮
        FluFrame {
            id: operate_area
            width: parent.width
            height: 60
            anchors.top: query_form.bottom
            anchors.topMargin: 5
            padding: 10

            RowLayout{
                spacing : 10
                anchors.verticalCenter: parent.verticalCenter

                QBDIconButton{
                    iconSource: FluentIcons.Add
                    iconSize: 10
                    text: "新增"
                    implicitWidth: 60
                    display: Button.TextBesideIcon
                    onClicked:{
                        update_dialog.showDialog(root.currentRow)
                    }
                }

                QBDIconButton{
                    iconSource: FluentIcons.Delete
                    iconSize: 10
                    text: "删除"
                    implicitWidth: 60
                    display: Button.TextBesideIcon
                    onClicked:{
                        showSuccess("删除")
                    }
                }

                QBDIconButton{
                    iconSource: FluentIcons.Download
                    iconSize: 10
                    text: "导出"
                    implicitWidth: 60
                    display: Button.TextBesideIcon
                    onClicked:{
                        showSuccess("导出")
                    }
                }

                QBDIconButton{
                    iconSource: FluentIcons.Refresh
                    iconSize: 10
                    text: "刷新"
                    implicitWidth: 60
                    display: Button.TextBesideIcon
                    onClicked:{
                        root.queryParams['postCode'] = query_postCode.text
                        root.queryParams['postName'] = query_postName.text
                        root.queryParams['status'] = query_status.currentValue.value
                        initData()
                        table_view.resetPosition()
                    }
                }
            }
        }

        // ======================================================
        // 表格：数据行的选择框视图：选择框组件
        Component {
            id: com_checbox
            Item {
                FluCheckBox {
                    anchors.centerIn: parent
                    checked: true === options.checked
                    animationEnabled: false
                    clickListener: function () {
                        // 获取选中的哪一行
                        var obj = table_view.getRow(row)
                        // 修改选中行的选择框
                        obj.checkbox = table_view.customItem(com_checbox, {checked: !options.checked})
                        // 将修改后的选择框添加到表格数据中
                        table_view.setRow(row, obj)
                        // 触发选择事件：检测是否这次选择完成全选了，对应 onCheckBoxChanged 事件
                        checkBoxChanged()
                    }
                }
            }
        }
        // 表格：表头“全选”列上的选择框视图
        Component {
            id: com_column_checbox
            Item {
                RowLayout {
                    anchors.centerIn: parent
                    FluText {
                        text: "全选"
                        Layout.alignment: Qt.AlignVCenter
                    }
                    FluCheckBox {
                        checked: true === root.seletedAll
                        animationEnabled: false
                        Layout.alignment: Qt.AlignVCenter
                        // 点击“全选”按钮事件
                        clickListener: function () {
                            root.seletedAll = !root.seletedAll
                            var checked = root.seletedAll
                            // 修改表头选择框状态
                            itemModel.display = table_view.customItem(com_column_checbox, {"checked": checked})
                            // 循环修改表格中每一行选择框的状态
                            for (var i = 0; i < table_view.rows; i++) {
                                var rowData = table_view.getRow(i)
                                rowData.checkbox = table_view.customItem(com_checbox, {"checked": checked})
                                table_view.setRow(i, rowData)
                            }
                        }
                    }
                }
            }
        }

        // 表格：表头信息
        FluTableView {
            id: table_view
            anchors {
                top: operate_area.bottom
                bottom: page_num_area.top
                left: parent.left
                right: parent.right
                topMargin: 5
                bottomMargin: 5
                leftMargin: 5
                rightMargin: 5
            }
            // 行数发生变化时触发的事件
            onRowsChanged: {
                // 触发检测是否是全选了
                root.checkBoxChanged()
            }
            columnSource: [
                {
                    title: table_view.customItem(com_column_checbox, {checked: false}),
                    dataIndex: 'checkbox',
                    width: 80,
                    minimumWidth: 80,
                    maximumWidth: 80
                },
                {
                    title: '访问编号',
                    dataIndex: 'infoId',
                    width: 100,
                    minimumWidth: 100,
                    maximumWidth: 100
                },
                {
                    title: '用户名称',
                    dataIndex: 'userName',
                    width: 100,
                    minimumWidth: 100,
                    maximumWidth: 100
                },
                {
                    title: '登录地址',
                    dataIndex: 'ipaddr',
                    width: 100,
                    minimumWidth: 100,
                    maximumWidth: 100
                },
                {
                    title: '登录地点',
                    dataIndex: 'loginLocation',
                    width: 150,
                    minimumWidth: 150,
                    maximumWidth: 150
                },
                {
                    title: '浏览器',
                    dataIndex: 'browser',
                    width: 100,
                    minimumWidth: 100,
                    maximumWidth: 100
                },
                {
                    title: '操作系统',
                    dataIndex: 'os',
                    width: 100,
                    minimumWidth: 100,
                    maximumWidth: 100
                },
                {
                    title: '登录状态',
                    dataIndex: 'status',
                    width: 100,
                    minimumWidth: 100,
                    maximumWidth: 100
                },
                {
                    title: '操作信息',
                    dataIndex: 'msg',
                    width: 100,
                    minimumWidth: 100,
                    maximumWidth: 100
                },
                {
                    title: '登录日期',
                    dataIndex: 'loginTime',
                    width: 100,
                    minimumWidth: 100,
                    maximumWidth: 100
                },
                {
                    title: '操作',
                    dataIndex: 'action',
                    width: 160,
                    minimumWidth: 160,
                    maximumWidth: 160
                }
            ]
        }

        // 删除/编辑
        Component {
            id: com_action
            Item {
                RowLayout {
                    anchors.centerIn: parent
                    FluButton {
                        text: "删除"
                        onClicked: {
                            delete_dialog.showDialog(table_view.getRow(row))
                        }
                    }
                    FluFilledButton {
                        text: "编辑"
                        onClicked: {
                            update_dialog.showDialog(table_view.getRow(row))
                        }
                    }
                }
            }
        }
        // 表格：删除提示
        QBDContentDialog {
            property var userIds
            id: delete_dialog
            title: "是否确认删除"
            buttonFlags: FluContentDialogType.NegativeButton | FluContentDialogType.PositiveButton
            negativeText: "取消"
            onNegativeClicked: {} // 点击取消
            positiveText: "确定"
            onPositiveClicked: {
                var result = UserSlot.delUser(userIds)
                if (result.code == 200) {
                    initData()
                    table_view.resetPosition()
                } else {
                    showError("删除失败")
                }
            }

            // 控制弹框显示方法
            function showDialog(row) {
                if (row.userId) {
                    userIds = row.userId
                } else {
                    userIds = row
                }
                delete_dialog.open()
            }
        }
        // 表格：新增/更新
        QBDContentDialog {
            id: update_dialog
            title: "新增/编辑"
            width: 800

            // 表单内容
            contentDelegate: Component {

                Flickable{
                    id: scroll
                    implicitWidth: parent.width
                    implicitHeight: 600
                    boundsBehavior: Flickable.StopAtBounds
                    contentHeight: column.implicitHeight
                    clip: true
                    ScrollBar.vertical: FluScrollBar {}
                    ColumnLayout {
                        id: column
                        spacing: 30
                        anchors.centerIn: parent

                        RowLayout {
                            spacing: 40
                            RowLayout {
                                FluText {
                                    text: "角色名称："
                                }
                                FluTextBox {
                                    id: update_roleName
                                    implicitWidth: 200
                                    placeholderText: "请输入角色名称"
                                }
                            }
                            RowLayout {
                                FluText {
                                    text: "权限字符："
                                }
                                FluTextBox {
                                    id: update_roleKey
                                    implicitWidth: 200
                                    placeholderText: "请输入权限字符"
                                }
                            }
                        }

                        RowLayout {
                            spacing: 40
                            RowLayout {
                                FluText {
                                    text: "角色顺序："
                                }
                                FluSpinBox {
                                    id: update_roleSort
                                    implicitWidth: 200
                                }
                            }
                            RowLayout {
                                FluText {
                                    text: "角色状态："
                                }
                                QBDColumnRadioButtons {
                                    id: update_status
                                    spacing: 40
                                    FluRadioButton {
                                        text: qsTr("正常")
                                        onClicked: {
                                            formData['status'] = '0'
                                        }
                                    }
                                    FluRadioButton {
                                        text: qsTr("停用")
                                        onClicked: {
                                            formData['status'] = '1'
                                        }
                                    }
                                }
                            }
                        }

                        RowLayout {
                            FluText {
                                text: "菜单权限："
                            }
                            FluExpander{
                                id: expander
                                contentHeight: 300
                                headerText: qsTr("请选择菜单权限")
                                implicitWidth: 510
                                Item{
                                    anchors.fill: parent
                                    QBDTreeView{
                                        id: tree_view
                                        anchors.fill: parent
                                        cellHeight: 30
                                        draggable: false
                                        showLine: false
                                        checkable: true
                                        depthPadding: 30
                                        Component.onCompleted: {
                                            dataSource = root.menuOptions
                                        }
                                    }
                                }
                            }
                        }

                        RowLayout {
                            FluText {
                                text: "备注信息："
                            }
                            FluTextBox {
                                id: update_remark
                                implicitWidth: 510
                                placeholderText: "请填写备注信息"
                            }
                        }
                    }

                    // 信息回显
                    Component.onCompleted: {
                        // update_nickName.text = root.formData['nickName']
                        // update_deptId.currentIndex = root.formData['deptId']
                        // update_phonenumber.text = root.formData['phonenumber']
                        // update_email.text = root.formData['email']
                        // update_userName.text = root.formData['userName']
                        // update_password.text = root.formData['password']
                        // update_sex.currentIndex = root.formData['sex']
                        // update_status.currentIndex = root.formData['status']
                        // update_postIds.text = root.postData ? root.postData['postName'] : ''
                        // update_postIds.text = root.formData['postIds']
                        // update_roleIds.text = root.formData['roleIds']
                        // update_roleIds.text = root.roleData['roleName']
                        // update_remark.text = root.formData['remark']
                    }
                }
            }

            negativeText: "取消"
            positiveText: "确认"
            // 点击确认后的方法
            onPositiveClicked: {
                // var result = {}
                // if(root.formData['postId'] == ""){
                //     result = PostSlot.addPost({
                //         "postCode" : root.formData['postCode'],
                //         "postName" : root.formData['postName'],
                //         "postSort" : root.formData['postSort'],
                //         "status" : root.formData['status'],
                //         "remark" : root.formData['remark'],
                //         "postId" : root.formData['postId']
                //     })
                // }else{
                //     result = PostSlot.updatePost({
                //         "postCode" : root.formData['postCode'],
                //         "postName" : root.formData['postName'],
                //         "postSort" : root.formData['postSort'],
                //         "status" : root.formData['status'],
                //         "remark" : root.formData['remark'],
                //         "postId" : root.formData['postId']
                //     })
                // }
                // if(result.code == 200){
                //     initData()
                //     table_view.resetPosition()
                // }else{
                //     showError("操作失败")
                // }
            }

            // 显示表单的方法
            function showDialog(rowObj) {
                root.formData = rowObj
                update_dialog.open()
            }
        }
        // ======================================================


        // 页码
        FluFrame {
            id: page_num_area
            width: parent.width
            height: 60
            anchors.bottom: parent.bottom
            anchors.topMargin: 10
            padding: 10

            FluPagination{
                id: pagination
                anchors{
                    bottom: parent.bottom
                    right: parent.right
                }
                pageCurrent: 1  // 当前选中的页码
                itemCount: 1  // 共有多少条数
                pageButtonCount: 7 // 显示的页码按钮数
                __itemPerPage: 25 // 每页显示的数量
                onRequestPage:
                    (page,count)=> {
                        root.queryParams['pageNum'] = page
                        root.queryParams['pageSize'] = count
                        initData()
                        table_view.resetPosition()
                    }
            }
        }

    }

    // 初始化函数
    function initData() {
        // 查询方法
        var result = LogininforSlot.list(root.queryParams)
        // 处理查询结果
        dataSource = []
        for(var i in result.rows){
            dataSource.push({
                checkbox: table_view.customItem(com_checbox,{checked:false}),
                infoId: String(result.rows[i].infoId),
                userName: String(result.rows[i].userName),
                ipaddr: String(result.rows[i].ipaddr),
                loginLocation: String(result.rows[i].loginLocation),
                browser: String(result.rows[i].browser),
                os: String(result.rows[i].os),
                status: String(result.rows[i].status == '0' ? '正常' : '停用'),
                msg: String(result.rows[i].msg),
                loginTime: String(result.rows[i].loginTime.split(" ")[0]),
                action: table_view.customItem(com_action),
                minimumHeight:50
            })
        }
        // 将查询结果添加到表格中
        table_view.dataSource = dataSource
        // 将数据总数赋值给页码模版
        pagination.itemCount = parseInt(result.total, 10); // 第二个参数是基数，10代表十进制
    }

}