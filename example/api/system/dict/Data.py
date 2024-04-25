from helper.RequestsClient import RequestsClient
from AppInfo import AppInfo

"""
重点：参数类型规则
    RuoYi-PC中参数 params 对应RuoYi-UI中的 params 
    RuoYi-PC中参数 json 对应RuoYi-UI中的 data
"""

class Data():

    def __init__(self):
        self.requestsClient = RequestsClient()
        self.appInfo = AppInfo()

    # 查询字典数据列表
    def listData(self, data):
        url = self.appInfo.baseUrl + "/system/dict/data/list"
        return self.requestsClient.get(url, params=data)
    
    # 查询字典数据详细
    def getData(self, dictCode: str):
        url = self.appInfo.baseUrl + "/system/dict/data/" + dictCode
        return self.requestsClient.get(url)
    
    # 根据字典类型查询字典数据信息
    def getDicts(self, dictType: str):
        url = self.appInfo.baseUrl + "/system/dict/data/type/" + dictType
        return self.requestsClient.get(url)
    
    # 新增字典数据
    def addData(self, data):
        url = self.appInfo.baseUrl + "/system/dict/data"
        return self.requestsClient.post(url, json=data)
    
    # 修改字典数据
    def updateData(self, data):
        url = self.appInfo.baseUrl + "/system/dict/data"
        return self.requestsClient.put(url, json=data)
    
    # 删除字典数据
    def delData(self, dictCode: str):
        url = self.appInfo.baseUrl + "/system/dict/data/" + dictCode
        return self.requestsClient.delete(url)





