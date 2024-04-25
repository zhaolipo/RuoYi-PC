from PySide6.QtCore import QObject, Signal, Property, Slot
from example.api.monitor.Online import Online
from example.define import Singleton

@Singleton
class OnlineSlot(QObject):

    def __init__(self):
        super().__init__()

    @Slot(dict, result=dict)
    def list(self, data):
        return Online().list(data)

    @Slot(str, result=dict)
    def forceLogout(self, tokenId: str):
        return Online().forceLogout(tokenId)
