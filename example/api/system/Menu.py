from helper.RequestsClient import RequestsClient
from AppInfo import AppInfo

"""
重点：参数类型规则
    RuoYi-PC中参数 params 对应RuoYi-UI中的 params 
    RuoYi-PC中参数 json 对应RuoYi-UI中的 data
"""

class Menu():

    def __init__(self):
        self.requestsClient = RequestsClient()
        self.appInfo = AppInfo()

    # 查询菜单列表
    def listMenu(self, data):
        url = self.appInfo.baseUrl + "/system/menu/list"
        result = self.requestsClient.get(url, params=data)
        return result


    # 查询菜单详细
    def getMenu(self, menuId: str):
        url = self.appInfo.baseUrl + "/system/menu/" + menuId
        result = self.requestsClient.get(url)
        return result


    # 查询菜单下拉树结构
    def treeselect(self):
        url = self.appInfo.baseUrl + "/system/menu/treeselect"
        result = self.requestsClient.get(url)
        return result


    # 根据角色ID查询菜单下拉树结构
    def roleMenuTreeselect(self, roleId: str):
        url = self.appInfo.baseUrl + "/system/menu/roleMenuTreeselect/" + roleId
        result = self.requestsClient.get(url)
        return result


    # 新增菜单
    def addMenu(self, data):
        url = self.appInfo.baseUrl + "/system/menu"
        result = self.requestsClient.post(url, json=data)
        return result


    # 修改菜单
    def updateMenu(self, data):
        url = self.appInfo.baseUrl + "/system/menu"
        result = self.requestsClient.put(url, json=data)
        return result


    # 删除菜单
    def delMenu(self, menuId: str):
        url = self.appInfo.baseUrl + "/system/menu/" + menuId
        result = self.requestsClient.delete(url)
        return result