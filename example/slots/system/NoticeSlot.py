from PySide6.QtCore import QObject, Signal, Property, Slot
from api.system.Notice import Notice
from define import Singleton

@Singleton
class NoticeSlot(QObject):

    def __init__(self):
        super().__init__()

    @Slot(dict, result=dict)
    def listNotice(self, data):
        return Notice().listNotice(data)

    @Slot(str, result=dict)
    def getNotice(self, noticeId):
        return Notice().getNotice(noticeId)

    @Slot(dict, result=dict)
    def addNotice(self, data):
        return Notice().addNotice(data)

    @Slot(dict, result=dict)
    def updateNotice(self, data):
        return Notice().updateNotice(data)

    @Slot(str, result=dict)
    def delNotice(self, noticeId):
        return Notice().delNotice(noticeId)