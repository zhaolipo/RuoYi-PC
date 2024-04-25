from PySide6.QtCore import QObject, Signal, Property, Slot
from example.api.monitor.Server import Server
from example.define import Singleton

@Singleton
class ServerSlot(QObject):

    def __init__(self):
        super().__init__()

    @Slot(result=dict)
    def getServer(self):
        return Server().getServer()
