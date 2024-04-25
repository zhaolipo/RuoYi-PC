from PySide6.QtCore import QObject, Signal, Property, Slot
from example.api.monitor.Job import Job
from example.define import Singleton

@Singleton
class JobSlot(QObject):

    def __init__(self):
        super().__init__()

    @Slot(dict, result=dict)
    def listJob(self, data):
        return Job().listJob(data)

    @Slot(str, result=dict)
    def getJob(self, jobId: str):
        return Job().getJob(jobId)

    @Slot(dict, result=dict)
    def addJob(self, data):
        return Job().addJob(data)

    @Slot(dict, result=dict)
    def updateJob(self, data):
        return Job().updateJob(data)

    @Slot(str, result=dict)
    def delJob(self, jobId: str):
        return Job().delJob(jobId)

    @Slot(dict, result=dict)
    def changeJobStatus(self, data):
        return Job().changeJobStatus(data)

    @Slot(dict, result=dict)
    def runJob(self, data):
        return Job().runJob(data)