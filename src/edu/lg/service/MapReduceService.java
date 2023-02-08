package edu.lg.service;

import java.net.URI;
import java.util.ArrayList;
import java.util.List;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FSDataInputStream;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.hbase.client.Put;
import org.apache.hadoop.hbase.util.Bytes;
import org.apache.hadoop.io.IOUtils;
import org.eclipse.jdt.internal.compiler.ast.ThisReference;
import org.junit.Before;

import com.sun.org.apache.xpath.internal.operations.And;

import edu.lg.dao.DataDriverDao;
import edu.lg.dao.HBaseDao;
import edu.lg.dao.LogDriverDao;

public class MapReduceService {
	
//	定义成员变量
	private  Configuration conf;
	private FileSystem fs ;
	HBaseDao hBaseDao = new HBaseDao();

	public void init() throws Exception{
		conf = new Configuration();
//		指定操作HDFS的用户为root
		fs = FileSystem.get(new URI("hdfs://192.168.43.100:9000"), conf,"root");
	}
	
	public String dataClear(String id, String key, String value) throws Exception{
		init();
		// 判断output文件夹是否存在
	    Path path = new Path("hdfs://192.168.43.100:9000/arcClear/" + id);
	    // 根据path找到这个文件
	    FileSystem fileSystem = path.getFileSystem(conf);
	    //如果文件不存在，则进行数据清洗
	    if (!fileSystem.exists(path)) {
	    	DataDriverDao dataDriver = new DataDriverDao();
	    	dataDriver.driver(id);
	    	FSDataInputStream in = fileSystem.open(new Path("hdfs://192.168.43.100:9000/arcClear/" + id + "/arcClear.csv"));
	    	
		    String dataString = in.readLine();
		    List<Put> putList = new ArrayList<Put>();
		    
			while (dataString != null & dataString != "") {
				String[] datas = dataString.split("\t");
//				设置行键
				Put put = new Put(Bytes.toBytes(datas[0]));
				put.add(Bytes.toBytes("INFO"), Bytes.toBytes("ID"), Bytes.toBytes(datas[0]));
				put.add(Bytes.toBytes("INFO"), Bytes.toBytes("KEY"), Bytes.toBytes(datas[0].split(":")[0]));
				if((datas[0].split(":")[0]).equals("roll") || (datas[0].split(":")[0]).equals("yaw") || (datas[0].split(":")[0]).equals("pitch") || (datas[0].split(":")[0]).equals("age")) {
					put.add(Bytes.toBytes("INFO"), Bytes.toBytes("VALUE"), Bytes.toBytes(String.valueOf(Integer.parseInt(datas[0].split(":")[1])+200)));
				} else {
					put.add(Bytes.toBytes("INFO"), Bytes.toBytes("VALUE"), Bytes.toBytes(datas[0].split(":")[1]));
				}
				
				put.add(Bytes.toBytes("DATA"), Bytes.toBytes("RESULT"), Bytes.toBytes(datas[1]));
				putList.add(put);
				dataString = in.readLine();
			}
			hBaseDao.createTable(id, putList);
			System.out.println("Clear data and Creat table success");
			in.close();
	    }
	    //文件已存在，根据需求读取hbase数据
	    System.out.println("Data and Table already exists");
	    return hBaseDao.countData(id, key, value);
	}
	
	public String logClear(String id, String threshold) throws Exception{
		init();
		// 判断output文件夹是否存在
	    Path path = new Path("hdfs://192.168.43.100:9000/logClear/" + id);
	    // 根据path找到这个文件
	    FileSystem fileSystem = path.getFileSystem(conf);
	    //如果文件不存在，则进行数据清洗
	    if (!fileSystem.exists(path)) {
	    	LogDriverDao logDriver = new LogDriverDao();
	    	logDriver.driver(id);
	    	FSDataInputStream in = fileSystem.open(new Path("hdfs://192.168.43.100:9000/logClear/" + id + "/logClear.csv"));
	    	
		    String dataString = in.readLine();
		    List<Put> putList = new ArrayList<Put>();
		    
			while (dataString != null & dataString != "") {
				String[] datas = dataString.split("\t");
//				设置行键
				Put put = new Put(Bytes.toBytes(datas[0]));
				put.add(Bytes.toBytes("INFO"), Bytes.toBytes("ID"), Bytes.toBytes(datas[0].split(":")[0]));
				put.add(Bytes.toBytes("INFO"), Bytes.toBytes("KEY"), Bytes.toBytes(datas[0].split(":")[1]));
				put.add(Bytes.toBytes("INFO"), Bytes.toBytes("THRESHOLD"), Bytes.toBytes(datas[0].split(":")[2]));
				
				put.add(Bytes.toBytes("DATA"), Bytes.toBytes("RESULT"), Bytes.toBytes(datas[1]));
				putList.add(put);
				dataString = in.readLine();
			}
			hBaseDao.createLogTable("log_" + id, putList);
			System.out.println("Clear data and Creat table success");
			in.close();
	    }
	    //文件已存在，根据需求读取hbase数据
	    System.out.println("Data and Table already exists");
	    return hBaseDao.countLog("log_" + id, threshold);
	}
	
}
