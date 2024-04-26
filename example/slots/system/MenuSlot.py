from PySide6.QtCore import QObject, Signal, Property, Slot
from api.system.Menu import Menu
from define import Singleton

@Singleton
class MenuSlot(QObject):

    def __init__(self):
        super().__init__()

    @Slot(dict, result=dict)
    def listMenu(self, data):
        return Menu().listMenu(data)

    @Slot(str, result=dict)
    def getMenu(self, menuId):
        return Menu().getMenu(menuId)

    @Slot(result=dict)
    def treeselect(self):
        return Menu().treeselect()

    @Slot(str, result=dict)
    def roleMenuTreeselect(self, roleId):
        return Menu().roleMenuTreeselect(roleId)

    @Slot(dict, result=dict)
    def addMenu(self, data):
        return Menu().addMenu(data)

    @Slot(dict, result=dict)
    def updateMenu(self, data):
        return Menu().addMenu(data)

    @Slot(str, result=dict)
    def delMenu(self, menuId):
        return Menu().delMenu(menuId)