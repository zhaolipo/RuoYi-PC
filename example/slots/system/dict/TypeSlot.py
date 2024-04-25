from PySide6.QtCore import QObject, Signal, Property, Slot
from api.system.dict.Data import Data
from define import Singleton

@Singleton
class TypeSlot(QObject):

    def __init__(self):
        super().__init__()