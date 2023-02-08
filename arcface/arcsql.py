from arcweb import db


# 场景测试列表
class SceneTestList(db.Model):
    id = db.Column(db.String(25), primary_key=True)
    projectId = db.Column(db.String(25))
    sdkVersion = db.Column(db.String(25))
    testName = db.Column(db.String(25))
    sceneName = db.Column(db.String(25))
    allowThreshold = db.Column(db.Integer)
    thresholdmodelBGR = db.Column(db.Float)
    thresholdmodelIR = db.Column(db.Float)
    similarityThresholdLow = db.Column(db.Float)
    similarityThresholdHigh = db.Column(db.Float)
    testModel = db.Column(db.Integer)
    allowCover = db.Column(db.Integer)
    allowFace = db.Column(db.Integer)
    allowGender = db.Column(db.Integer)
    allowNum = db.Column(db.Integer)
    allowBack = db.Column(db.Integer)
    allowLightType = db.Column(db.Integer)
    allowLightIntensity = db.Column(db.Integer)
    allowConcurrent = db.Column(db.Integer)
    allowDistanceLow = db.Column(db.Integer)
    allowDistanceHigh = db.Column(db.Integer)
    hopeFAR = db.Column(db.Float)
    hopeFRR = db.Column(db.Float)
    createTime = db.Column(db.String(25))
    startTime = db.Column(db.String(25))
    completeTime = db.Column(db.String(25))
    testState = db.Column(db.String(25))
    deleted = db.Column(db.Integer)

    def __init__(self,dic):
        for k in dic.keys():
            setattr(self,k,dic[k])

    def __repr__(self):
        return '<test %r>' % self.id


# 场景项目列表
class SceneProjectList(db.Model):
    projectId = db.Column(db.String(25), primary_key=True)
    userId = db.Column(db.String(25))
    projectName = db.Column(db.String(25))
    createTime = db.Column(db.String(25))
    introduction = db.Column(db.String(255))
    deleted = db.Column(db.Integer)

    def __init__(self,dic):
        for k in dic.keys():
            setattr(self,k,dic[k])

    def __repr__(self):
        return '<test %r>' % self.id


def create():
    testList = [
    {
        "id": "WDnkSJ5wJuUFVUL-Dy0C",
        "projectId": "R-2HTPWZyZEosmiPQa6Gh",
        "sdkVersion": "30",
        "testName": "SceneTest1",
        "sceneName": "scene1",
        "allowThreshold": 0,
        "thresholdmodelBGR": 0.5,
        "thresholdmodelIR": 0.7,
        "similarityThresholdLow": 0.95,
        "similarityThresholdHigh": 0.95,
        "testModel": 1,
        "allowCover": 0,
        "allowFace": 0,
        "allowGender": 0,
        "allowNum": 0,
        "allowBack": 0,
        "allowLightType": 0,
        "allowLightIntensity": 0,
        "allowConcurrent": 0,
        "allowDistanceLow": 10,
        "allowDistanceHigh": 30,
        "hopeFAR": 0,
        "hopeFRR": 0,
        "createTime": "2021-09-20 13:56:40",
        "startTime": "",
        "completeTime": "",
        "testState": "Saved",
        "deleted":"0"
    },
    {
        "id": "ITlY6_gVBXz9r4oS2d_w",
        "projectId": "R-2HTPWZyZEosmiPQa6Gh",
        "sdkVersion": "30",
        "testName": "school",
        "sceneName": "scene1",
        "allowThreshold": 1,
        "thresholdmodelBGR": 0.5,
        "thresholdmodelIR": 0.7,
        "similarityThresholdLow": 0.95,
        "similarityThresholdHigh": 0.95,
        "testModel": 1,
        "allowCover": 0,
        "allowFace": 0,
        "allowGender": 0,
        "allowNum": 0,
        "allowBack": 0,
        "allowLightType": 0,
        "allowLightIntensity": 0,
        "allowConcurrent": 0,
        "allowDistanceLow": 10,
        "allowDistanceHigh": 30,
        "hopeFAR": 0.2,
        "hopeFRR": 0.1,
        "createTime": "2021-09-20 14:03:00",
        "completeTime": "",
        "testState": "Completed",
        "deleted":"0"
    },
    {
        "id": "F53pzPTlBLBXGlrYvIKC",
        "projectId": "R-2HTPWZyZEosmiPQa6Gh",
        "sdkVersion": "30",
        "testName": "lalala",
        "sceneName": "scene1",
        "allowThreshold": 0,
        "thresholdmodelBGR": 0.5,
        "thresholdmodelIR": 0.7,
        "similarityThresholdLow": 0.95,
        "similarityThresholdHigh": 0.95,
        "testModel": 1,
        "allowCover": 0,
        "allowFace": 0,
        "allowGender": 0,
        "allowNum": 0,
        "allowBack": 0,
        "allowLightType": 0,
        "allowLightIntensity": 0,
        "allowConcurrent": 0,
        "allowDistanceLow": 10,
        "allowDistanceHigh": 30,
        "hopeFAR": 0,
        "hopeFRR": 0,
        "createTime": "2021-09-20 14:06:02",
        "completeTime": "",
        "testState": "Running",
        "deleted":"0"
    },
    {
        "id": "g21YqVgX3KBKR511GAqt",
        "projectId": "R-2HTPWZyZEosmiPQa6Gh",
        "sdkVersion": "30",
        "testName": "testtest",
        "sceneName": "scene1",
        "allowThreshold": 0,
        "thresholdmodelBGR": 0.5,
        "thresholdmodelIR": 0.7,
        "similarityThresholdLow": 0.95,
        "similarityThresholdHigh": 0.95,
        "testModel": 1,
        "allowCover": 0,
        "allowFace": 0,
        "allowGender": 0,
        "allowNum": 0,
        "allowBack": 0,
        "allowLightType": 0,
        "allowLightIntensity": 0,
        "allowConcurrent": 0,
        "allowDistanceLow": 10,
        "allowDistanceHigh": 30,
        "hopeFAR": 0,
        "hopeFRR": 0,
        "createTime": "2021-09-20 14:07:01",
        "completeTime": "",
        "testState": "Running",
        "deleted":"0"
    },
    {
        "id": "QM--7srHYc32ZFcFSwsV",
        "projectId": "R-2HTPWZyZEosmiPQa6Gh",
        "sdkVersion": "30",
        "testName": "school123",
        "sceneName": "scene1",
        "allowThreshold": 0,
        "thresholdmodelBGR": 0.5,
        "thresholdmodelIR": 0.7,
        "similarityThresholdLow": 0.95,
        "similarityThresholdHigh": 0.95,
        "testModel": 1,
        "allowCover": 0,
        "allowFace": 0,
        "allowGender": 0,
        "allowNum": 0,
        "allowBack": 0,
        "allowLightType": 0,
        "allowLightIntensity": 0,
        "allowConcurrent": 0,
        "allowDistanceLow": 10,
        "allowDistanceHigh": 30,
        "hopeFAR": 0,
        "hopeFRR": 0,
        "createTime": "2021-09-20 14:09:45",
        "completeTime": "",
        "testState": "Error",
        "deleted":"0"
    },
    {
        "id": "eSZxt4M3RXQqWLkAqmCN",
        "projectId": "R-2HTPWZyZEosmiPQa6Gh",
        "sdkVersion": "30",
        "testName": "scene1",
        "sceneName": "scene1",
        "allowThreshold": 0,
        "thresholdmodelBGR": 0.5,
        "thresholdmodelIR": 0.7,
        "similarityThresholdLow": 0.95,
        "similarityThresholdHigh": 0.95,
        "testModel": 1,
        "allowCover": 0,
        "allowFace": 0,
        "allowGender": 0,
        "allowNum": 0,
        "allowBack": 0,
        "allowLightType": 0,
        "allowLightIntensity": 0,
        "allowConcurrent": 0,
        "allowDistanceLow": 10,
        "allowDistanceHigh": 30,
        "hopeFAR": 0,
        "hopeFRR": 0,
        "createTime": "2021-09-20 14:10:07",
        "completeTime": "2021-09-20 15:10:07",
        "testState": "Completed",
        "deleted":"0"
    },
    {
        "id": "FVhEHXuBMeY844UwDpvV",
        "projectId": "R-2HTPWZyZEosmiPQa6Gh",
        "sdkVersion": "30",
        "testName": "sceneLaLaLa",
        "sceneName": "scene1",
        "allowThreshold": 0,
        "thresholdmodelBGR": 0.5,
        "thresholdmodelIR": 0.7,
        "similarityThresholdLow": 0.95,
        "similarityThresholdHigh": 0.95,
        "testModel": 1,
        "allowCover": 0,
        "allowFace": 0,
        "allowGender": 0,
        "allowNum": 0,
        "allowBack": 0,
        "allowLightType": 0,
        "allowLightIntensity": 0,
        "allowConcurrent": 0,
        "allowDistanceLow": 10,
        "allowDistanceHigh": 30,
        "hopeFAR": 0,
        "hopeFRR": 0,
        "createTime": "2021-09-20 14:11:19",
        "completeTime": "2021-09-20 18:10:07",
        "testState": "Completed",
        "deleted":"0"
    },
    {
        "id": "Q1CeKuofA1v5Wuh0g6Tl",
        "projectId": "R-2HTPWZyZEosmiPQa6Gh",
        "sdkVersion": "30",
        "testName": "test123",
        "sceneName": "scene1",
        "allowThreshold": 0,
        "thresholdmodelBGR": 0.5,
        "thresholdmodelIR": 0.7,
        "similarityThresholdLow": 0.95,
        "similarityThresholdHigh": 0.95,
        "testModel": 1,
        "allowCover": 0,
        "allowFace": 0,
        "allowGender": 0,
        "allowNum": 0,
        "allowBack": 0,
        "allowLightType": 0,
        "allowLightIntensity": 0,
        "allowConcurrent": 0,
        "allowDistanceLow": 10,
        "allowDistanceHigh": 30,
        "hopeFAR": 0,
        "hopeFRR": 0,
        "createTime": "2021-09-20 14:11:51",
        "completeTime": "",
        "testState": "Saved",
        "deleted":"0"
    },
    {
        "id": "qaiyXHHjcybGzCpPa1iB",
        "projectId": "R-2HTPWZyZEosmiPQa6Gh",
        "sdkVersion": "30",
        "testName": "school123",
        "sceneName": "scene1",
        "allowThreshold": 0,
        "thresholdmodelBGR": 0.5,
        "thresholdmodelIR": 0.7,
        "similarityThresholdLow": 0.95,
        "similarityThresholdHigh": 0.95,
        "testModel": 1,
        "allowCover": 0,
        "allowFace": 0,
        "allowGender": 0,
        "allowNum": 0,
        "allowBack": 0,
        "allowLightType": 0,
        "allowLightIntensity": 0,
        "allowConcurrent": 0,
        "allowDistanceLow": 10,
        "allowDistanceHigh": 30,
        "hopeFAR": 0,
        "hopeFRR": 0,
        "createTime": "2021-09-20 14:12:37",
        "completeTime": "",
        "testState": "Error",
        "deleted":"0"
    },
    {
        "id": "TJS19Jk37E3RGvRS_kQx",
        "projectId": "R-2HTPWZyZEosmiPQa6Gh",
        "sdkVersion": "30",
        "testName": "Demo",
        "sceneName": "scene1",
        "allowThreshold": 0,
        "thresholdmodelBGR": 0.5,
        "thresholdmodelIR": 0.7,
        "similarityThresholdLow": 0.95,
        "similarityThresholdHigh": 0.95,
        "testModel": 1,
        "allowCover": 0,
        "allowFace": 0,
        "allowGender": 0,
        "allowNum": 0,
        "allowBack": 0,
        "allowLightType": 0,
        "allowLightIntensity": 0,
        "allowConcurrent": 0,
        "allowDistanceLow": 10,
        "allowDistanceHigh": 30,
        "hopeFAR": 0,
        "hopeFRR": 0,
        "createTime": "2021-09-20 14:13:04",
        "completeTime": "2021-09-21 11:08:00",
        "testState": "Completed",
        "deleted":"0"
    }
]

    projectList = [
        {
            "projectId":"R-2HTPWZyZEosmiPQa6Gh",
            "userId":"admin",
            "projectName":"项目1",
            "createTime":"2021-08-15 13:40:12",
            "introduction":"这是测试项目1这是测试项目1这是测试项目1这是测试项目1",
            "deleted":0,
        },
        {
            "projectId":"UP-ZhUk1op5tnuq2GfGTw",
            "userId":"admin",
            "projectName":"项目2",
            "createTime":"2021-08-17 18:40:12",
            "introduction":"这是测试项目2",
            "deleted":0,
        },
        {
            "projectId":"qpt-v3TEYB1yY0o4n7GgC",
            "userId":"admin",
            "projectName":"项目3",
            "createTime":"2021-08-20 16:40:12",
            "introduction":"这是测试项目3",
            "deleted":0,
        },
        {
            "projectId":"CjoWxBbdjiQ9rBKIeLxPs",
            "userId":"admin",
            "projectName":"项目4",
            "createTime":"2021-09-15 19:40:00",
            "introduction":"这是测试项目4",
            "deleted":0,
        }
    ]


    for i in testList:
        scenesql = SceneTestList(i)
        db.session.add(scenesql)
        db.session.commit()

    for i in projectList:
        scenesql = SceneProjectList(i)
        db.session.add(scenesql)
        db.session.commit()


def start():
    startid = "Q1CeKuofA1v5Wuh0g6Tl"
    # res = SceneTestList.query.filter_by(id = startid).all()
    db.session.query(SceneTestList).filter_by(id = startid).update({"testState": "Saved"})
    db.session.commit()
    # res[0].testState = "Running"
    # print(res[0].__dict__)

def delete():
    startid = "Q1CeKuofA1v5Wuh0g6Tl"
    scenetest = db.session.query(SceneTestList).filter_by(id = startid).first()
    db.session.delete(scenetest)
    db.session.commit()

if __name__ == "__main__":
    create()
    # start()
