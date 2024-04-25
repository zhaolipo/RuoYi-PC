from example.helper.RequestsClient import RequestsClient
from example.AppInfo import AppInfo

"""
重点：参数类型规则
    RuoYi-PC中参数 params 对应RuoYi-UI中的 params 
    RuoYi-PC中参数 json 对应RuoYi-UI中的 data
"""

class Operlog():

    def __init__(self):
        self.requestsClient = RequestsClient()
        self.appInfo = AppInfo()

    # 查询操作日志列表
    def list(self, data):
        url = self.appInfo.baseUrl + "/monitor/operlog/list"
        return self.requestsClient.get(url, params=data)

    # 删除操作日志
    def delOperlog(self, operId: str):
        url = self.appInfo.baseUrl + "/monitor/operlog/" + operId
        return self.requestsClient.delete(url)

    # 清空操作日志
    def cleanOperlog(self):
        url = self.appInfo.baseUrl + "/monitor/operlog/clean"
        return self.requestsClient.delete(url)
