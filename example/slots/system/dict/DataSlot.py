from PySide6.QtCore import QObject, Signal, Property, Slot
from api.system.dict.Data import Data
from define import Singleton

@Singleton
class DataSlot(QObject):

    def __init__(self):
        super().__init__()

    @Slot(dict, result=dict)
    def listData(self, data):
        return Data().listData(data)