from helper.RequestsClient import RequestsClient
from AppInfo import AppInfo

"""
重点：参数类型规则
    RuoYi-PC中参数 params 对应RuoYi-UI中的 params 
    RuoYi-PC中参数 json 对应RuoYi-UI中的 data
"""

class Gen():

    def __init__(self):
        self.requestsClient = RequestsClient()
        self.appInfo = AppInfo()

    # 查询生成表数据
    def listTable(self, data):
        url = self.appInfo.baseUrl + "/tool/gen/list"
        return self.requestsClient.get(url, params=data)
    
    # 查询db数据库列表
    def listDbTable(self, data):
        url = self.appInfo.baseUrl + "/tool/gen/db/list"
        return self.requestsClient.get(url, params=data)
    
    # 查询表详细信息
    def getGenTable(self, tableId: str):
        url = self.appInfo.baseUrl + "/tool/gen/" + tableId
        return self.requestsClient.get(url)
    
    # 修改代码生成信息
    def updateGenTable(self, data):
        url = self.appInfo.baseUrl + "/tool/gen"
        return self.requestsClient.put(url, json=data)
    
    # 导入表
    def importTable(self, data):
        url = self.appInfo.baseUrl + "/tool/gen/importTable"
        return self.requestsClient.post(url, params=data)
    
    # 创建表
    def createTable(self, data):
        url = self.appInfo.baseUrl + "/tool/gen/createTable"
        return self.requestsClient.post(url, params=data)
    
    # 预览生成代码
    def previewTable(self, tableId: str):
        url = self.appInfo.baseUrl + "/tool/gen/preview/" + tableId
        return self.requestsClient.get(url)
    
    # 删除表数据
    def delTable(self, tableId: str):
        url = self.appInfo.baseUrl + "/tool/gen/" + tableId
        return self.requestsClient.delete(url)
    
    # 生成代码（自定义路径）
    def genCode(self, tableName: str):
        url = self.appInfo.baseUrl + "/tool/gen/genCode/" + tableName
        return self.requestsClient.get(url)
    
    # 同步数据库
    def synchDb(self, tableName: str):
        url = self.appInfo.baseUrl + "/tool/gen/synchDb/" + tableName
        return self.requestsClient.get(url)






