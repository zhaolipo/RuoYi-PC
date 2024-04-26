import requests
import json
from AppInfo import AppInfo

class Login():

    def __init__(self):
        self.appInfo = AppInfo()
        self.headers = {
            'Content-Type': 'application/json;charset=utf-8'
        }
        self.timeout = 8

    # 登录方法
    def login(self, username, password):

        data = {
            'username': username,
            'password': password
        }
        data = json.dumps(data)

        try:
            result = requests.request("POST", self.appInfo.baseUrl + '/login', data=data, headers=self.headers, timeout=self.timeout).json()
            self.appInfo.token = result['token']
        except Exception as e:
            print("请求失败：{0}".format(e))

        return result



    # 注册方法
    def register(self, username, password):

        data = {
            'username': username,
            'password': password
        }
        data = json.dumps(data)

        try:
            result = requests.request("POST", self.appInfo.baseUrl + '/register', data=data, headers=self.headers,
                                      timeout=self.timeout).json()
        except Exception as e:
            print("请求失败：{0}".format(e))

        return result



    # 获取验证码
    def getCodeImg(self):

        try:
            result = requests.request("GET", self.appInfo.baseUrl + '/captchaImage', headers=self.headers,
                                      timeout=self.timeout).json()
        except Exception as e:
            print("请求失败：{0}".format(e))

        return result





if __name__ == '__main__':
    login = Login()
    # 登录测试
    print(login.login('admin', 'admin789'))
    # 获取验证码
    print(login.getCodeImg())