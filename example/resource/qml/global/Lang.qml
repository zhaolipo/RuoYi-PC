pragma Singleton

import QtQuick

QtObject {

    property string home
    property string basic_input
    property string form
    property string surface
    property string popus
    property string navigation
    property string theming
    property string media
    property string dark_mode
    property string sys_dark_mode
    property string search
    property string about
    property string settings
    property string locale
    property string navigation_view_display_mode
    property string other
    property string chart
    property string bar_chart
    property string line_chart
    property string pie_chart
    property string polar_area_chart
    property string bubble_chart
    property string scatter_chart
    property string radar_chart
    property string system_management
    property string user_management
    property string role_management
    property string menu_management
    property string department_management
    property string position_management
    property string dictionary_management
    property string parameter_settings
    property string notice_and_announcement
    property string oper_management
    property string login_management
    property string system_monitoring
    property string online_users
    property string scheduled_task
    property string service_monitoring
    property string cache_monitoring
    property string cache_list
    property string system_tools
    property string system_iconfont
    property string statistics_home
    property string system_hotloader

    function zh(){
        home="首页"
        basic_input="基本输入"
        form="表单"
        surface="表面"
        popus="弹窗"
        navigation="导航"
        theming="主题"
        media="媒体"
        dark_mode="夜间模式"
        sys_dark_mode="跟随系统"
        search="查找"
        about="关于"
        settings="设置"
        locale="语言环境"
        navigation_view_display_mode="导航视图显示模式"
        other="其他"
        chart="表格"
        bar_chart="条形图"
        line_chart="折线图"
        pie_chart="饼图"
        polar_area_chart="极坐标区域图"
        bubble_chart="气泡图"
        scatter_chart="散点图"
        radar_chart="雷达图"
        system_management="系统管理"
        user_management="用户管理"
        role_management="角色管理"
        menu_management="菜单管理"
        department_management="部门管理"
        position_management="岗位管理"
        dictionary_management="字典管理"
        parameter_settings="系统配置"
        notice_and_announcement="通知公告"
        oper_management="操作日志"
        login_management="登录日志"
        system_monitoring="系统监控"
        online_users="在线用户"
        scheduled_task="定时任务"
        service_monitoring="服务监控"
        cache_monitoring="缓存监控"
        cache_list="缓存列表"
        system_tools="系统工具"
        system_iconfont="系统图标"
        statistics_home="系统统计"
        system_hotloader="热加载器"
    }

    function en(){
        home="Home"
        basic_input="Basic Input"
        form="Form"
        surface="Surfaces"
        popus="Popus"
        navigation="Navigation"
        theming="Theming"
        media="Media"
        dark_mode="Dark Mode"
        sys_dark_mode="Sync with system"
        search="Search"
        about="About"
        settings="Settings"
        locale="Locale"
        navigation_view_display_mode="NavigationView Display Mode"
        other="Other"
        chart="Chart"
        bar_chart="Bar Chart"
        line_chart="Line Chart"
        pie_chart="Pie Chart"
        polar_area_chart="Polar Area Chart"
        bubble_chart="Bubble Chart"
        scatter_chart="Scatter Chart"
        radar_chart="Radar Chart"
        system_management="System Management"
        user_management="User Management"
        role_management="Role Management"
        menu_management="Menu Management"
        department_management="Department Management"
        position_management="Position Management"
        dictionary_management="Dictionary Management"
        parameter_settings="Parameter Settings"
        notice_and_announcement="Notice And Announcement"
        oper_management="Operation Management"
        login_management="Login Management"
        system_monitoring="System Monitoring"
        online_users="Online Users"
        scheduled_task="Scheduled Task"
        service_monitoring="Service Monitoring"
        cache_monitoring="Cache Monitoring"
        cache_list="Cache List"
        system_tools="System Tools"
        system_iconfont="System Iconfont"
        statistics_home="System Statistics"
        system_hotloader="Hot Loader"
    }

    property string __locale
    property var __localeList: ["Zh","En"]

    on__LocaleChanged: {
        if(__locale === "Zh"){
            zh()
        }else{
            en()
        }
    }

    Component.onCompleted: {
        __locale = "Zh"
    }

}
