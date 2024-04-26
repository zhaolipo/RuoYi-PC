# This Python file uses the following encoding: utf-8
import sys
import os
from PySide6.QtCore import QProcess
from PySide6.QtQuick import QQuickWindow,QSGRendererInterface
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
import FluentUI
from AppInfo import AppInfo
from helper.SettingsHelper import SettingsHelper
# 引入槽函数
from slots.monitor.CacheSlot import CacheSlot
from slots.monitor.JobLogSlot import JobLogSlot
from slots.monitor.JobSlot import JobSlot
from slots.monitor.LogininforSlot import LogininforSlot
from slots.monitor.OnlineSlot import OnlineSlot
from slots.monitor.OperlogSlot import OperlogSlot
from slots.monitor.ServerSlot import ServerSlot
from slots.system.dict.DataSlot import DataSlot
from slots.system.dict.TypeSlot import TypeSlot
from slots.system.ConfigSlot import ConfigSlot
from slots.system.DeptSlot import DeptSlot
from slots.system.MenuSlot import MenuSlot
from slots.system.NoticeSlot import NoticeSlot
from slots.system.PostSlot import PostSlot
from slots.system.RoleSlot import RoleSlot
from slots.system.UserSlot import UserSlot
from slots.LoginSlot import LoginSlot
# 引入权限槽函数
from utils.Permission import Permission

# 注册资源以及自定义的QML组件
from component.CircularReveal import CircularReveal
from component.FileWatcher import FileWatcher
from component.FpsItem import FpsItem
import helper.Log as Log

import os
import subprocess

# cd example/resource
# pyside6-rcc example.qrc -o example_rc.py

def main():
    try:
        print("===================================================")
        subprocess.run(['pyside6-rcc', './resource/example.qrc', '-o', './resource/example_rc.py'], check=True)
        import resource.example_rc as rc
        print("执行 pyside6-rcc example.qrc -o example_rc.py 命令")
        print("===================================================")
    except subprocess.CalledProcessError as e:
        print("执行 pyside6-rcc example.qrc -o example_rc.py 命令出错")


    Log.setup("example")
    QQuickWindow.setGraphicsApi(QSGRendererInterface.GraphicsApi.OpenGL)
    os.environ["QT_QUICK_CONTROLS_STYLE"] = "Basic"
    QGuiApplication.setOrganizationName("ZhuZiChu")
    QGuiApplication.setOrganizationDomain("https://zhuzichu520.github.io")
    QGuiApplication.setApplicationName("FluentUI")
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # 注册到 QML 上下文
    rootContext = engine.rootContext()

    rootContext.setContextProperty("AppInfo", AppInfo())
    rootContext.setContextProperty("SettingsHelper", SettingsHelper())
    rootContext.setContextProperty("Permission", Permission())

    rootContext.setContextProperty("CacheSlot", CacheSlot())
    rootContext.setContextProperty("JobLogSlot", JobLogSlot())
    rootContext.setContextProperty("JobSlot", JobSlot())
    rootContext.setContextProperty("LogininforSlot", LogininforSlot())
    rootContext.setContextProperty("OnlineSlot", OnlineSlot())
    rootContext.setContextProperty("OperlogSlot", OperlogSlot())
    rootContext.setContextProperty("ServerSlot", ServerSlot())
    rootContext.setContextProperty("DataSlot", DataSlot())
    rootContext.setContextProperty("TypeSlot", TypeSlot())
    rootContext.setContextProperty("ConfigSlot", ConfigSlot())
    rootContext.setContextProperty("DeptSlot", DeptSlot())
    rootContext.setContextProperty("MenuSlot", MenuSlot())
    rootContext.setContextProperty("NoticeSlot", NoticeSlot())
    rootContext.setContextProperty("PostSlot", PostSlot())
    rootContext.setContextProperty("RoleSlot", RoleSlot())
    rootContext.setContextProperty("UserSlot", UserSlot())
    rootContext.setContextProperty("LoginSlot", LoginSlot())

    FluentUI.init(engine)
    print(engine.importPathList())
    qml_file = "qrc:/example/qml/App.qml"
    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    exec = app.exec()
    if(exec == 931):
        #QGuiApplication.applicationFilePath()需要打包成exe后才能正确的路径重启，不然这个函数获取的路径是python的路径
        args = QGuiApplication.arguments()[1:]
        QProcess.startDetached(QGuiApplication.applicationFilePath(),args)
    return exec

if __name__ == "__main__":
    main()