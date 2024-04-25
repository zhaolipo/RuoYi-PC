from PySide6.QtCore import QObject, Signal, Property, Slot
from example.define import Singleton
import importlib

@Singleton
class AppInfo(QObject):

    versionChanged = Signal()  # 系统版本
    appNameChanged = Signal()  # 后端URL
    baseUrlChanged = Signal()  # 后端URL
    tokenChanged = Signal()    # Token 值
    permissionsChanged = Signal()    # 权限值
    rolesChanged = Signal()    # 角色值
    userChanged = Signal()    # 用户值
    routersChanged = Signal()    # 路由值

    def __init__(self):
        QObject.__init__(self)
        self._appName = "千百道"
        self._baseUrl = "http://localhost:8080"
        self._token = ""
        self._permissions = []
        self._roles = []
        self._user = {}
        self._routers = []
        try:
            version = importlib.import_module('version')
            if (version):
                self._version = version.getVersion()
        except Exception:
            self._version = "1.0.0"



    # 系统版本
    @Property(str, notify=versionChanged)
    def version(self):
        return self._version
    @version.setter
    def version(self, val):
        self._version = val
        self.versionChanged.emit()




    # 系统名称
    @Property(str, notify=appNameChanged)
    def appName(self):
        return self._appName
    @appName.setter
    def appName(self, val):
        self._appName = val
        self.appNameChanged.emit()



    # 后端 URL
    @Property(str, notify=baseUrlChanged)
    def baseUrl(self):
        return self._baseUrl
    @baseUrl.setter
    def baseUrl(self, val):
        self._baseUrl = val
        self.baseUrlChanged.emit()



    # Token 令牌
    @Property(str, notify=tokenChanged)
    def token(self):
        return self._token
    @token.setter
    def token(self, val):
        self._token = val
        self.tokenChanged.emit()



    # 权限值
    @Property(list, notify=permissionsChanged)
    def permissions(self):
        return self._permissions
    @permissions.setter
    def permissions(self, val):
        self._permissions = val
        print("权限值：", self._permissions)
        self.permissionsChanged.emit()



    # 角色值
    @Property(list, notify=rolesChanged)
    def roles(self):
        return self._roles
    @roles.setter
    def roles(self, val):
        self._roles = val
        print("角色值：", self._roles)
        self.rolesChanged.emit()



    # 用户值
    @Property(dict, notify=userChanged)
    def user(self):
        return self._user
    @user.setter
    def user(self, val):
        self._user = val
        print("设置USER值：", self._user)
        print(" ====================================================================================================== ")
        self.userChanged.emit()



    # 路由值
    @Property(list, notify=routersChanged)
    def routers(self):
        return self._routers
    @routers.setter
    def routers(self, val):
        self._routers = val
        print("路由值：", self._routers)
        self.routersChanged.emit()