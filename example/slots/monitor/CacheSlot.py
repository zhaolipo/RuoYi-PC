from PySide6.QtCore import QObject, Signal, Property, Slot
from example.api.monitor.Cache import Cache
from example.define import Singleton

@Singleton
class CacheSlot(QObject):

    def __init__(self):
        super().__init__()

    @Slot(result=dict)
    def getCache(self):
        return Cache().getCache()

    @Slot(result=dict)
    def listCacheName(self):
        return Cache().listCacheName()

    @Slot(result=dict)
    def listCacheKey(self, cacheName: str):
        return Cache().listCacheKey(cacheName)

    @Slot(result=dict)
    def getCacheValue(self, cacheName: str, cacheKey: str):
        return Cache().getCacheValue(cacheName, cacheKey)

    @Slot(result=dict)
    def clearCacheName(self, cacheName: str):
        return Cache().clearCacheName(cacheName)

    @Slot(result=dict)
    def clearCacheKey(self, cacheKey: str):
        return Cache().clearCacheKey(cacheKey)

    @Slot(result=dict)
    def clearCacheAll(self):
        return Cache().clearCacheAll()