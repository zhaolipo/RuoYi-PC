from helper.RequestsClient import RequestsClient
from AppInfo import AppInfo

"""
重点：参数类型规则
    RuoYi-PC中参数 params 对应RuoYi-UI中的 params 
    RuoYi-PC中参数 json 对应RuoYi-UI中的 data
"""

class Dept():

    def __init__(self):
        self.requestsClient = RequestsClient()
        self.appInfo = AppInfo()


    # 查询部门列表
    def listDept(self, data):
        url = self.appInfo.baseUrl + "/system/dept/list"
        result = self.requestsClient.get(url, params=data)
        return result


    # 查询部门列表（排除节点）
    def listDeptExcludeChild(self, deptId: str):
        url = self.appInfo.baseUrl + "/system/dept/list/exclude/" + deptId
        result = self.requestsClient.get(url)
        return result


    # 查询部门详细
    def getDept(self, deptId: str):
        url = self.appInfo.baseUrl + "/system/dept/"  + deptId
        result = self.requestsClient.get(url)
        return result


    # 新增部门
    def addDept(self, data):
        url = self.appInfo.baseUrl + "/system/dept"
        result = self.requestsClient.post(url, json=data)
        return result


    # 修改部门
    def updateDept(self, data):
        url = self.appInfo.baseUrl + "/system/dept"
        result = self.requestsClient.put(url, json=data)
        return result


    # 删除部门
    def delDept(self, deptId: str):
        url = self.appInfo.baseUrl + "/system/dept/" + deptId
        result = self.requestsClient.delete(url)
        return result

