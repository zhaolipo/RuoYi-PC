from example.helper.RequestsClient import RequestsClient
from example.AppInfo import AppInfo

"""
重点：参数类型规则
    RuoYi-PC中参数 params 对应RuoYi-UI中的 params 
    RuoYi-PC中参数 json 对应RuoYi-UI中的 data
"""

class Role():

    def __init__(self):
        self.requestsClient = RequestsClient()
        self.appInfo = AppInfo()

    def listRoleAll(self):
        url = self.appInfo.baseUrl + "/system/role/listAll"
        return self.requestsClient.get(url)

    # 查询角色列表
    def listRole(self, data):
        url = self.appInfo.baseUrl + "/system/role/list"
        return self.requestsClient.get(url, params=data)

    # 查询角色详细
    def getRole(self, roleId: str):
        url = self.appInfo.baseUrl + "/system/role/" + roleId
        return self.requestsClient.get(url)

    # 新增角色
    def addRole(self, data):
        url = self.appInfo.baseUrl + "/system/role"
        return self.requestsClient.post(url, json=data)

    # 修改角色
    def updateRole(self, data):
        url = self.appInfo.baseUrl + "/system/role"
        return self.requestsClient.put(url, json=data)

    # 角色数据权限
    def dataScope(self, data):
        url = self.appInfo.baseUrl + "/system/role/dataScope"
        return self.requestsClient.put(url, json=data)

    # 角色状态修改
    def changeRoleStatus(self, data):
        url = self.appInfo.baseUrl + "/system/role/changeStatus"
        return self.requestsClient.put(url, json=data)

    # 删除角色
    def delRole(self, roleId: str):
        url = self.appInfo.baseUrl + "/system/role/" + roleId
        return self.requestsClient.delete(url)

    # 查询角色已授权用户列表
    def allocatedUserList(self, data):
        url = self.appInfo.baseUrl + "/system/role/authUser/allocatedList"
        return self.requestsClient.get(url, params=data)

    # 查询角色未授权用户列表
    def unallocatedUserList(self, data):
        url = self.appInfo.baseUrl + "/system/role/authUser/unallocatedList"
        return self.requestsClient.get(url, params=data)

    # 取消用户授权角色
    def authUserCancel(self, data):
        url = self.appInfo.baseUrl + "/system/role/authUser/cancel"
        return self.requestsClient.put(url, json=data)

    # 批量取消用户授权角色
    def authUserCancelAll(self, data):
        url = self.appInfo.baseUrl + "/system/role/authUser/cancelAll"
        return self.requestsClient.put(url, params=data)

    # 授权用户选择
    def authUserSelectAll(self, data):
        url = self.appInfo.baseUrl + "/system/role/authUser/selectAll"
        return self.requestsClient.put(url, params=data)

    # 根据角色ID查询部门树结构
    def deptTreeSelect(self, roleId: str):
        url = self.appInfo.baseUrl + "/system/role/deptTree/" + roleId
        return self.requestsClient.get(url)







