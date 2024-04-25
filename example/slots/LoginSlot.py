from PySide6.QtCore import QObject, Signal, Property, Slot
from api.Login import Login
from define import Singleton

@Singleton
class LoginSlot(QObject):

    def __init__(self):
        super().__init__()

    # 登录槽函数
    @Slot(str, str, result=dict)
    def login(self, username: str, password: str):
        return Login().login(username=username, password=password)
