import requests
from requests.adapters import HTTPAdapter
from define import Singleton
from AppInfo import AppInfo
import json

"""
    self,
    method,                    请求方式 get post put delete
    url,                       请求URL地址，接口文档标准的接口请求地址
    params=None,               params参数:请求数据中的链接，常见的一个get请求，请求参数都是放在url地址
    data=None,                 data参数:请求数据，参数为表单的数据格式
    json=None,                 json参数:接口常见的数据请求格式
    headers=None,              请求头:请求头信息 ，http请求中，编码方式等内容的添加
    cookies=None,              cookie信息:保存用户的登录信息。比如做一些充值功能，但是需要用户已经登录
    files=None,                文件上传
   -----------------------------------------------以上为常用参数-------------------
    auth=None,                 鉴权的意思，接口设置操作权限
    timeout=None,              超时处理
    allow_redirects=True,      重定向，请求不成功，再次请求（该功能并不是很常用）
    proxies=None,              设置代理
    hooks=None,                钩子
    stream=None,               文件下载功能，通过请求方式，下载文件，进行验证
    verify=None,               证书验证 1.要么请求忽略证书 2.要么加载证书地址
    cert=None,                 CA证书
"""


@Singleton
class RequestsClient():

    def __init__(self):
        """
        :param timeout: 每个请求的超时时间
        """
        self.appInfo = AppInfo()
        self.timeout = 8
        s = requests.Session()
        ##: 在session实例上挂载Adapter实例, 目的: 请求异常时,自动重试
        s.mount('http://', HTTPAdapter(max_retries=3))
        s.mount('https://', HTTPAdapter(max_retries=3))

        ##: 设置为False, 主要是HTTPS时会报错, 为了安全也可以设置为True
        s.verify = False

        ##: 公共的请求头设置
        s.headers = {
            'Content-Type': 'application/json;charset=utf-8',
            'Authorization': 'Bearer ' + self.appInfo.token
        }

        ##: 挂载到self上面
        self.s = s


    def get(self, url, params=None, json=None):
        try:
            result = self.s.get(url, params=params, json=json).json()
        except Exception as e:
            print("请求失败：{0}".format(e))
        return result


    def post(self, url, params=None, json=None):
        try:
            result = self.s.post(url, params=params, json=json).json()
        except Exception as e:
            print("请求失败：{0}".format(e))
        return result


    def put(self, url, params=None, json=None):
        try:
            result = self.s.put(url, params=params, json=json).json()
        except Exception as e:
            print("请求失败：{0}".format(e))
        return result


    def delete(self, url, params=None, json=None):
        try:
            result = self.s.delete(url, params=params, json=json).json()
        except Exception as e:
            print("请求失败：{0}".format(e))
        return result


    def __del__(self):
        """当实例被销毁时,释放掉session所持有的连接
        :return:
        """
        if self.s:
            self.s.close()


    # 测试是否单例模式
    def requestsClient_id(self):
        return id(self)

if __name__ == '__main__':
    p1 = RequestsClient()
    p2 = RequestsClient()
    print(p1.requestsClient_id())
    print(p2.requestsClient_id())