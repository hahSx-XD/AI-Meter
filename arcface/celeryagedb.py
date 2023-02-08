import os,time,csv
import cv2
from celery import Celery
from arcface.engine30 import *
from arcface.engine22 import *
from arcface.engine21 import *
from arcface.engine20 import *
from arcweb import rds,arcconfig
from arclog import *

face_engine30 = ArcFace30()
face_engine22 = ArcFace22()
face_engine21 = ArcFace21()
face_engine20 = ArcFace20()
mask = ASF_FACE_DETECT | ASF_FACERECOGNITION | ASF_AGE | ASF_GENDER |ASF_FACE3DANGLE | ASF_LIVENESS | ASF_IR_LIVENESS
face_engine30.ASFInitEngine(ASF_DETECT_MODE_IMAGE,ASF_OP_0_ONLY,30,10,mask)
face_engine22.ASFInitEngine(ASF_DETECT_MODE_IMAGE,ASF_OP_0_ONLY,30,10,mask)
face_engine21.ASFInitEngine(ASF_DETECT_MODE_IMAGE,ASF_OP_0_ONLY,30,10,mask)
face_engine20.ASFInitEngine(ASF_DETECT_MODE_IMAGE,ASF_OP_0_ONLY,30,10,mask)

genderdic = {'m':0,'f':1}
def get_engine(sdkVersion):
    # face_engine = ArcFace30()
    if sdkVersion == "30":
        face_engine = ArcFace30()
    elif sdkVersion == "22":
        face_engine = ArcFace22()
    elif sdkVersion == "21":
        face_engine = ArcFace21()
    elif sdkVersion == "20":
        face_engine = ArcFace20()
    else:
        face_engine = ArcFace30()
    mask = ASF_FACE_DETECT | ASF_FACERECOGNITION | ASF_AGE | ASF_GENDER |ASF_FACE3DANGLE | ASF_LIVENESS | ASF_IR_LIVENESS
    res = face_engine.ASFInitEngine(ASF_DETECT_MODE_IMAGE,ASF_OP_0_ONLY,30,10,mask)
    return face_engine if res == MOK else None

def imgscale(shape):
    return (shape[0]//4*4,shape[1]//4*4)

# filename = "./AgeDB/5170_BobHope_68_m.jpg" # 检测不到人
# filename = "./AgeDB/5169_BobHope_83_m.jpg" # 检测不到人
# filename = "./AgeDB/5168_BobHope_74_m.jpg"
# ./AgeDB/9665_BoDerek_53_f.jpg 可用
# getAgeAndGender(filename)
# t = threading.Thread(target=getAgeAndGender, args=(filename,))
# t.start()

app = Celery('age', backend='redis://'+arcconfig['url']['redis'], broker='pyamqp://'+arcconfig['url']['rabbitmq'])
# app = Celery('age',broker='pyamqp://'+arcconfig['url']['rabbitmq'])
@app.task
def main(sdkVersion,type,testid,filename,*args):
    face_engine = face_engine30
    # face_engine = get_engine(sdkVersion)
    # while(face_engine == None):
    #     time.sleep(1)
    #     face_engine = get_engine()

    feature = rds.get(filename.split('/')[-1])
    if feature == None:
        # face_engine = get_engine(sdkVersion)
        fileread = cv2.imread(filename)
        fileread = cv2.resize(fileread,imgscale(fileread.shape))
        tres, tdetectedFace = face_engine.ASFDetectFaces(fileread)
        if tres == MOK:
            if tdetectedFace.faceNum != 0:
                processMask = ASF_AGE | ASF_GENDER | ASF_FACE3DANGLE | ASF_LIVENESS
                _ = face_engine.ASFProcess(fileread,tdetectedFace,processMask)
                face = ASF_SingleFaceInfo()
                face.faceRect = tdetectedFace.faceRect[0]
                face.faceOrient = tdetectedFace.faceOrient[0]
                _,now_feature = face_engine.ASFFaceFeatureExtract(fileread,face)
                rds.set(filename.split('/')[-1],string_at(now_feature.feature, now_feature.featureSize).hex())
            else:
                logger.info('测试名:' + testid + ' 没有检测到人脸 ' + filename)
        else:
            logger.info('测试名:' + testid + ' 错误退出 ' + filename)
            face_engine.ASFUninitEngine()
            return None
    else:
        now_feature = ASF_FaceFeature()
        now_feature.set_feature(bytes.fromhex(feature.decode()))

    try:
        if type == "GetAge":
            return GetAgeProcess(face_engine,testid,filename,age_fault_tolerant=args[0])
        elif type == "GetGender":
            return GetGenderProcess(face_engine,testid,filename)
        elif type == "GetLivenessScore":
            return GetLivenessScore(face_engine,testid,filename)
        elif type == "FeaturCompare1":
            return FeatureCompare1(face_engine,testid,filename,now_feature,scenename=args[0],similarity_threshold=args[1])
        elif type == "FeatureCompareN":
            return FeatureCompareN(face_engine,testid,filename,now_feature,scenename=args[0])
    except:
        logger.info('测试名:' + testid + ' 处理出错 ' + filename)

# ./AgeDB/9665_BoDerek_53_f.jpg
def GetAgeProcess(face_engine,testid,filename,age_fault_tolerant):
    age = face_engine.ASFGetAge()[1].ageArray[0]
    face_engine.ASFUninitEngine()
    real_age = int(filename.split("/")[-1].split(".")[0].split("_")[2])
    if abs(real_age-age) <= age_fault_tolerant:
        return 1
    else:
        agelogger.info(filename)
        return 0

# 男0 女1
def GetGenderProcess(face_engine,testid,filename):
    gender = face_engine.ASFGetGender()[1].genderArray[0]
    face_engine.ASFUninitEngine() # 好像有最高的限制 不注销会报错 Segmentation fault (core dumped)
    real_gender = filename.split("/")[-1].split(".")[0].split("_")[3]
    if genderdic[real_gender] == gender:
        return 1
    else:
        genderlogger.info(filename)
        return 0

#0:非真人；1:真人；-1：不确定；-2:传入人脸数>1
def GetLivenessScore(face_engine,testid,filename):
    isLive = face_engine.ASFGetLivenessScore()[1].isLive[0]
    face_engine.ASFUninitEngine()
    if isLive == 1:
        return 1
    else:
        livenesslogger.info(filename)
        return 0

def FeatureCompare1(face_engine,testid,filename,now_feature,scenename,similarity_threshold):
    feature = ASF_FaceFeature()
    # max_score = 0
    # max_file = ""
    fileID = filename.split('/')[-1].split('_')[0]
    with open(scenename+"/"+scenename+".csv",'r')as f:
        lines = csv.reader(f)
        for line in lines:
            if line[0].startswith(fileID):  # 找到这个人的特征  1:1
                feature.set_feature(bytes.fromhex(line[1]))
                res,score = face_engine.ASFFaceFeatureCompare(now_feature,feature)
                face_engine.ASFUninitEngine()
                if score > similarity_threshold:    # 与目标相似度高
                    return 1
                else:
                    scene1logger.info(filename)
                    return 0
    # return [filename.split('/')[-1].split('_')[0],max_file.split('_')[0]]
    # return [max_score,max_file]
    # return max_score

def FeatureCompareN(face_engine,testid,filename,now_feature,scenename):
    feature = ASF_FaceFeature()
    # max_score = 0
    # max_file = ""

    # 字典初始化
    toreturn = {}
    for similarityThreshold in range(0,21):
        similarityThreshold = similarityThreshold / 20
        toreturn[similarityThreshold] = ""

    score_max = 0
    score_max_label = ""
    with open(scenename+"/"+scenename+".csv",'r')as f:
        lines = csv.reader(f)
        for line in lines:  # 1:N   一个一个测过去
            feature.set_feature(bytes.fromhex(line[1]))
            res,score = face_engine.ASFFaceFeatureCompare(now_feature,feature)
            if score > score_max:
                score_max = score
                score_max_label = line[0]

    flag1 = 0
    flag2 = 0
    for similarityThreshold in range(0,21):
        similarityThreshold = similarityThreshold / 20
        registed = (filename.split("/")[-1].split("_")[1] != "0")
        if score_max < similarityThreshold:
            if score_max_label.split("_")[0] == filename.split("/")[-1].split("_")[0]:
                toreturn[similarityThreshold] = "FN"
                if not flag1 and score_max > 0.5 and score_max < 0.85:
                    scenenlogger.info(testid + " " + filename + " " + str(" FN ") + str(score_max) + " " + score_max_label)
                    flag1 = 1
            else:
                toreturn[similarityThreshold] = "TN"
        else:
            if score_max_label.split("_")[0] == filename.split("/")[-1].split("_")[0]:  # 相似度最高是本人
                toreturn[similarityThreshold] = "TP"
            else:
                toreturn[similarityThreshold] = "FP"
                if not flag2 and score_max > 0.5:
                    scenenlogger.info(testid + " " + filename + " " + str(" FP ") + str(score_max) + " " + score_max_label)
                    flag2 = 1

    del now_feature
    del feature
    # face_engine.ASFUninitEngine()
    return toreturn
