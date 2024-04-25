from PySide6.QtCore import QObject, Signal, Property, Slot
from example.api.system.Dept import Dept
from example.define import Singleton

@Singleton
class DeptSlot(QObject):

    def __init__(self):
        super().__init__()

    @Slot(dict, result=dict)
    def listDept(self, data):
        return Dept().listDept(data)

    @Slot(str, result=dict)
    def listDeptExcludeChild(self, deptId):
        return Dept().listDeptExcludeChild(deptId)

    @Slot(str, result=dict)
    def getDept(self, deptId):
        return Dept().getDept(deptId)

    @Slot(dict, result=dict)
    def addDept(self, data):
        return Dept().addDept(data)

    @Slot(dict, result=dict)
    def updateDept(self, data):
        return Dept().updateDept(data)

    @Slot(str, result=dict)
    def delDept(self, deptId):
        return Dept().delDept(deptId)