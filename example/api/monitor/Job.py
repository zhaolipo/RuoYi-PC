from helper.RequestsClient import RequestsClient
from AppInfo import AppInfo

"""
重点：参数类型规则
    RuoYi-PC中参数 params 对应RuoYi-UI中的 params 
    RuoYi-PC中参数 json 对应RuoYi-UI中的 data
"""

class Job():

    def __init__(self):
        self.requestsClient = RequestsClient()
        self.appInfo = AppInfo()

    # 查询定时任务调度列表
    def listJob(self, data):
        url = self.appInfo.baseUrl + "/monitor/job/list"
        return self.requestsClient.get(url, params=data)
    
    # 查询定时任务调度详细
    def getJob(self, jobId: str):
        url = self.appInfo.baseUrl + "/monitor/job/" + jobId
        return self.requestsClient.get(url)
    
    # 新增定时任务调度
    def addJob(self, data):
        url = self.appInfo.baseUrl + "/monitor/job"
        return self.requestsClient.post(url, json=data)
    
    # 修改定时任务调度
    def updateJob(self, data):
        url = self.appInfo.baseUrl + "/monitor/job"
        return self.requestsClient.put(url, json=data)
    
    # 删除定时任务调度
    def delJob(self, jobId: str):
        url = self.appInfo.baseUrl + "/monitor/job/" + jobId
        return self.requestsClient.delete(url)
    
    # 任务状态修改
    def changeJobStatus(self, data):
        url = self.appInfo.baseUrl + "/monitor/job/changeStatus"
        return self.requestsClient.put(url, json=data)
    
    # 定时任务立即执行一次
    def runJob(self, data):
        url = self.appInfo.baseUrl + "/monitor/job/run"
        return self.requestsClient.put(url, json=data)
    
