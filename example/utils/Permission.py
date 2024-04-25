from PySide6.QtCore import QObject, Signal, Property, Slot
from example.AppInfo import AppInfo
from example.define import Singleton

@Singleton
class Permission(QObject):

    def __init__(self):
        super().__init__()




    @Slot(str, result=bool)
    def isShow(self, permi: str):
        # 如果当前账号有管理员角色 ['admin']
        if 'admin' in AppInfo().roles:
            return True # 返回 True 表示菜单可见
        else:
            # 判断当前按钮是否有权限
            if permi in AppInfo().permissions:
                return True
            else:
                return False



    @Slot(str, result=bool)
    def isHasPermi(self, permi: str):
        # 如果当前账号有管理员角色 ['admin']
        if 'admin' in AppInfo().roles:
            return False # 返回 False 表示按钮可用
        else:
            # 判断当前按钮是否有权限
            if permi in AppInfo().permissions:
                return False
            else:
                return True




    @Slot(str, result=bool)
    def isHasRole(self, permi: str):
        # 如果当前账号有管理员角色 ['admin']
        if 'admin' in AppInfo().roles:
            return False  # 返回 False 表示按钮可用
        else:
            return True

