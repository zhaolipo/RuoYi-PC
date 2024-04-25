import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import FluentUI
import "qrc:///example/qml/component"

FluContentPage {

    id: root
    // 为一个项目提供了一种与另一个项目具有相同几何形状的便捷方法，相当于连接所有四个方向锚点。
    anchors.fill: parent
    signal checkBoxChanged
    // 以下属性在QML中使用需要带上 id: root ，在JS中使用无需带 id: root
    // 当前页面显示的数据数组
    property var dataSource : []
    // 全选标志
    property bool seletedAll: true
    // 查询参数
    property var queryParams: {
        "pageNum": 1,
        "pageSize": 25,
        "postCode": "",
        "postName": "",
        "status": "0"
    }
    // 更新数据
    property var currentRow: {
        "postId": "",
        "postCode": "",
        "postName": "",
        "postSort": 0,
        "status": 0,
        "remark": ""
    }

    // 组件初始完成后自动执行
    Component.onCompleted: {
        initData()
    }

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
                    text: "岗位编码："
                }
                FluTextBox{
                    id: query_postCode
                    implicitWidth: 200
                    placeholderText: "请填写岗位编码"
                }
            }
            RowLayout{
                FluText{
                    text: "岗位名称："
                }
                FluTextBox{
                    id: query_postName
                    implicitWidth: 200
                    placeholderText: "请填写岗位名称"
                }
            }

            RowLayout{
                FluText{
                    text: "岗位状态："
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
                    root.queryParams['postCode'] = query_postCode.text
                    root.queryParams['postName'] = query_postName.text
                    root.queryParams['status'] = query_status.selectValue.value
                    initData()
                    table_view.resetPosition()
                }
            }

            FluFilledButton {
                text: "重置"
                onClicked: {
                    query_postCode.text = ""
                    query_postName.text = ""
                    root.queryParams = {
                        "pageNum": 1,
                        "pageSize": 25,
                        "postCode": "",
                        "postName": "",
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
        anchors.topMargin: 10
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

    // 表格：选择行事件
    onCheckBoxChanged: {
        for(var i =0;i< table_view.rows ;i++){
            if(false === table_view.getRow(i).checkbox.options.checked){
                root.seletedAll = false
                return
            }
        }
        root.seletedAll = true
    }

    // 表格：选择组件
    Component{
        id:com_checbox
        Item{
            FluCheckBox{
                anchors.centerIn: parent
                checked: true === options.checked
                animationEnabled: false
                clickListener: function(){
                    var obj = table_view.getRow(row)
                    obj.checkbox = table_view.customItem(com_checbox,{checked:!options.checked})
                    table_view.setRow(row,obj)
                    checkBoxChanged()
                }
            }
        }
    }

    // 表格：全选组件
    Component{
        id:com_column_checbox
        Item{
            RowLayout{
                anchors.centerIn: parent
                FluText{
                    text: "全选"
                    Layout.alignment: Qt.AlignVCenter
                }
                FluCheckBox{
                    checked: true === root.seletedAll
                    animationEnabled: false
                    Layout.alignment: Qt.AlignVCenter
                    clickListener: function(){
                        root.seletedAll = !root.seletedAll
                        var checked = root.seletedAll
                        itemModel.display = table_view.customItem(com_column_checbox,{"checked":checked})
                        for(var i =0;i< table_view.rows ;i++){
                            var rowData = table_view.getRow(i)
                            rowData.checkbox = table_view.customItem(com_checbox,{"checked":checked})
                            table_view.setRow(i,rowData)
                        }
                    }
                }
            }
        }
    }

    // 表格
    FluTableView {
        id: table_view
        anchors {
            left: parent.left
            right: parent.right
            top: operate_area.bottom
            bottom: gagination.top
        }
        anchors.topMargin: 10
        onRowsChanged: {
            root.checkBoxChanged()
        }
        columnSource: [
            {
                title: table_view.customItem(com_column_checbox,{checked:true}),
                dataIndex: 'checkbox',
                width:100,
                minimumWidth:100,
                maximumWidth:100
            },
            {
                title: '岗位编号',
                dataIndex: 'postId',
                width: 100,
                minimumWidth: 100,
                maximumWidth: 100
            },
            {
                title: '岗位编码',
                dataIndex: 'postCode',
                width: 100,
                minimumWidth: 100,
                maximumWidth: 100
            },
            {
                title: '岗位名称',
                dataIndex: 'postName',
                width: 200,
                minimumWidth: 100,
                maximumWidth: 250
            },
            {
                title: '岗位排序',
                dataIndex: 'postSort',
                width: 100,
                minimumWidth: 80,
                maximumWidth: 200
            },
            {
                title: '状态',
                dataIndex: 'status',
                width: 200,
                minimumWidth: 100,
                maximumWidth: 300
            },
            {
                title: '创建时间',
                dataIndex: 'createTime',
                width: 200,
                minimumWidth: 100,
                maximumWidth: 300
            },
            {
                title: '备注',
                dataIndex: 'remark',
                width: 200,
                minimumWidth: 100,
                maximumWidth: 300
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
    Component{
        id:com_action
        Item{
            RowLayout{
                anchors.centerIn: parent
                FluButton{
                    text:"删除"
                    onClicked: {
                        delete_dialog.showDialog(table_view.getRow(row))
                    }
                }
                FluFilledButton{
                    text:"编辑"
                    onClicked: {
                        update_dialog.showDialog(table_view.getRow(row))
                    }
                }
            }
        }
    }

    // 页码
    FluPagination{
        id:gagination
        anchors{
            bottom: parent.bottom
            right: parent.right
        }
        pageCurrent: 1
        itemCount: 1
        pageButtonCount: 7
        __itemPerPage: 25
        onRequestPage:
            (page,count)=> {
                root.queryParams['pageNum'] = page
                root.queryParams['pageSize'] = count
                initData()
                table_view.resetPosition()
            }
    }

    // 删除提示
    FluContentDialog{
        id: delete_dialog
        title:"是否确认删除"
        buttonFlags: FluContentDialogType.NegativeButton | FluContentDialogType.PositiveButton
        negativeText:"取消"
        onNegativeClicked:{
            // showSuccess("点击取消按钮")
        }
        positiveText:"确定"
        onPositiveClicked:{
            var result = PostSlot.delPost(root.currentRow['postId'])
            if(result.code == 200){
                initData()
                table_view.resetPosition()
            }else{
                showError("删除失败")
            }
        }
        function showDialog(rowObj){
            root.currentRow = rowObj
            delete_dialog.open()
        }
    }

    // 新增/更新
    FluContentDialog{
        id: update_dialog
        title: "编辑"
        width: 800

        // 表单内容
        contentDelegate: Component{
            Item{
                id: update_item
                implicitWidth: parent.width
                implicitHeight: 200

                Row {
                    id: row_1
                    spacing: 10
                    anchors.horizontalCenter: parent.horizontalCenter

                    // 岗位编码
                    FluText {
                        text: "岗位编码："
                        width: 100
                        horizontalAlignment: Text.AlignRight
                        anchors.baseline: update_postCode.baseline
                    }
                    FluTextBox {
                        id: update_postCode
                        width: 200
                        placeholderText: "请输入岗位编码"
                        onTextChanged: {
                            root.currentRow['postCode'] = update_postCode.text
                        }
                    }

                    // 岗位名称
                    FluText {
                        text: "岗位名称："
                        width: 100
                        horizontalAlignment: Text.AlignRight
                        anchors.baseline: update_postName.baseline
                    }
                    FluTextBox {
                        id: update_postName
                        width: 200
                        placeholderText: "请输入岗位名称"
                        onTextChanged: {
                            root.currentRow['postName'] = update_postName.text
                        }
                    }
                }


                Row {
                    id: row_2
                    spacing: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: row_1.bottom
                    anchors.topMargin: 30

                    // 岗位编码
                    FluText {
                        text: "显示顺序："
                        width: 100
                        horizontalAlignment: Text.AlignRight
                        anchors.baseline: update_postSort.baseline
                    }
                    FluTextBox {
                        id: update_postSort
                        width: 200
                        placeholderText: "请输入显示顺序"
                        onTextChanged: {
                            root.currentRow['postSort'] = update_postSort.text
                        }
                    }

                    // 岗位名称
                    FluText {
                        text: "岗位状态："
                        width: 100
                        horizontalAlignment: Text.AlignRight
                        anchors.baseline: update_status.baseline
                    }
                    FluTextBox {
                        id: update_status
                        width: 200
                        placeholderText: "请输入岗位状态"
                        onTextChanged: {
                            root.currentRow['status'] = update_status.text
                        }
                    }
                }

                Row {
                    id: row_3
                    spacing: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: row_2.bottom
                    anchors.topMargin: 30

                    // 岗位编码
                    FluText {
                        text: "备注信息："
                        width: 100
                        horizontalAlignment: Text.AlignRight
                        anchors.baseline: update_remark.baseline
                    }
                    FluTextBox {
                        id: update_remark
                        width: 520
                        placeholderText: "请输入备注信息"
                        onTextChanged: {
                            root.currentRow['remark'] = update_remark.text
                        }
                    }
                }

                // 信息回显
                Component.onCompleted: {
                    update_postCode.text = root.currentRow['postCode']
                    update_postName.text = root.currentRow['postName']
                    update_postSort.text = root.currentRow['postSort']
                    update_status.text = root.currentRow['status']
                    update_remark.text = root.currentRow['remark']
                }

            }
        }

        negativeText: "取消"
        positiveText: "确认"
        // 点击确认后的方法
        onPositiveClicked:{
            var result = {}
            if(root.currentRow['postId'] == ""){
                result = PostSlot.addPost({
                    "postCode" : root.currentRow['postCode'],
                    "postName" : root.currentRow['postName'],
                    "postSort" : root.currentRow['postSort'],
                    "status" : root.currentRow['status'],
                    "remark" : root.currentRow['remark'],
                    "postId" : root.currentRow['postId']
                })
            }else{
                result = PostSlot.updatePost({
                    "postCode" : root.currentRow['postCode'],
                    "postName" : root.currentRow['postName'],
                    "postSort" : root.currentRow['postSort'],
                    "status" : root.currentRow['status'],
                    "remark" : root.currentRow['remark'],
                    "postId" : root.currentRow['postId']
                })
            }
            if(result.code == 200){
                initData()
                table_view.resetPosition()
            }else{
                showError("操作失败")
            }
        }
        // 显示表单的方法
        function showDialog(rowObj){
            root.currentRow = rowObj
            update_dialog.open()
        }
    }

    // 初始化函数
    function initData() {
        // 查询方法
        var result = PostSlot.listPost(root.queryParams)

        // 处理查询结果
        dataSource = []
        for(var i in result.rows){
            dataSource.push({
                checkbox: table_view.customItem(com_checbox,{checked:root.seletedAll}),
                postId: String(result.rows[i].postId),
                postCode: String(result.rows[i].postCode),
                postName: String(result.rows[i].postName),
                postSort: String(result.rows[i].postSort),
                status: String(result.rows[i].status),
                createTime: String(result.rows[i].createTime),
                remark: String(result.rows[i].remark),
                action: table_view.customItem(com_action),
                minimumHeight:50
            })
        }

        // 将查询结果添加到表格中
        table_view.dataSource = dataSource
        // 将数据总数赋值给页码模版
        gagination.itemCount = parseInt(result.total, 10); // 第二个参数是基数，10代表十进制
    }

}