from arcface.struct_info import *

root_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
if platform=="win32":
    dll_msvcp = CDLL(r'{}/lib/win/msvcp120.dll'.format(root_dir))
    dll_msvcr = CDLL(r'{}/lib/win/msvcr120.dll'.format(root_dir))
    dll_null = CDLL(r'{}/lib/win/libarcsoft_face.dll'.format(root_dir))
    dll = CDLL(r'{}/lib/win/libarcsoft_face_engine.dll'.format(root_dir))
    dllc = cdll.msvcrt
elif platform=="linux":
    dll_null = CDLL(r'{}/lib/linux/v2.0/libarcsoft_face.so'.format(root_dir))
    dll = CDLL(r'{}/lib/linux/v2.0/libarcsoft_face_engine.so'.format(root_dir))
    dllc = CDLL("libc.so.6")
else:
    raise Exception("Unsupported operating platform:{}".format(platform))

c_ubyte_p = POINTER(c_ubyte)

# 激活
ASFOnlineActivation = dll.ASFActivation
ASFOnlineActivation.restype = c_int32
ASFOnlineActivation.argtypes = (c_char_p, c_char_p)

# 初始化
ASFInitEngine = dll.ASFInitEngine
ASFInitEngine.restype = c_int32
ASFInitEngine.argtypes = (c_long, c_int32, c_int32, c_int32, c_int32, POINTER(c_void_p))

# 人脸识别
ASFDetectFaces = dll.ASFDetectFaces
ASFDetectFaces.restype = c_int32
ASFDetectFaces.argtypes = (c_void_p, c_int32, c_int32, c_int32, POINTER(c_ubyte), POINTER(ASF_MultiFaceInfo))

# 特征提取
ASFFaceFeatureExtract = dll.ASFFaceFeatureExtract
ASFFaceFeatureExtract.restype = c_int32
ASFFaceFeatureExtract.argtypes = (c_void_p, c_int32, c_int32, c_int32, POINTER(c_ubyte), POINTER(ASF_SingleFaceInfo), POINTER(ASF_FaceFeature))

# 特征比对
ASFFaceFeatureCompare = dll.ASFFaceFeatureCompare
ASFFaceFeatureCompare.restype = c_int32
ASFFaceFeatureCompare.argtypes = (c_void_p, POINTER(ASF_FaceFeature), POINTER(ASF_FaceFeature), POINTER(c_float))

#  RGB图像属性检测
ASFProcess = dll.ASFProcess
ASFProcess.restype = c_int32
ASFProcess.argtypes = (c_void_p, c_int32, c_int32, c_int32, POINTER(c_ubyte), POINTER(ASF_MultiFaceInfo),c_int32)

#获取年龄
ASFGetAge = dll.ASFGetAge
ASFGetAge.restype = c_int32
ASFGetAge.argtypes = (c_void_p, POINTER(ASF_AgeInfo))

#获取性别信息
ASFGetGender = dll.ASFGetGender
ASFGetGender.restype = c_int32
ASFGetGender.argtypes = (c_void_p, POINTER(ASF_GenderInfo))

#获取3d角度信息
ASFGetFace3DAngle = dll.ASFGetFace3DAngle
ASFGetFace3DAngle.restype = c_int32
ASFGetFace3DAngle.argtypes = (c_void_p, POINTER(ASF_Face3DAngle))

# 版本版权信息
ASFGetVersion = dll.ASFGetVersion
ASFGetVersion.restype = c_int32
ASFGetVersion.argtypes = (POINTER(ASF_VERSION),)

#销毁引擎
ASFUninitEngine = dll.ASFUninitEngine
ASFUninitEngine.argtypes = (c_void_p,)


# libc内存操作
malloc = dllc.malloc
malloc.restype = c_void_p
malloc.argtypes = (c_size_t,)

free = dllc.free
free.restype = None
free.argtypes = (c_void_p,)

memcpy = dllc.memcpy
memcpy.restype = c_void_p
memcpy.argtypes = (c_void_p, c_void_p, c_size_t)
