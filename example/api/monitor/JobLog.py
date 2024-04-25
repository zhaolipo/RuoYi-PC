from example.helper.RequestsClient import RequestsClient
from example.AppInfo import AppInfo

"""
重点：参数类型规则
    RuoYi-PC中参数 params 对应RuoYi-UI中的 params 
    RuoYi-PC中参数 json 对应RuoYi-UI中的 data
"""

class JobLog():

    def __init__(self):
        self.requestsClient = RequestsClient()
        self.appInfo = AppInfo()

    # 查询调度日志列表
    def listJobLog(self, data):
        url = self.appInfo.baseUrl + "/monitor/jobLog/list"
        return self.requestsClient.get(url, params=data)
    
    # 删除调度日志
    def delJobLog(self, jobLogId: str):
        url = self.appInfo.baseUrl + "/monitor/jobLog/" + jobLogId
        return self.requestsClient.delete(url)
    
    # 清空调度日志
    def cleanJobLog(self):
        url = self.appInfo.baseUrl + "/monitor/jobLog/clean"
        return self.requestsClient.delete(url)
    
    