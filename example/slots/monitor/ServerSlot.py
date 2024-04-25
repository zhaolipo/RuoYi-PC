from PySide6.QtCore import QObject, Signal, Property, Slot
from api.monitor.Server import Server
from define import Singleton

@Singleton
class ServerSlot(QObject):

    def __init__(self):
        super().__init__()

    @Slot(result=dict)
    def getServer(self):
        return Server().getServer()
