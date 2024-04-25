from example.helper.RequestsClient import RequestsClient
from example.AppInfo import AppInfo

"""
重点：参数类型规则
    RuoYi-PC中参数 params 对应RuoYi-UI中的 params 
    RuoYi-PC中参数 json 对应RuoYi-UI中的 data
"""

class Online():

    def __init__(self):
        self.requestsClient = RequestsClient()
        self.appInfo = AppInfo()

    # 查询在线用户列表
    def list(self, data):
        url = self.appInfo.baseUrl + "/monitor/online/list"
        return self.requestsClient.get(url, params=data)
    
    # 强退用户
    def forceLogout(self, tokenId: str):
        url = self.appInfo.baseUrl + "/monitor/online/" + tokenId
        return self.requestsClient.delete(url)
    