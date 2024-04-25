from PySide6.QtCore import QObject, Signal, Property, Slot
from example.api.system.Role import Role
from example.api.Login import Login
from example.define import Singleton

@Singleton
class RoleSlot(QObject):

    def __init__(self):
        super().__init__()

    @Slot(result=dict)
    def listRoleAll(self):
        return Role().listRoleAll()

    # 查询岗位列表
    @Slot(dict, result=dict)
    def listRole(self, data):
        return Role().listRole(data)

    @Slot(str, result=dict)
    def getRole(self, roleId):
        return Role().getRole(roleId)

    @Slot(dict, result=dict)
    def addRole(self, data):
        return Role().addRole(data)

    @Slot(dict, result=dict)
    def updateRole(self, data):
        return Role().updateRole(data)

    @Slot(dict, result=dict)
    def dataScope(self, data):
        return Role().dataScope(data)

    @Slot(dict, result=dict)
    def changeRoleStatus(self, data):
        return Role().changeRoleStatus(data)

    @Slot(str, result=dict)
    def delRole(self, roleId):
        return Role().delRole(roleId)

    @Slot(dict, result=dict)
    def allocatedUserList(self, data):
        return Role().allocatedUserList(data)

    @Slot(dict, result=dict)
    def unallocatedUserList(self, data):
        return Role().unallocatedUserList(data)

    @Slot(dict, result=dict)
    def authUserCancel(self, data):
        return Role().authUserCancel(data)

    @Slot(dict, result=dict)
    def authUserCancelAll(self, data):
        return Role().authUserCancelAll(data)

    @Slot(dict, result=dict)
    def authUserSelectAll(self, data):
        return Role().authUserSelectAll(data)

    @Slot(str, result=dict)
    def deptTreeSelect(self, roleId):
        return Role().deptTreeSelect(roleId)