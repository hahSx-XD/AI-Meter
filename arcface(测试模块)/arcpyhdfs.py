import pyhdfs


class HDFSFileManager():

    def __init__(self,host, user_name):
        self.fs = pyhdfs.HdfsClient(hosts=host, user_name=user_name)

    # upload file to hdfs from local file system
    def file_upload(self, local_path, hdfs_path):
        print("file upload start")
        # print(fs.listdir('/'))
        self.fs.copy_from_local(local_path, hdfs_path)
        print("file upload finish")
 
    # download file from hdfs file system
    def file_down(self, local_path, hdfs_path):
        print("file download start")
        self.fs.copy_to_local(hdfs_path, local_path)
        print("file download finish")


if __name__ == '__main__':
    file_manager = HDFSFileManager("192.168.43.100:50070", "root")
    # file_manager.file_upload("./test.csv", "/arcData/test3.csv")
    file_manager.file_down("arcid.csv", "/arcData/arctt05.csv") # 9870
