from PySide6.QtCore import QObject, Signal, Property, Slot
from example.api.system.Post import Post
from example.api.Login import Login
from example.define import Singleton

@Singleton
class PostSlot(QObject):

    def __init__(self):
        super().__init__()

    @Slot(result=dict)
    def listPostAll(self):
        return Post().listPostAll()

    # 查询岗位列表
    @Slot(dict, result=dict)
    def listPost(self, data):
        return Post().listPost(data)

    # 查询岗位详细
    @Slot(str, result=dict)
    def getPost(self, postId):
        return Post().getPost(postId)

    # 新增岗位
    @Slot(dict, result=dict)
    def addPost(self, data):
        return Post().addPost(data)

    # 修改岗位
    @Slot(dict, result=dict)
    def updatePost(self, data):
        return Post().updatePost(data)

    # 删除岗位
    @Slot(str, result=dict)
    def delPost(self, postId):
        return Post().delPost(postId)





if __name__ == '__main__':
    # 第一步先登录
    login = Login()
    login.login('admin', 'admin123')


    postSlot = PostSlot()
    # data = {
    #     'pageNum': 1,
    #     'pageSize': 10,
    #     'postCode': None,
    #     'postName': '人力',
    #     'status': None
    # }
    # print(postSlot.listPost(data)['rows'])

    print(postSlot.listPostAll())