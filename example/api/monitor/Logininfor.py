from helper.RequestsClient import RequestsClient
from AppInfo import AppInfo

"""
重点：参数类型规则
    RuoYi-PC中参数 params 对应RuoYi-UI中的 params 
    RuoYi-PC中参数 json 对应RuoYi-UI中的 data
"""

class Logininfor():

    def __init__(self):
        self.requestsClient = RequestsClient()
        self.appInfo = AppInfo()

    # 查询登录日志列表
    def list(self, data):
        url = self.appInfo.baseUrl + "/monitor/logininfor/list"
        return self.requestsClient.get(url, params=data)
    
    # 删除登录日志
    def delLogininfor(self, infoId):
        url = self.appInfo.baseUrl + "/monitor/logininfor/" + infoId
        return self.requestsClient.delete(url)
    
    # 解锁用户登录状态
    def unlockLogininfor(self, userName: str):
        url = self.appInfo.baseUrl + "/monitor/logininfor/unlock/" + userName
        return self.requestsClient.get(url)
    
    # 清空登录日志
    def cleanLogininfor(self):
        url = self.appInfo.baseUrl + "/monitor/logininfor/clean"
        return self.requestsClient.delete(url)
    