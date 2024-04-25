from helper.RequestsClient import RequestsClient
from api.Login import Login
from AppInfo import AppInfo

"""
重点：参数类型规则
    RuoYi-PC中参数 params 对应RuoYi-UI中的 params 
    RuoYi-PC中参数 json 对应RuoYi-UI中的 data
"""

class User():

    def __init__(self):
        self.requestsClient = RequestsClient()
        self.appInfo = AppInfo()


    # 获取用户详细信息
    def getInfo(self):
        url = self.appInfo.baseUrl + "/getInfo"
        result = self.requestsClient.get(url)
        if result['code'] == 200:
            self.appInfo.permissions = result['permissions']
            self.appInfo.roles = result['roles']
            self.appInfo.user = result['user']
        return result


    # 退出方法
    def logout(self):
        url = self.appInfo.baseUrl + "/logout"
        return self.requestsClient.post(url)


    # 查询用户列表
    def listUser(self, data=None):
        url = self.appInfo.baseUrl + "/system/user/list"
        result = self.requestsClient.get(url, params=data)
        return result


    # 查询用户详细
    def getUser(self, userId: str):
        url = self.appInfo.baseUrl + "/system/user/" + userId
        result = self.requestsClient.get(url)
        return result


    # 新增用户
    def addUser(self, data):
        url = self.appInfo.baseUrl + "/system/user"
        result = self.requestsClient.post(url, json=data)
        return result


    # 修改用户
    def updateUser(self, data):
        url = self.appInfo.baseUrl + "/system/user"
        result = self.requestsClient.put(url, json=data)
        return result


    # 删除用户
    def delUser(self, userId):
        url = self.appInfo.baseUrl + "/system/user/" + userId
        result = self.requestsClient.delete(url)
        return result


    # 用户密码重置
    def resetUserPwd(self, data):
        url = self.appInfo.baseUrl + "/system/user/resetPwd"
        result = self.requestsClient.put(url, json=data)
        return result


    # 用户状态修改
    def changeUserStatus(self, data):
        url = self.appInfo.baseUrl + "/system/user/changeStatus"
        result = self.requestsClient.put(url, json=data)
        return result


    # 查询当前登录的用户个人信息
    def getUserProfile(self):
        url = self.appInfo.baseUrl + "/system/user/profile"
        result = self.requestsClient.get(url)
        return result


    # 修改当前登录的用户个人信息
    def updateUserProfile(self, data):
        url = self.appInfo.baseUrl + "/system/user/profile"
        result = self.requestsClient.put(url, json=data)
        return result


    # 当前登录的用户密码重置
    def updateUserPwd(self, data):
        url = self.appInfo.baseUrl + "/system/user/profile/updatePwd"
        result = self.requestsClient.put(url, params=data)
        return result


    # 当前登录的用户头像上传
    def uploadAvatar(self, data):
        url = self.appInfo.baseUrl + "/system/user/profile/avatar"
        result = self.requestsClient.post(url, json=data)
        return result


    # 当前登录的用户查询授权角色
    def getAuthRole(self, userId: str):
        url = self.appInfo.baseUrl + "/system/user/authRole/" + userId
        result = self.requestsClient.get(url)
        return result


    # 当前登录的用户保存授权角色
    def updateAuthRole(self, data):
        url = self.appInfo.baseUrl + "/system/user/authRole"
        result = self.requestsClient.put(url, params=data)
        return result


    # 当前登录的用户查询部门下拉树结构
    def deptTreeSelect(self):
        url = self.appInfo.baseUrl + "/system/user/deptTree"
        result = self.requestsClient.get(url)
        return result


if __name__ == '__main__':
    # 第一步先登录
    login = Login()
    login.login('admin', 'admin123')

    user = User()

    # 获取用户详细信息
    print(user.getInfo())

    # 查询用户列表
    # data = {
    #     'userName': 'admin'
    # }
    # print(user.listUser(data))

    # 查询用户详细
    # print(user.getUser('2'))

    # 新增用户
    # data = {
    #     'userName': 'zhaolipo1',
    #     'nickName': '赵利坡',
    #     'email': '290010221@qq.com',
    #     'phonenumber': '17736758808',
    #     'sex': '2',
    #     'password': '111111111',
    #     'status': '0',
    #     'delFlag': '0',
    # }
    # print(user.addUser(data))

    # 修改用户
    # data = {
    #     'userId': 100,
    #     'userName': 'zhaolipo',
    #     'nickName': '赵利坡222',
    #     'email': '290010220@qq.com',
    #     'phonenumber': '17736758807',
    #     'sex': '2',
    #     'password': 'admin123',
    #     'status': '0',
    #     'delFlag': '0',
    # }
    # print(user.updateUser(data))

    # 删除用户
    # print(user.delUser('100'))

    # 用户密码重置
    # data = {
    #     'userId' : 100,
    #     'password' : 'admin123'
    # }
    # print(user.resetUserPwd(data))

    # 用户状态修改
    # data = {
    #     'userId' : 100,
    #     'status' : 1
    # }
    # print(user.changeUserStatus(data))

    # 查询用户个人信息
    # print(user.getUserProfile())

    # 修改用户个人信息
    # data = {
    #     'email': 'guangdu11@163.com',
    #     'phonenumber': '18610299611'
    # }
    # print(user.updateUserProfile(data))

    # 当前登录的用户密码重置
    # data = {
    #     'oldPassword': 'admin789',
    #     'newPassword': 'admin123'
    # }
    # print(user.updateUserPwd(data))

    # 当前登录的用户查询部门下拉树结构
    # print(user.deptTreeSelect())

    # 退出操作
    print(user.logout())