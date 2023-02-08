import eventlet
# eventlet.monkey_patch()
import yaml
from flask import Flask
from flask_cors import *
from flask_socketio import SocketIO
from flask_sqlalchemy import SQLAlchemy
import pymysql
import redis
from arcpyhdfs import HDFSFileManager

        
f = open("arcconfig.yml","rb")
arcconfig = yaml.load(f.read(),Loader=yaml.FullLoader)
f.close()

app = Flask(__name__)
app.debug = True
app.config['SECRET_KEY'] = '\x0e\xde\xbfuV\xe0\x1e4U\xc9\xc4k?2\xc1h`\xa4x5\xcaW)\x8b'
pymysql.install_as_MySQLdb()    # MySQLdb 只支持py2 py3要用可以用pymysql
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:root@' + arcconfig['url']['mysql'] + '/arcface'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
db = SQLAlchemy(app)
rds = redis.StrictRedis(host=arcconfig['url']['redis'], port=6379, db=1)
CORS(app, supports_credentials=True)
socketio = SocketIO(async_mode='eventlet')
socketio.init_app(app,cors_allowed_origins="*")

res_dic = {}
hdfs = HDFSFileManager(arcconfig['url']['hdfs']+"50070", "root")


class DataTransfer(object):
    switch = False

    def __init__(self, socketio):
        self.socketio = socketio
        self.switch = True

    def trans(self):
        while self.switch:
            eventlet.sleep(1)
            self.socketio.emit("result", res_dic)

    def start(self):
        self.switch = True

    def stop(self):
        self.switch = False


if __name__ == '__main__':
    socketio.run(app,host="0.0.0.0")

    # app.run(host='0.0.0.0')
    # filename = "scene1/test/001_2_2_1_-1_0_0_0_0_0_0_1.bmp"
    # filename = "scene1/test/001_3_0_1_-1_0_0_0_0_0_0_1.bmp"
    # filename = "scene1/test/012_3_0_1_-1_1_0_0_0_0_0_1.bmp"
    # result = main.delay("FeatureCompare",filename,"scene1")
    # res = result.get()
    # print(res)

"""
    face_engine = ArcFace()
    mask = ASF_FACE_DETECT | ASF_FACERECOGNITION | ASF_AGE | ASF_GENDER |ASF_FACE3DANGLE | ASF_LIVENESS | ASF_IR_LIVENESS
    res = face_engine.ASFInitEngine(ASF_DETECT_MODE_IMAGE,ASF_OP_0_ONLY,30,10,mask)
    fileread = cv2.imread(filename)
    fileread = cv2.resize(fileread,imgscale(fileread.shape))
    tres, tdetectedFace = face_engine.ASFDetectFaces(fileread)
    if tdetectedFace.faceNum != 0:
        processMask = ASF_AGE | ASF_GENDER | ASF_FACE3DANGLE | ASF_LIVENESS
        res = face_engine.ASFProcess(fileread,tdetectedFace,processMask)
        face = ASF_SingleFaceInfo()
        face.faceRect = tdetectedFace.faceRect[0]
        face.faceOrient = tdetectedFace.faceOrient[0]
        res, now_feature = face_engine.ASFFaceFeatureExtract(fileread,face)
    feature = ASF_FaceFeature()
    max_score = 0
    max_file = ""
    with open("scene1/scene1.csv",'r')as f:
        lines = csv.reader(f)
        for line in lines:
            feature.set_feature(bytes.fromhex(line[1]))
            print(type(feature))
            res,score = face_engine.ASFFaceFeatureCompare(now_feature,feature)
            if score > max_score:
                max_score = score
                max_file = line[0]
    face_engine.ASFUninitEngine()
    # return [max_score,max_file]
    print(max_score,max_file)
"""

"""
{
    "SceneTest": {
        "0.0": {
            "FN": 0,
            "FP": 3,
            "TN": 0,
            "TP": 97
        },
        "0.1": {
            "FN": 0,
            "FP": 3,
            "TN": 0,
            "TP": 97
        },
        "0.2": {
            "FN": 0,
            "FP": 3,
            "TN": 0,
            "TP": 97
        },
        "0.3": {
            "FN": 0,
            "FP": 3,
            "TN": 0,
            "TP": 97
        },
        "0.4": {
            "FN": 0,
            "FP": 3,
            "TN": 0,
            "TP": 97
        },
        "0.5": {
            "FN": 0,
            "FP": 3,
            "TN": 0,
            "TP": 97
        },
        "0.6": {
            "FN": 0,
            "FP": 2,
            "TN": 1,
            "TP": 97
        },
        "0.7": {
            "FN": 0,
            "FP": 1,
            "TN": 2,
            "TP": 97
        },
        "0.8": {
            "FN": 0,
            "FP": 1,
            "TN": 2,
            "TP": 97
        },
        "0.9": {
            "FN": 0,
            "FP": 0,
            "TN": 3,
            "TP": 97
        }
    }
}
"""
