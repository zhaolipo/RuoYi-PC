import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls
import FluentUI
import "qrc:///example/qml/component"
import "qrc:///example/qml/js/JSTools.js" as JSTools

FluContentPage{
    id: root
    anchors.fill: parent
    signal checkBoxChanged
    // 以下属性在QML中使用需要带上 id: root ，在JS中使用无需带 id: root
    // 当前页面显示的数据数组
    property var dataSource : []
    // 全选标志
    property bool seletedAll: true
    // 部门树形列表
    property var deptTreeSelect: []
    // 部门列表
    property var deptList: []
    // 岗位列表
    property var postList: []
    property var postData: {}
    // 角色列表
    property var roleList: []
    property var roleData: {"title":"超级管理员","admin":true,"createTime":"2024-03-18 09:33:07","dataScope":"1","delFlag":"0","deptCheckStrictly":true,"flag":false,"menuCheckStrictly":true,"remark":"超级管理员","roleId":1,"roleKey":"admin","roleName":"超级管理员","roleSort":1,"status":"0"}
    // 查询参数
    property var queryParams: {
        "pageNum": 1,
        "pageSize": 25,
        "userName": "",
        "phonenumber": "",
        "status": "0",
        "deptId": ""
    }
    // 更新数据
    property var formData: {
        "userId": "",
        "deptId": 0,
        "userName": "zhaolipo",
        "nickName": "赵利坡",
        "password": "123456",
        "phonenumber": "17736758807",
        "email": "290010220@qq.com",
        "sex": "0",
        "status": "0",
        "remark": "这是备注信息",
        "postIds": 2,
        "roleIds": 2
    }

    // 组件初始完成后自动执行
    Component.onCompleted: {
        // 部门树形列表
        var result = UserSlot.deptTreeSelect()
        root.deptTreeSelect = result.data
        root.deptTreeSelect = JSTools.renameKeys(root.deptTreeSelect, 'id', 'key')
        root.deptTreeSelect = JSTools.renameKeys(root.deptTreeSelect, 'label', 'title')
        tree_view.dataSource = root.deptTreeSelect
        // 部门列表
        var deptResult = DeptSlot.listDept({"delFlag": "0"})
        root.deptList = deptResult.data
        // 岗位列表
        var postList = PostSlot.listPostAll()
        root.postList = JSTools.renameKeys(postList.data, 'postName', 'title')
        // 角色列表
        var roleList = RoleSlot.listRoleAll()
        root.roleList = JSTools.renameKeys(roleList.data, 'roleName', 'title')

        initData()
    }

    // 表格：选择行事件
    onCheckBoxChanged: {
        // table_view.rows 表格的总行数
        // 循环表格中每一行
        for(var i =0;i< table_view.rows ;i++){
            // 如果有一行没有选中就返回 false
            if(false === table_view.getRow(i).checkbox.options.checked){
                root.seletedAll = false
                return
            }
        }
        // 否则返回 false
        root.seletedAll = true
    }

    RowLayout {
        id: row_layout
        anchors.fill: parent
        spacing: 6

        // 左侧部门区域
        FluFrame {
            // color: 'teal'
            Layout.fillWidth: true //尽可能填充宽度
            Layout.fillHeight: true //尽可能填充高度
            Layout.minimumWidth: 250 // 最小宽度
            Layout.preferredWidth: 250 // 希望宽度
            Layout.maximumWidth: 250 // 最大宽度
            ColumnLayout{
                id: column_layout
                anchors.fill: parent
                spacing: 6
                QBDTreeView{
                    id:tree_view
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.topMargin: 10
                    cellHeight: 30
                    draggable: false
                    showLine: false
                    checkable: false
                    depthPadding: 30
                    onCurrentModelChanged: {
                        root.queryParams['deptId'] = tree_view.currentModel.key
                        initData()
                        table_view.resetPosition()
                        console.log(JSON.stringify(tree_view.currentModel.key))
                    }
                    // Component.onCompleted: {
                    //     var result = UserSlot.deptTreeSelect()
                    //     var data = JSTools.renameKeys(result.data, 'id', 'key')
                    //     data = JSTools.renameKeys(data, 'label', 'title')
                    //     dataSource = data
                    // }
                }
            }
        }

        // 右侧用户区域
        FluFrame {
            id: right_frame
            Layout.fillWidth: true
            Layout.fillHeight: true

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
                            text: "用户名称："
                        }
                        FluTextBox{
                            id: query_userName
                            implicitWidth: 200
                            placeholderText: "请填写用户名称"
                        }
                    }
                    RowLayout{
                        FluText{
                            text: "手机号码："
                        }
                        FluTextBox{
                            id: query_phonenumber
                            implicitWidth: 200
                            placeholderText: "请填写手机号码"
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
                            text: "创建时间："
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
                            onAccepted:{
                                // control.start_date = current.toLocaleString()
                                // control.start_time = current.toLocaleDateString(FluApp.locale,"yyyy-MM-dd")
                            }
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
                            onAccepted:{
                                // control.end_date = current.toLocaleString()
                                // control.end_time = current.toLocaleDateString(FluApp.locale,"yyyy-MM-dd")
                            }
                        }
                    }

                    FluFilledButton {
                        text: "搜索"
                        onClicked: {
                            root.queryParams['userName'] = query_userName.text
                            root.queryParams['phonenumber'] = query_phonenumber.text
                            root.queryParams['status'] = query_status.selectValue.value

                            if(query_date.start_time != "" && query_date.end_time != ""){
                                var startTime = new Date(query_date.start_time);
                                var endTime = new Date(query_date.end_time);
                                if(startTime < endTime){
                                    root.queryParams["params['beginTime']"] = query_date.start_time
                                    root.queryParams["params['endTime']"] = query_date.end_time
                                }else{
                                    showError("开始时间不能晚于结束时间")
                                }
                            }else if(query_date.start_time != "" | query_date.end_time != ""){
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
                            query_userName.text = ""
                            query_phonenumber.text = ""
                            query_status.selectValue.value = "0"
                            query_date.return_show()
                            query_status.return_show()
                            root.queryParams = {
                                "pageNum": 1,
                                "pageSize": 25,
                                "userName": "",
                                "phonenumber": "",
                                "status": "0",
                                "deptId": ""
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
                            update_dialog.showDialog(root.formData)
                        }
                    }

                    QBDIconButton{
                        iconSource: FluentIcons.Delete
                        iconSize: 10
                        text: "删除"
                        implicitWidth: 60
                        display: Button.TextBesideIcon
                        onClicked:{
                            // 保存选中的行
                            var data = []
                            // 循环表格中每一行，获取选中行的 userId
                            for(var i =0;i< table_view.rows ;i++){
                                var item = table_view.getRow(i);
                                if (item.checkbox.options.checked) {
                                    data.push(item.userId);
                                }
                            }
                            if(data.length == 0){
                                showError("请选择删除的行！");
                                return;
                            }else{
                                delete_dialog.showDialog(data)
                            }
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
                            root.queryParams['userName'] = query_userName.text
                            root.queryParams['phonenumber'] = query_phonenumber.text
                            root.queryParams['status'] = query_status.selectValue.value

                            if(query_date.start_time != "" && query_date.end_time != ""){
                                var startTime = new Date(query_date.start_time);
                                var endTime = new Date(query_date.end_time);
                                if(startTime < endTime){
                                    root.queryParams["params['beginTime']"] = query_date.start_time
                                    root.queryParams["params['endTime']"] = query_date.end_time
                                }else{
                                    showError("开始时间不能晚于结束时间")
                                }
                            }else if(query_date.start_time != "" | query_date.end_time != ""){
                                showError("请选择开始/结束时间")
                                return;
                            }

                            initData()
                            table_view.resetPosition()
                        }
                    }
                }
            }
            // ======================================================
            // 表格：数据行的选择框视图：选择框组件
            Component{
                id: com_checbox
                Item{
                    FluCheckBox{
                        anchors.centerIn: parent
                        checked: true === options.checked
                        animationEnabled: false
                        clickListener: function(){
                            // 获取选中的哪一行
                            var obj = table_view.getRow(row)
                            // 修改选中行的选择框
                            obj.checkbox = table_view.customItem(com_checbox,{checked:!options.checked})
                            // 将修改后的选择框添加到表格数据中
                            table_view.setRow(row,obj)
                            // 触发选择事件：检测是否这次选择完成全选了，对应 onCheckBoxChanged 事件
                            checkBoxChanged()
                        }
                    }
                }
            }
            // 表格：表头“全选”列上的选择框视图
            Component{
                id: com_column_checbox
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
                            // 点击“全选”按钮事件
                            clickListener: function(){
                                root.seletedAll = !root.seletedAll
                                var checked = root.seletedAll
                                // 修改表头选择框状态
                                itemModel.display = table_view.customItem(com_column_checbox,{"checked":checked})
                                // 循环修改表格中每一行选择框的状态
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
                        title: table_view.customItem(com_column_checbox,{checked:false}),
                        dataIndex: 'checkbox',
                        width: 80,
                        minimumWidth: 80,
                        maximumWidth: 80
                    },
                    {
                        title: '用户编号',
                        dataIndex: 'userId',
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
                        title: '用户昵称',
                        dataIndex: 'nickName',
                        width: 100,
                        minimumWidth: 100,
                        maximumWidth: 100
                    },
                    {
                        title: '部门',
                        dataIndex: 'deptName',
                        width: 150,
                        minimumWidth: 150,
                        maximumWidth: 150
                    },
                    {
                        title: '手机号码',
                        dataIndex: 'phonenumber',
                        width: 150,
                        minimumWidth: 150,
                        maximumWidth: 150
                    },
                    {
                        title: '状态',
                        dataIndex: 'status',
                        width: 100,
                        minimumWidth: 100,
                        maximumWidth: 100
                    },
                    {
                        title: '创建时间',
                        dataIndex: 'createTime',
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
            // 表格：删除/编辑
            Component{
                id: com_action
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
                    if(result.code == 200){
                        initData()
                        table_view.resetPosition()
                    }else{
                        showError("删除失败")
                    }
                }
                // 控制弹框显示方法
                function showDialog(row) {
                    if(row.userId){
                        userIds = row.userId
                    }else{
                        userIds = row
                    }
                    delete_dialog.open()
                }
            }

            // 表格：新增/更新
            QBDContentDialog{
                id: update_dialog
                title: "新增/编辑"
                width: 800

                // 表单内容
                contentDelegate: Component{
                    Item{
                        id: update_item
                        implicitWidth: parent.width
                        implicitHeight: 400

                        ColumnLayout{
                            spacing: 30
                            anchors.centerIn: parent

                            RowLayout {
                                spacing: 40
                                RowLayout{
                                    FluText{
                                        text: "用户昵称："
                                    }
                                    FluTextBox{
                                        id: update_nickName
                                        implicitWidth: 200
                                        placeholderText: "请填写用户昵称"
                                    }
                                }
                                RowLayout{
                                    FluText{
                                        text: "归属部门："
                                    }
                                    FluComboBox {
                                        id: update_deptId
                                        implicitWidth: 200
                                        textRole: "deptName"
                                        model: root.deptList
                                        onCurrentIndexChanged: {
                                            console.log(root.deptList[update_deptId.currentIndex].deptId)
                                        }
                                    }
                                }
                            }

                            RowLayout {
                                spacing: 40
                                RowLayout{
                                    FluText{
                                        text: "手机号码："
                                    }
                                    FluTextBox{
                                        id: update_phonenumber
                                        implicitWidth: 200
                                        placeholderText: "请填写手机号码"
                                    }
                                }
                                RowLayout{
                                    FluText{
                                        text: "邮箱号码："
                                    }
                                    FluTextBox{
                                        id: update_email
                                        implicitWidth: 200
                                        placeholderText: "请填写邮箱号码"
                                    }
                                }
                            }

                            RowLayout {
                                spacing: 40
                                RowLayout{
                                    FluText{
                                        text: "用户名称："
                                    }
                                    FluTextBox{
                                        id: update_userName
                                        implicitWidth: 200
                                        placeholderText: "请填写用户名称"
                                    }
                                }
                                RowLayout{
                                    FluText{
                                        text: "用户密码："
                                    }
                                    FluPasswordBox{
                                        id: update_password
                                        implicitWidth: 200
                                        placeholderText: "请填写用户密码"
                                        onTextChanged: {

                                        }
                                    }
                                }
                            }

                            RowLayout {
                                spacing: 40
                                RowLayout{
                                    FluText{
                                        text: "用户性别："
                                    }
                                    FluComboBox {
                                        id: update_sex
                                        implicitWidth: 200
                                        textRole: "text"
                                        model: JSTools.getSexArray()
                                        onCurrentIndexChanged: {

                                        }
                                    }
                                }
                                RowLayout{
                                    FluText{
                                        text:"用户状态："
                                    }
                                    QBDColumnRadioButtons{
                                        id: update_status
                                        spacing: 40
                                        FluRadioButton{
                                            text: qsTr("正常")
                                            onClicked: {
                                                formData['status'] = '0'
                                            }
                                        }
                                        FluRadioButton{
                                            text: qsTr("停用")
                                            onClicked: {
                                                formData['status'] = '1'
                                            }
                                        }
                                    }
                                }
                            }

                            RowLayout {
                                spacing: 40
                                RowLayout{
                                    FluText{
                                        text: "用户岗位："
                                    }
                                    QBDAutoSuggestBox{
                                        id: update_postIds
                                        iconSource: FluentIcons.Search
                                        implicitWidth: 200
                                        placeholderText: "请搜索用户岗位"
                                        items: root.postList
                                        onItemClicked:
                                            (data)=>{
                                                console.log(JSON.stringify(data.postId))
                                            }
                                    }
                                }
                                RowLayout{
                                    FluText{
                                        text: "用户角色："
                                    }
                                    QBDAutoSuggestBox{
                                        id: update_roleIds
                                        iconSource: FluentIcons.Search
                                        implicitWidth: 200
                                        placeholderText: "请搜索用户角色"
                                        items: root.roleList
                                        onItemClicked:
                                            (data)=>{
                                                console.log(JSON.stringify(data.roleId))
                                            }
                                    }
                                }
                            }

                            RowLayout {
                                RowLayout{
                                    FluText{
                                        text: "备注信息："
                                    }
                                    FluTextBox{
                                        id: update_remark
                                        implicitWidth: 510
                                        placeholderText: "请填写备注信息"
                                    }
                                }
                            }
                        }

                        // 信息回显
                        Component.onCompleted: {
                            update_nickName.text = root.formData['nickName']
                            update_deptId.currentIndex = root.formData['deptId']
                            update_phonenumber.text = root.formData['phonenumber']
                            update_email.text = root.formData['email']
                            update_userName.text = root.formData['userName']
                            update_password.text = root.formData['password']
                            update_sex.currentIndex = root.formData['sex']
                            update_status.currentIndex = root.formData['status']
                            update_postIds.text = root.postData ? root.postData['postName'] : ''
                            // update_postIds.text = root.formData['postIds']
                            // update_roleIds.text = root.formData['roleIds']
                            update_roleIds.text = root.roleData['roleName']
                            update_remark.text = root.formData['remark']
                        }
                    }
                }

                negativeText: "取消"
                positiveText: "确认"
                // 点击确认后的方法
                onPositiveClicked:{
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
                function showDialog(rowObj){
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
    }

    // 初始化函数
    function initData() {
        // 查询方法
        var result = UserSlot.listUser(queryParams)
        // 处理查询结果
        dataSource = []
        for(var i in result.rows){
            dataSource.push({
                checkbox: table_view.customItem(com_checbox,{checked:false}),
                userId: String(result.rows[i].userId),
                userName: String(result.rows[i].userName),
                nickName: String(result.rows[i].nickName),
                deptName: result.rows[i].dept ? String(result.rows[i].dept.deptName) : "",
                phonenumber: String(result.rows[i].phonenumber),
                status: String(result.rows[i].status),
                createTime: String(result.rows[i].createTime.split(" ")[0]),
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
