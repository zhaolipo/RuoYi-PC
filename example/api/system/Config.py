from helper.RequestsClient import RequestsClient
from AppInfo import AppInfo

"""
重点：参数类型规则
    RuoYi-PC中参数 params 对应RuoYi-UI中的 params 
    RuoYi-PC中参数 json 对应RuoYi-UI中的 data
"""

class Config():

    def __init__(self):
        self.requestsClient = RequestsClient()
        self.appInfo = AppInfo()


    # 查询参数列表
    def listConfig(self, data):
        url = self.appInfo.baseUrl + "/system/config/list"
        result = self.requestsClient.get(url, params=data)
        return result


    # 查询参数详细
    def getConfig(self, configId: str):
        url = self.appInfo.baseUrl + "/system/config/" + configId
        result = self.requestsClient.get(url)
        return result


    # 根据参数键名查询参数值
    def getConfigKey(self, configKey: str):
        url = self.appInfo.baseUrl + "/system/config/configKey/" + configKey
        result = self.requestsClient.get(url)
        return result


    # 新增参数配置
    def addConfig(self, data):
        url = self.appInfo.baseUrl + "/system/config"
        result = self.requestsClient.post(url, json=data)
        return result


    # 修改参数配置
    def updateConfig(self, data):
        url = self.appInfo.baseUrl + "/system/config"
        result = self.requestsClient.put(url, json=data)
        return result


    # 删除参数配置
    def delConfig(self, configId: str):
        url = self.appInfo.baseUrl + "/system/config/" + configId
        result = self.requestsClient.delete(url)
        return result


    # 刷新参数缓存
    def refreshCache(self):
        url = self.appInfo.baseUrl + "/system/config/refreshCache"
        result = self.requestsClient.delete(url)
        return result


