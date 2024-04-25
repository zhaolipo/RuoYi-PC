from PySide6.QtCore import QObject, Signal, Property, Slot
from example.api.system.dict.Data import Data
from example.define import Singleton

@Singleton
class TypeSlot(QObject):

    def __init__(self):
        super().__init__()