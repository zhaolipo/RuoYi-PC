from example.helper.RequestsClient import RequestsClient
from example.AppInfo import AppInfo

"""
重点：参数类型规则
    RuoYi-PC中参数 params 对应RuoYi-UI中的 params 
    RuoYi-PC中参数 json 对应RuoYi-UI中的 data
"""

class Notice():

    def __init__(self):
        self.requestsClient = RequestsClient()
        self.appInfo = AppInfo()

    # 查询公告列表
    def listNotice(self, data):
        url = self.appInfo.baseUrl + "/system/notice/list"
        return self.requestsClient.get(url, params=data)

    # 查询公告详细
    def getNotice(self, noticeId: str):
        url = self.appInfo.baseUrl + "/system/notice/" + noticeId
        return self.requestsClient.get(url)

    # 新增公告
    def addNotice(self, data):
        url = self.appInfo.baseUrl + "/system/notice"
        return self.requestsClient.post(url, json=data)

    # 修改公告
    def updateNotice(self, data):
        url = self.appInfo.baseUrl + "/system/notice"
        return self.requestsClient.put(url, json=data)

    # 删除公告
    def delNotice(self, noticeId: str):
        url = self.appInfo.baseUrl + "/system/notice/" + noticeId
        return self.requestsClient.delete(url)






