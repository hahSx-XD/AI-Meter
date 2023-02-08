import os
import sys
import time
import pyinotify
import redis
import cv2
from arcface.engine30 import *


watchDir = "/home/ruoke/project/arcsoft"
minDelay = 0.5  # minimum delay before running the command again

mask = pyinotify.IN_DELETE | pyinotify.IN_CREATE | \
     pyinotify.IN_MODIFY # watched events

wm = pyinotify.WatchManager()

face_engine = ArcFace30()
face_mask = ASF_FACE_DETECT | ASF_FACERECOGNITION | ASF_AGE | ASF_GENDER |ASF_FACE3DANGLE | ASF_LIVENESS | ASF_IR_LIVENESS
face_engine.ASFInitEngine(ASF_DETECT_MODE_IMAGE,ASF_OP_0_ONLY,30,10,face_mask)

class PTmp(pyinotify.ProcessEvent):
    def process_default(self, event):
        print(event)
        from arcweb import rds
        if event.maskname == "IN_MODIFY":
            fileread = cv2.imread(event.pathname)
            fileread = cv2.resize(fileread,(fileread.shape[0]//4*4,fileread.shape[1]//4*4))
            _, tdetectedFace = face_engine.ASFDetectFaces(fileread)
            face = ASF_SingleFaceInfo()
            face.faceRect = tdetectedFace.faceRect[0]
            face.faceOrient = tdetectedFace.faceOrient[0]
            _,now_feature = face_engine.ASFFaceFeatureExtract(fileread,face)
            rds.set(event.name,string_at(now_feature.feature, now_feature.featureSize).hex())
            del face
        elif event.maskname == "IN_DELETE":
            rds.delete(event.name)


notifier = pyinotify.Notifier(wm, PTmp())

wdd = wm.add_watch(watchDir, mask, rec=True, auto_add=True)

while True:
    try:
        notifier.process_events()
        if notifier.check_events():
            notifier.read_events()
    except KeyboardInterrupt:
        notifier.stop()
        break
