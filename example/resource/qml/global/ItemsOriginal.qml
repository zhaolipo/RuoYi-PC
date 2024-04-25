pragma Singleton

import QtQuick
import FluentUI

FluObject{

    property var navigationView   // 导航视图
    property var paneItemMenu     // 导航项

    function rename(item, newName){
        if(newName && newName.trim().length>0){
            item.title = newName;
        }
    }

    // 菜单项：首页
    FluPaneItem{
        id:item_home
        title:Lang.home
        menuDelegate: paneItemMenu
        icon:FluentIcons.PieSingle
        url:"qrc:/example/qml/page/system/log/operlog.qml"
        onTap:{
            navigationView.push(url)
        }
    }

    // 系统管理
    FluPaneItemExpander{
        id:system_management
        title:Lang.system_management
        icon:FluentIcons.Settings
        // 用户管理
        QBDPaneItem{
            id:user_management
            title:Lang.user_management
            visible: Permission.isShow('system:user:list')
            icon:FluentIcons.ContactSolid
            menuDelegate: paneItemMenu
            url:"qrc:/example/qml/page/system/user/index.qml"
            onTap:{
                navigationView.push(url)
            }
        }
        // 角色管理
        QBDPaneItem{
            id:role_management
            title:Lang.role_management
            visible: Permission.isShow('system:role:list')
            icon:FluentIcons.ContactPresence
            menuDelegate: paneItemMenu
            url:"qrc:/example/qml/page/system/role/index.qml"
            onTap:{
                navigationView.push(url)
            }
        }
        // 菜单管理
        QBDPaneItem{
            id:menu_management
            title:Lang.menu_management
            visible: Permission.isShow('system:menu:list')
            icon:FluentIcons.ShowResults
            menuDelegate: paneItemMenu
            url:"qrc:/example/qml/page/system/menu/index.qml"
            onTap:{ navigationView.push(url) }
        }
        // 部门管理
        QBDPaneItem{
            id:department_management
            title:Lang.department_management
            visible: Permission.isShow('system:dept:list')
            icon:FluentIcons.GroupList
            menuDelegate: paneItemMenu
            url:"qrc:/example/qml/page/system/dept/index.qml"
            onTap:{ navigationView.push(url) }
        }
        // 岗位管理
        QBDPaneItem{
            id:position_management
            title:Lang.position_management
            visible: Permission.isShow('system:post:list')
            icon:FluentIcons.Lexicon
            menuDelegate: paneItemMenu
            url:"qrc:/example/qml/page/system/post/index.qml"
            onTap:{ navigationView.push(url) }
        }
        // 字典管理
        QBDPaneItem{
            id:dictionary_management
            title:Lang.dictionary_management
            visible: Permission.isShow('system:dict:list')
            icon:FluentIcons.ClipboardListMirrored
            menuDelegate: paneItemMenu
            url:"qrc:/example/qml/page/system/dict/index.qml"
            onTap:{ navigationView.push(url) }
        }
        // 系统配置
        QBDPaneItem{
            id:parameter_settings
            title:Lang.parameter_settings
            visible: Permission.isShow('system:config:list')
            icon:FluentIcons.ExploitProtection
            menuDelegate: paneItemMenu
            url:"qrc:/example/qml/page/system/config/index.qml"
            onTap:{ navigationView.push(url) }
        }
        // 通知公告
        QBDPaneItem{
            id:notice_and_announcement
            title:Lang.notice_and_announcement
            visible: Permission.isShow('system:notice:list')
            icon:FluentIcons.ActionCenterNotification
            menuDelegate: paneItemMenu
            url:"qrc:/example/qml/page/system/notice/index.qml"
            onTap:{ navigationView.push(url) }
        }
        // 操作日志
        QBDPaneItem{
            id:oper_management
            title:Lang.oper_management
            visible: Permission.isShow('monitor:operlog:list')
            icon:FluentIcons.Trackers
            menuDelegate: paneItemMenu
            url:"qrc:/example/qml/page/system/log/operlog.qml"
            onTap:{ navigationView.push(url) }
        }
        // 登录日志
        QBDPaneItem{
            id:login_management
            title:Lang.login_management
            visible: Permission.isShow('monitor:operlog:list')
            icon:FluentIcons.Trackers
            menuDelegate: paneItemMenu
            url:"qrc:/example/qml/page/system/log/logininfor.qml"
            onTap:{ navigationView.push(url) }
        }
    }

    // 系统监控
    FluPaneItemExpander{
        id:system_monitoring
        title:Lang.system_monitoring
        icon:FluentIcons.TVMonitor
        // 在线用户
        QBDPaneItem{
            id:online_users
            title:Lang.online_users
            visible: Permission.isShow('monitor:online:list')
            icon:FluentIcons.Family
            menuDelegate: paneItemMenu
            url:"qrc:/example/qml/page/monitor/online/index.qml"
            onTap:{
                navigationView.push(url)
            }
        }
        // 定时任务
        QBDPaneItem{
            id:scheduled_task
            title:Lang.scheduled_task
            visible: Permission.isShow('monitor:job:list')
            icon:FluentIcons.Tiles
            menuDelegate: paneItemMenu
            url:"qrc:/example/qml/page/monitor/job/index.qml"
            onTap:{
                navigationView.push(url)
            }
        }
        // 服务监控
        QBDPaneItem{
            id:service_monitoring
            title:Lang.service_monitoring
            visible: Permission.isShow('monitor:server:list')
            icon:FluentIcons.EyeGaze
            menuDelegate: paneItemMenu
            url:"qrc:/example/qml/page/monitor/server/index.qml"
            onTap:{
                navigationView.push(url)
            }
        }
        // 缓存监控
        QBDPaneItem{
            id:cache_monitoring
            title:Lang.cache_monitoring
            visible: Permission.isShow('monitor:cache:list')
            icon:FluentIcons.CashDrawer
            menuDelegate: paneItemMenu
            url:"qrc:/example/qml/page/monitor/cache/index.qml"
            onTap:{
                navigationView.push(url)
            }
        }
        // 缓存列表
        QBDPaneItem{
            id:cache_list
            title:Lang.cache_list
            visible: Permission.isShow('monitor:cache:list')
            icon:FluentIcons.Favicon2
            menuDelegate: paneItemMenu
            url:"qrc:/example/qml/page/monitor/cache/cacheList.qml"
            onTap:{
                navigationView.push(url)
            }
        }
    }

    // 系统工具
    FluPaneItemExpander{
        id:system_tools
        title:Lang.system_tools
        icon:FluentIcons.DeveloperTools
        // 系统图标
        QBDPaneItem{
            id:system_iconfont
            title:Lang.system_iconfont
            icon:FluentIcons.ImageExport
            menuDelegate: paneItemMenu
            url:"qrc:/example/qml/page/Awesome.qml"
            onTap:{ navigationView.push(url) }
        }
        // 热加载器
        QBDPaneItem{
            id:system_hotloader
            title:Lang.system_hotloader
            icon:FluentIcons.ImageExport
            menuDelegate: paneItemMenu
            onTapListener:function(){
                FluRouter.navigate("/hotload")
            }
        }
    }

    // 获取最近添加的数据
    function getRecentlyAddedData(){
        var arr = []
        var items = navigationView.getItems();
        for(var i=0;i<items.length;i++){
            var item = items[i]
            if(item instanceof QBDPaneItem && item.extra && item.extra.recentlyAdded){
                arr.push(item)
            }
        }
        arr.sort(function(o1,o2){ return o2.extra.order-o1.extra.order })
        return arr
    }

    // 获取最近更新的数据
    function getRecentlyUpdatedData(){
        var arr = []
        var items = navigationView.getItems();
        for(var i=0;i<items.length;i++){
            var item = items[i]
            if(item instanceof QBDPaneItem && item.extra && item.extra.recentlyUpdated){
                arr.push(item)
            }
        }
        return arr
    }

    // 获取搜索的数据
    function getSearchData(){
        // 判断导航视图是否为空，如果为空，就返回
        if(!navigationView){
            return
        }
        // 创建临时导航项数组
        var arr = []
        // 获取导航视图中的导航项
        var items = navigationView.getItems();
        //
        for(var i=0;i<items.length;i++){
            var item = items[i]
            if(item instanceof QBDPaneItem){
                // 如果导航项的父类是导航数组
                if (item.parent instanceof FluPaneItemExpander)
                {
                    arr.push({title:`${item.parent.title} -> ${item.title}`,key:item.key})
                }
                else
                    // 如果仅是导航项
                    arr.push({title:item.title,key:item.key})
            }
        }
        return arr
    }

    // 起始页面
    function startPageByItem(data){
        navigationView.startPageByItem(data)
    }

}
