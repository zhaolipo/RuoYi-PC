from PySide6.QtCore import QObject, Signal, Property, Slot
from api.system.Config import Config
from define import Singleton

@Singleton
class ConfigSlot(QObject):

    def __init__(self):
        super().__init__()

    @Slot(dict, result=dict)
    def listConfig(self, data):
        return Config().listConfig(data)

    @Slot(str, result=dict)
    def getConfig(self, configId):
        return Config().getConfig(configId)

    @Slot(str, result=dict)
    def getConfigKey(self, configKey):
        return Config().getConfigKey(configKey)

    @Slot(dict, result=dict)
    def addConfig(self, data):
        return Config().addConfig(data)

    @Slot(dict, result=dict)
    def updateConfig(self, data):
        return Config().updateConfig(data)

    @Slot(str, result=dict)
    def delConfig(self, configId):
        return Config().delConfig(configId)

    @Slot(result=dict)
    def refreshCache(self):
        return Config().refreshCache()