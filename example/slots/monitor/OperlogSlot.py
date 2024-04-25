from PySide6.QtCore import QObject, Signal, Property, Slot
from api.monitor.Operlog import Operlog
from define import Singleton

@Singleton
class OperlogSlot(QObject):

    def __init__(self):
        super().__init__()

    @Slot(dict, result=dict)
    def list(self, data):
        return Operlog().list(data)

    @Slot(str, result=dict)
    def delOperlog(self, operId: str):
        return Operlog().delOperlog(operId)

    @Slot(result=dict)
    def cleanOperlog(self):
        return Operlog().cleanOperlog()
