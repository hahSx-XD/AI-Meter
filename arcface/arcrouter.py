from operator import pos
import time,json,csv
from queue import Queue
from flask import request,send_from_directory
from celeryagedb import main
from arcface.engine30 import *
from arcweb import *
from arcsql import SceneProjectList, SceneTestList



@app.route('/', methods=['GET'])
def root():
    return "GET"

@app.route('/long', methods=['GET'])
def long():
    time.sleep(10)
    return "long"

@app.route('/short', methods=['GET'])
def short():
    return "GET"



@socketio.on('connect')
def connect():
    global dataTransfer
    dataTransfer = DataTransfer(socketio)

@socketio.on('disconnect')
def disconnect():
    dataTransfer.stop()

@socketio.on('transmitdata')
def transmitdata(data):
    socketio.start_background_task(target=dataTransfer.trans)


@socketio.on('GetAge')
def get_age(postdata):
    """
    param:
        testName
        dbName    path of the database
        thresholdmodelBGR  default 0.5
        thresholdmodelIR   default 0.7
        ageFaultTolerant  default 5
    return:
        {
            correctRate:
            time:
        }
    """
    threshold = ASF_LivenessThreshold()
    threshold.thresholdmodel_BGR = postdata['thresholdmodelBGR']
    threshold.thresholdmodel_IR = postdata['thresholdmodelIR']

    testname = postdata['testName']
    # runningList.append(testname)
    count = 0
    correct = 0
    error = 0
    time1 = time.time()
    for root,dirs,files in os.walk(postdata['dbName']):
        for file in files:
            # # runningList destroyList 和 stopList 暂时弃用
            # if testname in destroyList:
            #     destroyList.remove(testname)
            #     return None
            # while testname not in runningList:
            #     time.sleep(10)
            filename = os.path.join(root,file)
            result = main.delay("GetAge",testname,filename,postdata['ageFaultTolerant'])
            res = result.get()
            count += 1
            if res:
                correct += 1
            else:
                error += 1
            res_dic[testname] = '{"count":%d,"correct":%d,"error":%d}'%(count,correct,error)
    time2 = time.time()
    correct_rate = correct/(correct+error)
    return '{"correctRate":%f,"time":%f}'%(correct_rate,time2-time1)

@socketio.on('GetGender')
def get_gender(postdata):
    """
    param:
        testName
        dbName    path of the database
        thresholdmodelBGR  default 0.5
        thresholdmodelIR   defaulrt 0.7
    return:
        {
            correctRate:
            time:
        }
    """
    threshold = ASF_LivenessThreshold()
    threshold.thresholdmodel_BGR = postdata['thresholdmodelBGR']
    threshold.thresholdmodel_IR = postdata['thresholdmodelIR']

    testname = postdata['testName']
    # runningList.append(testname)
    count = 0
    correct = 0
    error = 0
    time1 = time.time()
    for root,dirs,files in os.walk(postdata['dbName']):
        for file in files:
            # # runningList destroyList 和 stopList 暂时弃用
            # if testname in destroyList:
            #     destroyList.remove(testname)
            #     return None
            # while testname not in runningList:
            #     time.sleep(10)
            filename = os.path.join(root,file)
            result = main.delay("GetGender",testname,filename)
            res = result.get()
            count += 1
            if res:
                correct += 1
            else:
                error += 1
            res_dic[testname] = '{"count":%d,"correct":%d,"error":%d}'%(count,correct,error)
    time2 = time.time()
    correct_rate = correct/(correct+error)
    return '{"correctRate":%f,"time":%f}'%(correct_rate,time2-time1)

@socketio.on('GetLivenessScore')
def get_liveness_score(postdata):
    """
    param:
        testName
        dbName    path of the database
        thresholdmodelBGR  default 0.5
        thresholdmodelIR   defaulrt 0.7
    return:
        {
            correctRate:
            time:
        }
    """
    threshold = ASF_LivenessThreshold()
    threshold.thresholdmodel_BGR = postdata['thresholdmodelBGR']
    threshold.thresholdmodel_IR = postdata['thresholdmodelIR']

    testname = postdata['testName']
    # runningList.append(testname)
    count = 0
    correct = 0
    error = 0
    time1 = time.time()
    for root,dirs,files in os.walk(postdata['dbName']):
        for file in files:
            # # runningList destroyList 和 stopList 暂时弃用
            # if testname in destroyList:
            #     destroyList.remove(testname)
            #     return None
            # while testname not in runningList:
            #     time.sleep(10)
            filename = os.path.join(root,file)
            result = main.delay("GetLivenessScore",testname,filename)
            res = result.get()
            count += 1
            if res:
                correct += 1
            else:
                error += 1
            res_dic[testname] = '{"count":%d,"correct":%d,"error":%d}'%(count,correct,error)
    time2 = time.time()
    correct_rate = correct/(correct+error)
    return '{"correctRate":%f,"time":%f}'%(correct_rate,time2-time1)

# @app.route('/GetTestData', methods=['POST'])
@socketio.on('GetTestData')
def get_test_data(postdata):
    """
    param:
        testName
            1.all返回全部数据
            2.指定名称返回指定数据
    """
    # postdata = json.loads(request.get_data(as_text=True))
    if postdata == "all":
        return res_dic
    else:
        if postdata in res_dic.keys():
            return res_dic[postdata]
        else:
            return postdata + " has not been created!"
    # return res_dic

# @app.route('/SceneTest1', methods=['POST'])
@socketio.on('SceneTest1')
def scene_test1(postdata):
    """
    param:
        testName            测试名
        sceneName           场景名
        thresholdmodelBGR  defalut 0.5
        thresholdmodelIR   defalut 0.7
        similarityThreshold    defalut 0.95
    return:
        {
            correctRate:
            time:
        }
    """
    # postdata = json.loads(request.get_data(as_text=True))
    threshold = ASF_LivenessThreshold()
    threshold.thresholdmodel_BGR = postdata['thresholdmodelBGR']
    threshold.thresholdmodel_IR = postdata['thresholdmodelIR']
    testname = postdata['testName']
    scenename = postdata['sceneName']
    # runningList.append(testname)
    count = 0
    correct = 0
    error = 0
    time1 = time.time()
    for root,dirs,files in os.walk(scenename+"/test"):
        for file in files:
            # # runningList destroyList 和 stopList 暂时弃用
            # if testname in destroyList:
            #     destroyList.remove(testname)
            #     return None
            # while testname not in runningList:
            #     time.sleep(10)
            if file.split('_')[1] != '0':
                filename = os.path.join(root,file)
                result = main.delay("FeatureCompare1",testname,filename,scenename,postdata['similarityThreshold'])
                res = result.get()
                count += 1
                if res:
                    correct += 1
                else:
                    error += 1
                res_dic[testname] = '{"count":%d,"correct":%d,"error":%d}'%(count,correct,error)
    time2 = time.time()
    correct_rate = correct/(correct+error)
    return '{"correctRate":%f,"time":%f}'%(correct_rate,time2-time1)

################## SceneTest ##################

################## SceneTest ##################

################## SceneTest ##################

# 创建测试 (未开始运行)
@socketio.on('CreateSceneTest')
def scene_testn(postdata):
    try:
        scenesql = SceneTestList(postdata)
        db.session.add(scenesql)
        db.session.commit()
        return "create scene test success"
    except:
        return "create scene test fail"

# 前端进入报告界面 根据用户传入的id给具体的测试
@socketio.on('GetSceneTest')
def GetSceneTest(postdata):
    t = db.session.query(SceneTestList).filter_by(id = postdata).first().__dict__
    del t['_sa_instance_state']
    return t

# 创建场景测试项目
@socketio.on('CreateSceneProject')
def CreateSceneProject(postdata):
    try:
        scenesql = SceneProjectList(postdata)
        db.session.add(scenesql)
        db.session.commit()
        return "create scene test success"
    except:
        return "create scene test fail"

# 获取场景测试的项目列表
@socketio.on('GetSceneProjectList')
def GetSceneProjectList(postdata):
    ret = []
    for i in SceneProjectList.query.all():
        tdic = i.__dict__
        del tdic['_sa_instance_state']
        ret.append(tdic)
    ret.reverse()
    return ret

# 获取场景测试的项目详细信息
@socketio.on('GetSceneProject')
def GetSceneProject(postdata):
    t = db.session.query(SceneProjectList).filter_by(projectId = postdata).first().__dict__
    del t['_sa_instance_state']
    return t

# 获取某项目场景测试列表
@socketio.on('GetSceneTestListByPid')
def GetSceneTestList(postdata):
    ret = []
    t = db.session.query(SceneTestList,SceneProjectList.projectName).filter_by(projectId = postdata).join(SceneProjectList,SceneTestList.projectId==SceneProjectList.projectId).all()
    for i,projectname in t:
        tdic = i.__dict__
        tdic['projectName'] = projectname
        del tdic['_sa_instance_state']
        ret.append(tdic)
    ret.reverse()
    return ret

# 获取某项目场景测试列表
@socketio.on('GetSceneTestList')
def GetSceneTestList(postdata):
    ret = []
    t = db.session.query(SceneTestList,SceneProjectList.projectName).join(SceneProjectList,SceneTestList.projectId==SceneProjectList.projectId).all()
    for i,projectname in t:
        tdic = i.__dict__
        tdic['projectName'] = projectname
        del tdic['_sa_instance_state']
        ret.append(tdic)
    ret.reverse()
    return ret

# 删除测试 deleted 设置为1 标记为删除 前端将其显示在回收站中
@socketio.on('DeleteSceneTest')
def DeleteSceneTest(postdata):
    try:
        db.session.query(SceneTestList).filter_by(id = postdata).update({"deleted": 1})
        db.session.commit()
        return "success"
    except:
        return "error"

# 恢复测试 deleted 设置为0 标记为未删除 前端将其显示在结果列表
@socketio.on('RecSceneTest')
def RecSceneTest(postdata):
    try:
        db.session.query(SceneTestList).filter_by(id = postdata).update({"deleted": 0})
        db.session.commit()
        return "success"
    except:
        return "error"

# 停止测试 只对测试状态Running有效 改为 Stopped
@socketio.on('StopSceneTest')
def StopSceneTest(postdata):
    try:
        db.session.query(SceneTestList).filter_by(id = postdata).update({"testState": "Stopped"})
        db.session.commit()
        return "success"
    except:
        return "error"

# 重启测试 只对测试状态Stopped有效 改为 Running
@socketio.on('RestartSceneTest')
def RestartSceneTest(postdata):
    try:
        db.session.query(SceneTestList).filter_by(id = postdata).update({"testState": "Running"})
        db.session.commit()
        return "success"
    except:
        return "error"

# 开始测试
@socketio.on('StartSceneTest')
def StartSceneTest(postdata):
    socketio.start_background_task(target=startscene,postdata=postdata)

def startscene(postdata):
    # 开始测试 更新数据库中测试的状态
    testid = postdata['id']
    db.session.query(SceneTestList).filter_by(id = testid).update({"startTime":time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()),"testState": "Running"})
    db.session.commit()

    # threshold = ASF_LivenessThreshold()
    # threshold.thresholdmodel_BGR = postdata['thresholdmodelBGR']
    # threshold.thresholdmodel_IR = postdata['thresholdmodelIR']
    sdkVersion = postdata['sdkVersion']
    testname = postdata['testName']
    scenename = postdata['sceneName']
    # runningList.append(testname)
    # 初始化字典
    testdic = {}
    testdatadic = {}
    testinfodic = {"num":0,"now":0}
    tdic = {"TP":0,"TN":0,"FP":0,"FN":0}
    # tdic['TP'] = tdic['TN'] = tdic['FP'] = tdic['FN'] = 0
    for similarityThreshold in range(0,21):
        similarityThreshold = similarityThreshold / 20
        testdatadic[str(similarityThreshold)] = tdic.copy()
    testdic['data'] = testdatadic
    testdic['info'] = testinfodic
    testinfodic['id'] = testid
    res_dic[testid] = testdic

    # publish tasks
    q = Queue() # result object queue
    # q2 = Queue()
    testinfodic['num'] = 1*100
    for i in range(1):
        socketio.sleep(2)
        for root,_,files in os.walk(scenename+"/test"):
            # testinfodic['num'] = len(files)
            for file in files:
                # # runningList destroyList 和 stopList 暂时弃用
                # if testname in destroyList:
                #     destroyList.remove(testname)
                #     return None
                # while testname not in runningList:
                #     time.sleep(10)

                # # 被暂停就阻塞    (为不阻塞 弃用暂停)
                # while db.session.query(SceneTestList).filter_by(id = testid).first().testState == "Stopped":
                #     # eventlet.sleep(10) 防止阻塞
                #     socketio.sleep(10)
                #     if db.session.query(SceneTestList).filter_by(id = testid).first().testState == "Deleted":
                #         return
                filename = os.path.join(root,file)
                # print(filename,scenename)   # scene1/test/045_2_0_1_-1_0_0_0_0_0_0_0.bmp scene1
                q.put(main.delay(sdkVersion,"FeatureCompareN",testid,filename,scenename))
                # q2.put(file)

    # # csv
    # f = open("resultcsv/" + testid,'w')
    # fwriter = csv.writer(f)
    # result summary
    while not q.empty():
        try:
            tas = q.get()
            res = tas.get()
        except:
            q.put(tas)
            continue
        # file = q2.get()
        testinfodic['now'] += 1
        if res != None:
            for key in res.keys():
                # TP11 TN00 FP01 FN10
                if res[key] == "TP":
                    testdic['data'][key]["TP"] += 1
                elif res[key] == "TN":
                    testdic['data'][key]["TN"] += 1
                elif res[key] == "FN":
                    testdic['data'][key]["FN"] += 1
                elif res[key] == "FP":
                    testdic['data'][key]["FP"] += 1



        # if res != None:
        #     for key in res.keys():
        #         if file.split('_')[1] != '0' and res[key] == 1:
        #             testdic['data'][key]['TP'] += 1
        #             res[key] = "1" # TP
        #         elif file.split('_')[1] != '0' and res[key] == 0:
        #             testdic['data'][key]["FN"] += 1
        #             res[key] = "4" # FN
        #         elif file.split('_')[1] == '0' and res[key] == 1:
        #             testdic['data'][key]["FP"] += 1
        #             res[key] = "3" # FP
        #         elif file.split('_')[1] == '0' and res[key] == 0:
        #             testdic['data'][key]["TN"] += 1
        #             res[key] = "2" # TN
        # # 每一个测试数据更新传到前端
        # # socketio.start_background_task(target=transmitdata1_thread,testid=testid)
        # # 每一个测试数据写入csv
        # fwriter.writerow([filename.split('/')[-1].split('.')[0],res])

    # # 关闭csv文件对象
    # f.close()
    # # 上传csv文件到hdfs
    # try:
    #     hdfs.file_upload("resultcsv/" + testid,"/arcData/" + testid)
    # except:
    #     pass
    # 测试结束 更新数据库中测试的状态为Completed  \ completetTime 改为当前时间
    db.session.query(SceneTestList).filter_by(id = testid).update({"completeTime":time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()),"testState": "Completed"})
    db.session.commit()


################## Log ##################

################## Log ##################

################## Log ##################

@app.route('/log', methods=['GET'])
def log():
    logType = request.args.get("type")
    logFile = "logs/%s"%(logType)
    if os.path.exists(logFile):
        with open(logFile,"r")as f:
            return f.read()
    else:
        return ""

@app.route('/pack', methods=['POST'])
def pack_wrong():
    """
    param:
        type    gender/age/liveness/scene1
    return:
        a zip file
    """
    postdata = json.loads(request.get_data(as_text=True))
    t = postdata['type']
    os.system('mkdir -p /tmp/' + t)
    os.system('cat logs/%s | xargs -i cp {} /tmp/%s'%(t,t))
    os.system('tar -cxvf /tmp/out.tar.gz /tmp/%s'%(t))
    # os.popen('tar -cxvf out.tar.gz /tmp/%s'%(t))
    # time.sleep(10)
    # send_from_directory("/tmp", "out.tar.gz", as_attachment=True)

@app.route('/download', methods=['GET'])
def down():
    return send_from_directory("/tmp", "qaiyXHHjcybGzCpPa1iB.tar.xz", as_attachment=True)
