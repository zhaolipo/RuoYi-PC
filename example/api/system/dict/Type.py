from helper.RequestsClient import RequestsClient
from AppInfo import AppInfo

"""
重点：参数类型规则
    RuoYi-PC中参数 params 对应RuoYi-UI中的 params 
    RuoYi-PC中参数 json 对应RuoYi-UI中的 data
"""

class Type():

    def __init__(self):
        self.requestsClient = RequestsClient()
        self.appInfo = AppInfo()

    # 查询字典类型列表
    def listType(self, data):
        url = self.appInfo.baseUrl + "/system/dict/type/list"
        return self.requestsClient.get(url, params=data)
    
    # 查询字典类型详细
    def getType(self, dictId: str):
        url = self.appInfo.baseUrl + "/system/dict/type/" + dictId
        return self.requestsClient.get(url)
    
    # 新增字典类型
    def addType(self, data):
        url = self.appInfo.baseUrl + "/system/dict/type"
        return self.requestsClient.post(url, json=data)
    
    # 修改字典类型
    def updateType(self, data):
        url = self.appInfo.baseUrl + "/system/dict/type"
        return self.requestsClient.put(url, json=data)
    
    # 删除字典类型
    def delType(self, dictId: str):
        url = self.appInfo.baseUrl + "/system/dict/type/" + dictId
        return self.requestsClient.delete(url)
    
    # 刷新字典缓存
    def refreshCache(self):
        url = self.appInfo.baseUrl + "/system/dict/type/refreshCache"
        return self.requestsClient.delete(url)
    
    # 获取字典选择框列表
    def optionselect(self):
        url = self.appInfo.baseUrl + "/system/dict/type/optionselect"
        return self.requestsClient.get(url)







