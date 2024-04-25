from example.helper.RequestsClient import RequestsClient
from example.AppInfo import AppInfo

"""
重点：参数类型规则
    RuoYi-PC中参数 params 对应RuoYi-UI中的 params 
    RuoYi-PC中参数 json 对应RuoYi-UI中的 data
"""

class Cache():

    def __init__(self):
        self.requestsClient = RequestsClient()
        self.appInfo = AppInfo()

    # 查询缓存详细
    def getCache(self):
        url = self.appInfo.baseUrl + "/monitor/cache"
        return self.requestsClient.get(url)
    
    # 查询缓存名称列表
    def listCacheName(self):
        url = self.appInfo.baseUrl + "/monitor/cache/getNames"
        return self.requestsClient.get(url)
    
    # 查询缓存键名列表
    def listCacheKey(self, cacheName: str):
        url = self.appInfo.baseUrl + "/monitor/cache/getKeys/" + cacheName
        return self.requestsClient.get(url)
    
    # 查询缓存内容
    def getCacheValue(self, cacheName: str, cacheKey: str):
        url = self.appInfo.baseUrl + "/monitor/cache/getValue/" + cacheName + "/" + cacheKey
        return self.requestsClient.get(url)
    
    # 清理指定名称缓存
    def clearCacheName(self, cacheName: str):
        url = self.appInfo.baseUrl + "/monitor/cache/clearCacheName/" + cacheName
        return self.requestsClient.delete(url)
    
    # 清理指定键名缓存
    def clearCacheKey(self, cacheKey: str):
        url = self.appInfo.baseUrl + "/monitor/cache/clearCacheKey/" + cacheKey
        return self.requestsClient.delete(url)
    
    # 清理全部缓存
    def clearCacheAll(self):
        url = self.appInfo.baseUrl + "/monitor/cache/clearCacheAll"
        return self.requestsClient.delete(url)
    