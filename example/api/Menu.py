from example.helper.RequestsClient import RequestsClient
from example.AppInfo import AppInfo
from example.api.Login import Login

class Menu():

    def __init__(self):
        self.requestsClient = RequestsClient()
        self.appInfo = AppInfo()


    def getRouters(self):
        url = self.appInfo.baseUrl + "/getRouters"
        result = self.requestsClient.get(url)
        self.appInfo.routers = result['data']
        return result


if __name__ == '__main__':
    # 第一步先登录
    login = Login()
    login.login('admin', 'admin123')
    # 第二步进行测试
    menu = Menu()
    print(menu.getRouters())
