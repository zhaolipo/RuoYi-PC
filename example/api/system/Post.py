from example.helper.RequestsClient import RequestsClient
from example.AppInfo import AppInfo

"""
重点：参数类型规则
    RuoYi-PC中参数 params 对应RuoYi-UI中的 params 
    RuoYi-PC中参数 json 对应RuoYi-UI中的 data
"""

class Post():

    def __init__(self):
        self.requestsClient = RequestsClient()
        self.appInfo = AppInfo()

    # 岗位列表
    def listPostAll(self):
        url = self.appInfo.baseUrl + "/system/post/listAll"
        return self.requestsClient.get(url)

    # 查询岗位列表
    def listPost(self, data):
        url = self.appInfo.baseUrl + "/system/post/list"
        return self.requestsClient.get(url, params=data)


    # 查询岗位详细
    def getPost(self, postId: str):
        url = self.appInfo.baseUrl + "/system/post/" + postId
        return self.requestsClient.get(url)


    # 新增岗位
    def addPost(self, data):
        url = self.appInfo.baseUrl + "/system/post"
        return self.requestsClient.post(url, json=data)


    # 修改岗位
    def updatePost(self, data):
        url = self.appInfo.baseUrl + "/system/post"
        return self.requestsClient.put(url, json=data)


    # 删除岗位
    def delPost(self, postId):
        url = self.appInfo.baseUrl + "/system/post/" + postId
        return self.requestsClient.delete(url)














