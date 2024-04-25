from PySide6.QtCore import QObject, Signal, Property, Slot
from api.system.User import User
from define import Singleton

@Singleton
class UserSlot(QObject):

    def __init__(self):
        super().__init__()

    @Slot(result=dict)
    def getInfo(self):
        return User().getInfo()

    @Slot(result=dict)
    def logout(self):
        return User().logout()

    @Slot(dict, result=dict)
    def listUser(self, data):
        return User().listUser(data)

    @Slot(str, result=dict)
    def getUser(self, userId):
        return User().getUser(userId)

    @Slot(dict, result=dict)
    def addUser(self, data):
        return User().addUser(data)

    @Slot(dict, result=dict)
    def updateUser(self, data):
        return User().updateUser(data)

    @Slot(str, result=dict)
    def delUser(self, userId):
        return User().delUser(userId)

    @Slot(dict, result=dict)
    def resetUserPwd(self, data):
        return User().resetUserPwd(data)

    @Slot(dict, result=dict)
    def changeUserStatus(self, data):
        return User().changeUserStatus(data)

    @Slot(result=dict)
    def getUserProfile(self):
        return User().getUserProfile()

    @Slot(dict, result=dict)
    def updateUserProfile(self, data):
        return User().updateUserProfile(data)

    @Slot(dict, result=dict)
    def updateUserPwd(self, data):
        return User().updateUserPwd(data)

    @Slot(dict, result=dict)
    def uploadAvatar(self, data):
        return User().uploadAvatar(data)

    @Slot(str, result=dict)
    def getAuthRole(self, userId):
        return User().getAuthRole(userId)

    @Slot(dict, result=dict)
    def updateAuthRole(self, data):
        return User().updateAuthRole(data)

    @Slot(result=dict)
    def deptTreeSelect(self):
        return User().deptTreeSelect()
