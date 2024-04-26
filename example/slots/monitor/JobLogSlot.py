from PySide6.QtCore import QObject, Signal, Property, Slot
from api.monitor.JobLog import JobLog
from define import Singleton

@Singleton
class JobLogSlot(QObject):

    def __init__(self):
        super().__init__()

    @Slot(dict, result=dict)
    def listJobLog(self, data):
        return JobLog().listJobLog(data)

    @Slot(str, result=dict)
    def delJobLog(self, jobLogId: str):
        return JobLog().delJobLog(jobLogId)

    @Slot(result=dict)
    def cleanJobLog(self):
        return JobLog().cleanJobLog()