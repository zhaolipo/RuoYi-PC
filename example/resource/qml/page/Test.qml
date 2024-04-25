import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import FluentUI 1.0
import "qrc:///example/qml/component"

FluContentPage{

    id:root
    title: qsTr("TableView")

    property var dataSource : []

    Component.onCompleted: {
        var result = MenuSlot.treeselect().data
        console.log(JSON.stringify(result))

        table_view.dataSource = MenuSlot.treeselect().data

        // table_view.dataSource = [{
        //     name: '赵1',
        //     age: '1',
        //     address: '详细地址',
        //     nickname: '昵称',
        //     _minimumHeight:50,
        //     _key: FluTools.uuid()
        // },{
        //     name: '赵1',
        //     age: '1',
        //     address: '详细地址',
        //     nickname: '昵称',
        //     parent: 0,
        //     _minimumHeight:50,
        //     _key: FluTools.uuid()
        // },{
        //     name: '赵1',
        //     age: '1',
        //     address: '详细地址',
        //     nickname: '昵称',
        //     parent: 2,
        //     _minimumHeight:50,
        //     _key: FluTools.uuid()
        // }]
    }

    QBDTableView{
        id: table_view
        anchors{
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }
        anchors.topMargin: 5
        columnSource:[
            {
                title: qsTr("ID"),
                dataIndex: 'id',
                readOnly:true
            },
            {
                title: qsTr("名称"),
                dataIndex: 'label',
                width:100,
                minimumWidth:100,
                maximumWidth:100
            }
        ]
    }

}
