from PySide6.QtCore import QObject, Signal, Property, Slot
from api.monitor.Logininfor import Logininfor
from define import Singleton

@Singleton
class LogininforSlot(QObject):

    def __init__(self):
        super().__init__()

    @Slot(dict, result=dict)
    def list(self, data):
        return Logininfor().list(data)

    @Slot(str, result=dict)
    def delLogininfor(self, infoId):
        return Logininfor().delLogininfor(infoId)

    @Slot(str, result=dict)
    def unlockLogininfor(self, userName: str):
        return Logininfor().unlockLogininfor(userName)

    @Slot(result=dict)
    def cleanLogininfor(self):
        return Logininfor().cleanLogininfor()