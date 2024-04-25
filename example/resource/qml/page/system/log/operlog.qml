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
    property var allDataSource: []
    property var dataSource: []
    // 是否全选标志
    property bool seletedAll: true
    property var selectItems: []
    // 查询参数
    property var queryParams: {
        "pageNum": 1,
        "pageSize": 25,
        "operIp": "",
        "title": "",
        "operName": "",
        "businessType": "",
        "status": ""
    }

    // 组件初始完成后自动执行
    Component.onCompleted: {
        initData()
    }

    // 表格：选择行事件
    onCheckBoxChanged: {
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
            height: 100
            padding: 10

            RowLayout{
                id: one_row
                spacing : 40
                height: 40
                anchors.leftMargin: 20
                anchors.rightMargin : 20
                RowLayout{
                    FluText{
                        text: "操作地址："
                    }
                    FluTextBox{
                        id: query_operIp
                        implicitWidth: 200
                        placeholderText: "请输入操作地址"
                    }
                }
                RowLayout{
                    FluText{
                        text: "系统模块："
                    }
                    FluTextBox{
                        id: query_title
                        implicitWidth: 200
                        placeholderText: "请输入系统模块"
                    }
                }
                RowLayout{
                    FluText{
                        text: "操作人员："
                    }
                    FluTextBox{
                        id: query_operName
                        implicitWidth: 200
                        placeholderText: "请输入操作人员"
                    }
                }
                RowLayout{
                    FluText{
                        text: "操作类型："
                    }
                    FluComboBox {
                        id: query_businessType
                        implicitWidth: 200
                        textRole: "text"
                        model: JSTools.getBusinessType()
                    }
                }
            }

            RowLayout {
                id: two_row
                spacing: 40
                height: 40
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                anchors.top: one_row.bottom
                RowLayout{
                    FluText{
                        text: "操作状态："
                    }
                    FluComboBox {
                        id: query_status
                        implicitWidth: 200
                        textRole: "text"
                        model: JSTools.getSucceed()
                    }
                }
                RowLayout{
                    FluText{
                        text: "登录时间："
                    }
                    FluCalendarPicker{
                        id: start_date
                        text: {
                            if(start_date.current){
                                return start_date.current.toLocaleDateString(FluApp.locale,"yyyy-MM-dd")
                            }
                            return  "开始日期"
                        }
                        implicitWidth: 200
                    }
                    FluText{
                        text: " 至 "
                    }
                    FluCalendarPicker{
                        id: end_date
                        text: {
                            if(end_date.current){
                                return end_date.current.toLocaleDateString(FluApp.locale,"yyyy-MM-dd")
                            }
                            return  "结束日期"
                        }
                        implicitWidth: 200
                    }
                }

                FluFilledButton {
                    text: "搜索"
                    onClicked: {
                        root.queryParams['operIp'] = query_operIp.text
                        root.queryParams['title'] = query_title.text
                        root.queryParams['operName'] = query_operName.text
                        root.queryParams['businessType'] = JSTools.getBusinessType()[query_status.currentIndex].value
                        root.queryParams['status'] = JSTools.getSucceed()[query_status.currentIndex].value

                        if(start_date.text != "开始日期" && end_date.text != "结束日期"){
                            if(new Date(start_date.text) < new Date(end_date.text)){
                                root.queryParams["params['beginTime']"] = start_date.text
                                root.queryParams["params['endTime']"] = end_date.text
                            }else{
                                showError("开始时间不能晚于结束时间")
                            }
                        }else if(start_date.text != "开始日期" | end_date.text != "结束日期"){
                            showError("请选择开始/结束时间")
                            return;
                        }

                        initData()
                        table_view.resetPosition()
                    }
                }

                FluFilledButton {
                    text: "重置"
                    onClicked: {
                        query_operIp.text = ""
                        query_title.text = ""
                        query_operName.text = ""
                        query_businessType.currentIndex = "0"
                        query_status.currentIndex = "0"
                        // 重置日期选择器
                        start_date.current = false
                        end_date.current = false
                        // 重置请求参数
                        root.queryParams = {
                            "pageNum": 1,
                            "pageSize": 25,
                            "operIp": "",
                            "title": "",
                            "operName": "",
                            "businessType": "",
                            "status": "0"
                        }
                        initData()
                        table_view.resetPosition()
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
                    iconSource: FluentIcons.Delete
                    iconSize: 10
                    text: "删除"
                    implicitWidth: 60
                    display: Button.TextBesideIcon
                    onClicked:{
                        if(root.selectItems.length == 0){
                            showError("请选择删除行！")
                        }else{
                            delete_dialog.showDialog(1) // 1 代表删除按钮 2 代表清空按钮
                        }
                    }
                }

                QBDIconButton{
                    iconSource: FluentIcons.Delete
                    iconSize: 10
                    text: "清空"
                    implicitWidth: 60
                    display: Button.TextBesideIcon
                    onClicked:{
                        delete_dialog.showDialog(2) // 1 代表删除按钮 2 代表清空按钮
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
                        // TODO 导出功能
                    }
                }

                QBDIconButton{
                    iconSource: FluentIcons.Refresh
                    iconSize: 10
                    text: "刷新"
                    implicitWidth: 60
                    display: Button.TextBesideIcon
                    onClicked:{
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
                        // 修改选中数组中的值
                        if(obj.checkbox.options.checked){
                            root.selectItems.push(obj.operId)
                        }else{
                            root.selectItems.splice(root.selectItems.indexOf(obj.operId), 1)
                        }
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
                            root.selectItems = []
                            root.seletedAll = !root.seletedAll
                            var checked = root.seletedAll
                            // 修改表头选择框状态
                            itemModel.display = table_view.customItem(com_column_checbox, {"checked": checked})
                            // 循环修改表格中每一行选择框的状态
                            for (var i = 0; i < table_view.rows; i++) {
                                var rowData = table_view.getRow(i)
                                rowData.checkbox = table_view.customItem(com_checbox, {"checked": checked})
                                if(rowData.checkbox.options.checked){
                                    root.selectItems.push(rowData.operId)
                                }else{
                                    root.selectItems.splice(root.selectItems.indexOf(rowData.operId), 1)
                                }
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
                    title: '日志编号',
                    dataIndex: 'operId',
                    width: 100,
                    minimumWidth: 100,
                    maximumWidth: 100
                },
                {
                    title: '系统模块',
                    dataIndex: 'title',
                    width: 100,
                    minimumWidth: 100,
                    maximumWidth: 100
                },
                {
                    title: '操作类型',
                    dataIndex: 'businessType',
                    width: 100,
                    minimumWidth: 100,
                    maximumWidth: 100
                },
                {
                    title: '操作人员',
                    dataIndex: 'operName',
                    width: 150,
                    minimumWidth: 150,
                    maximumWidth: 150
                },
                {
                    title: '操作地址',
                    dataIndex: 'operIp',
                    width: 150,
                    minimumWidth: 150,
                    maximumWidth: 150
                },
                {
                    title: '操作地点',
                    dataIndex: 'operLocation',
                    width: 150,
                    minimumWidth: 150,
                    maximumWidth: 150
                },
                {
                    title: '操作状态',
                    dataIndex: 'status',
                    width: 100,
                    minimumWidth: 100,
                    maximumWidth: 100
                },
                {
                    title: '操作日期',
                    dataIndex: 'operTime',
                    width: 100,
                    minimumWidth: 100,
                    maximumWidth: 100
                },
                {
                    title: '消耗时间',
                    dataIndex: 'costTime',
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
        // 表格：详细
        Component{
            id: com_action
            Item{
                RowLayout{
                    anchors.centerIn: parent
                    FluIconButton{
                        iconSource: FluentIcons.RedEye
                        iconSize: 10
                        text: "详细"
                        display: Button.TextBesideIcon
                        onClicked: {
                            var rowData = root.allDataSource.filter(item => item.operId == table_view.getRow(row).operId)
                            update_dialog.showDialog(rowData[0])
                        }
                    }
                }
            }
        }
        // 表格：删除提示
        QBDContentDialog {
            property var type
            id: delete_dialog
            title: "是否确认删除"
            buttonFlags: FluContentDialogType.NegativeButton | FluContentDialogType.PositiveButton
            negativeText: "取消"
            onNegativeClicked: {} // 点击取消
            positiveText: "确定"
            onPositiveClicked: {
                if(type == 1){
                    var result = OperlogSlot.delOperlog(root.selectItems)
                    if(result.code == 200){
                        initData()
                        table_view.resetPosition()
                    }else{
                        showError("删除失败")
                    }
                }else {
                    var result = OperlogSlot.cleanOperlog()
                    if(result.code == 200){
                        initData()
                        table_view.resetPosition()
                    }else{
                        showError("清除失败")
                    }
                }
            }
            // 控制弹框显示方法
            function showDialog(type) {
                delete_dialog.type = type
                delete_dialog.open()
            }
        }
        // 表格：新增/更新
        QBDContentDialog{
            property var rowData
            id: update_dialog
            title: "操作日志详细"
            width: 800
            buttonFlags: FluContentDialogType.NegativeButton
            // 表单内容
            contentDelegate: Component{
                Item{
                    id: update_item
                    implicitWidth: parent.width
                    implicitHeight: 550
                    ColumnLayout{
                        spacing: 30
                        anchors.centerIn: parent

                        RowLayout {
                            RowLayout{
                                FluText{
                                    text: "操作模块："
                                }
                                FluCopyableText{
                                    id: update_title
                                }
                            }
                        }
                        RowLayout {
                            RowLayout{
                                FluText{
                                    text: "请求地址："
                                }
                                FluCopyableText{
                                    id: update_operUrl
                                }
                            }
                        }
                        RowLayout {
                            RowLayout{
                                FluText{
                                    text: "登录信息："
                                }
                                FluCopyableText{
                                    id: update_operIp
                                }
                            }
                        }
                        RowLayout {
                           RowLayout{
                                FluText{
                                    text: "请求方式："
                                }
                                FluCopyableText{
                                    id: update_requestMethod
                                }
                            }
                        }
                        RowLayout {
                            RowLayout{
                                FluText{
                                    text: "操作方法："
                                }
                                FluCopyableText{
                                    id: update_method
                                }
                            }
                        }
                        RowLayout {
                            RowLayout{
                                FluText{
                                    text: "请求参数："
                                }
                                FluCopyableText{
                                    id: update_operParam
                                }
                            }
                        }
                        RowLayout {
                            RowLayout{
                                FluText{
                                    text: "返回参数："
                                }
                                FluCopyableText{
                                    id: update_jsonResult
                                }
                            }
                        }
                        RowLayout {
                            RowLayout{
                                FluText{
                                    text: "操作状态："
                                }
                                FluCopyableText{
                                    id: update_status
                                }
                            }
                        }
                        RowLayout {
                            RowLayout{
                                FluText{
                                    text: "消耗时间："
                                }
                                FluCopyableText{
                                    id: update_costTime
                                }
                            }
                        }
                        RowLayout {
                            RowLayout{
                                FluText{
                                    text: "操作时间："
                                }
                                FluCopyableText{
                                    id: update_operTime
                                }
                            }
                        }
                    }

                    // 信息回显
                    Component.onCompleted: {
                        update_title.text = update_dialog.rowData['title']
                        update_operUrl.text = update_dialog.rowData['operUrl']
                        update_operIp.text = update_dialog.rowData['operIp'] + "" + update_dialog.rowData['operLocation']
                        update_requestMethod.text = update_dialog.rowData['requestMethod']
                        update_method.text = update_dialog.rowData['method']
                        update_operParam.text = update_dialog.rowData['operParam']
                        update_jsonResult.text = update_dialog.rowData['jsonResult']
                        update_status.text = update_dialog.rowData['status'] == '0' ? '成功' : '失败'
                        update_costTime.text = update_dialog.rowData['costTime'] + "毫秒"
                        update_operTime.text = update_dialog.rowData['operTime']
                    }
                }
            }
            negativeText: "关闭"
            // 显示表单的方法
            function showDialog(rowObj){
                update_dialog.rowData = rowObj
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
        var result = OperlogSlot.list(root.queryParams)
        allDataSource = result.rows
        // 处理查询结果
        dataSource = []
        for(var i in result.rows){
            dataSource.push({
                checkbox: table_view.customItem(com_checbox,{checked:false}),
                operId: String(result.rows[i].operId),
                title: String(result.rows[i].title),
                businessType: String(result.rows[i].businessType),
                operName: String(result.rows[i].operName),
                operIp: String(result.rows[i].operIp),
                operLocation: String(result.rows[i].operLocation),
                status: String(result.rows[i].status == '0' ? '成功' : '失败'),
                operTime: String(result.rows[i].operTime.split(" ")[0]),
                costTime: String(result.rows[i].costTime),
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