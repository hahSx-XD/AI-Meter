package edu.lg.dao;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.fs.permission.AclUtil;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.HColumnDescriptor;
import org.apache.hadoop.hbase.HTableDescriptor;
import org.apache.hadoop.hbase.TableName;
import org.apache.hadoop.hbase.client.HBaseAdmin;
import org.apache.hadoop.hbase.client.HTable;
import org.apache.hadoop.hbase.client.Put;
import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.client.ResultScanner;
import org.apache.hadoop.hbase.client.Scan;
import org.apache.hadoop.hbase.client.coprocessor.AggregationClient;
import org.apache.hadoop.hbase.filter.Filter;
import org.apache.hadoop.hbase.filter.FilterList;
import org.apache.hadoop.hbase.filter.SingleColumnValueFilter;
import org.apache.hadoop.hbase.filter.CompareFilter.CompareOp;
import org.apache.hadoop.hbase.io.ImmutableBytesWritable;
import org.apache.hadoop.hbase.mapreduce.TableOutputFormat;
import org.apache.hadoop.hbase.util.Bytes;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;

import edu.lg.service.MapReduceService;
import edu.lg.utils.ArcUtil;
import edu.lg.utils.LogUtil;

public class HBaseDao {
//	声明配置对象
	private static Configuration conf;
//	初始化：在静态代码块中
	static{
		conf = HBaseConfiguration.create();
//		指定hbase所用的zk实例
		conf.set("hbase.zookeeper.quorum", "hadoop01");
	}
	
//	定义创建表的方法：在其中创建表、列族
	public void createTable(String tableName, List<Put> putList) throws Exception{
//		1、获取表管理器
		HBaseAdmin admin = new HBaseAdmin(conf);
//		3、定义列族
		byte[][] columnFamilys = ArcUtil.COLUMN_FAMILYS;
//		4、指定TableName
		TableName tName = TableName.valueOf(tableName);
//		5、利用表描述器
		HTableDescriptor tableDesc = new HTableDescriptor(tName);
//		6、将列族添加到表描述器中，遍历columnFamilys，通过列族描述器声明列族，将其添加到表中
		for (byte[] cs : columnFamilys) {
//			利用列族描述器
			HColumnDescriptor colDesc = new HColumnDescriptor(cs);
//			添加到tableDesc
			tableDesc.addFamily(colDesc);
		}
//		调用admin创建此表
		admin.createTable(tableDesc);
		System.out.println("Create data-table success");
		admin.close();
		
//		获取表
		HTable table = new HTable(conf,tableName);
		table.put(putList);
		table.close();
	}
	
//	定义创建表的方法：在其中创建表、列族
	public void createLogTable(String tableName, List<Put> putList) throws Exception{
//		1、获取表管理器
		HBaseAdmin admin = new HBaseAdmin(conf);
//		3、定义列族
		byte[][] columnFamilys = LogUtil.COLUMN_FAMILYS;
//		4、指定TableName
		TableName tName = TableName.valueOf(tableName);
//		5、利用表描述器
		HTableDescriptor tableDesc = new HTableDescriptor(tName);
//		6、将列族添加到表描述器中，遍历columnFamilys，通过列族描述器声明列族，将其添加到表中
		for (byte[] cs : columnFamilys) {
//			利用列族描述器
			HColumnDescriptor colDesc = new HColumnDescriptor(cs);
//			添加到tableDesc
			tableDesc.addFamily(colDesc);
		}
//		调用admin创建此表
		admin.createTable(tableDesc);
		System.out.println("Create log-table success");
		admin.close();
		
//		获取表
		HTable table = new HTable(conf, tableName);
		table.put(putList);
		table.close();
	}
	
	public String countData(String tableName, String key, String value) throws Exception {
		HTable table = new HTable(conf,tableName);
		Scan scan = new Scan();
		ResultScanner rs = null;
		if(value.contains("_")) {
			String[] values = value.split("_");
			String min = values[0];
			String max = values[1];
			if(key.equals("roll") || key.equals("yaw") || key.equals("pitch") || key.equals("age")) {
				min = String.valueOf(Integer.parseInt(min)+200);
				max = String.valueOf(Integer.parseInt(max)+200);
			}
			System.out.println(min + " ---- " + max);
			//设置筛选条件
			Filter filter1 = new SingleColumnValueFilter("INFO".getBytes(),
					"KEY".getBytes(),
					CompareOp.EQUAL, key.getBytes());
			Filter filter2 = new SingleColumnValueFilter("INFO".getBytes(),
					"VALUE".getBytes(),
					CompareOp.GREATER_OR_EQUAL, min.getBytes());
			Filter filter3 = new SingleColumnValueFilter("INFO".getBytes(),
					"VALUE".getBytes(),
					CompareOp.LESS_OR_EQUAL, max.getBytes());
			FilterList filterList = new FilterList(Arrays.asList(filter1, filter2,filter3));
			scan.setFilter(filterList);
			rs = table.getScanner(scan);
		}else {
			//设置筛选条件
			Filter filter1 = new SingleColumnValueFilter("INFO".getBytes(),
					"KEY".getBytes(),
					CompareOp.EQUAL, key.getBytes());
			Filter filter2 = new SingleColumnValueFilter("INFO".getBytes(),
					"VALUE".getBytes(),
					CompareOp.EQUAL, value.getBytes());
			FilterList filterList = new FilterList(Arrays.asList(filter1, filter2));
			scan.setFilter(filterList);
			rs = table.getScanner(scan);
		}
		//统计总次数
		int[] tp = new int[21];
		int[] tn = new int[21];
		int[] fp = new int[21];
		int[] fn = new int[21];
		for (Result result : rs) {
			System.out.println(Bytes.toString(result.getRow()));//打桩
			String[] results = Bytes.toString(result.getValue(Bytes.toBytes("DATA"), ArcUtil.DATA_RESULT)).split(" ");
			//累加
			for(int i = 0; i < results.length; ++i) {
				String[] val = results[i].split(",");
				tp[i] += Integer.parseInt(val[0]);
				tn[i] += Integer.parseInt(val[1]);
				fp[i] += Integer.parseInt(val[2]);
				fn[i] += Integer.parseInt(val[3]);
			}
		}
		rs.close();
		table.close();
		//统计各阈值下结果
		String result = String.valueOf(tp[0]) + "," + tn[0] + "," + fp[0] + "," + fn[0];
		for(int i = 1; i < 21; ++i) {
			result += " " + tp[i] + "," + tn[i] + "," + fp[i] + "," + fn[i];
		}
		if(result.contains("0,0,0,0")) {
			return "0";
		}
		return result;
	}
	
	public String countLog(String tableName, String threshold) throws Exception {
		HTable table = new HTable(conf, tableName);
		Scan scan = new Scan();
		String resultString = "";
		ResultScanner rs = null;
		if(threshold.equals("0")) {
			rs = table.getScanner(scan);
			for (Result result : rs) {
				System.out.println(Bytes.toString(result.getRow()));//打桩
				if(resultString.equals("")) {
					resultString += Bytes.toString(result.getValue(Bytes.toBytes("DATA"), LogUtil.DATA_RESULT));
				} else {
					resultString += "\n" + Bytes.toString(result.getValue(Bytes.toBytes("DATA"), LogUtil.DATA_RESULT));
				}
			}
		} else {
			//设置筛选条件
			Filter filter1 = new SingleColumnValueFilter("INFO".getBytes(),
					"KEY".getBytes(),
					CompareOp.EQUAL, "FP".getBytes());
			Filter filter2 = new SingleColumnValueFilter("INFO".getBytes(),
					"THRESHOLD".getBytes(),
					CompareOp.GREATER_OR_EQUAL, threshold.getBytes());
			FilterList filterList1 = new FilterList(Arrays.asList(filter1, filter2));
			scan.setFilter(filterList1);
			rs = null;
			rs = table.getScanner(scan);
			//累加
			for (Result result : rs) {
				System.out.println(Bytes.toString(result.getRow()));//打桩
				if(resultString.equals("")) {
					resultString += Bytes.toString(result.getValue(Bytes.toBytes("DATA"), LogUtil.DATA_RESULT));
				} else {
					resultString += "\n" + Bytes.toString(result.getValue(Bytes.toBytes("DATA"), LogUtil.DATA_RESULT));
				}
			}
			rs = null;
			//设置筛选条件
			Filter filter3 = new SingleColumnValueFilter("INFO".getBytes(),
					"KEY".getBytes(),
					CompareOp.EQUAL, "FN".getBytes());
			Filter filter4 = new SingleColumnValueFilter("INFO".getBytes(),
					"THRESHOLD".getBytes(),
					CompareOp.LESS_OR_EQUAL, threshold.getBytes());
			FilterList filterList2 = new FilterList(Arrays.asList(filter3, filter4));
			scan.setFilter(filterList2);
			rs = table.getScanner(scan);
			//累加
			for (Result result : rs) {
				System.out.println(Bytes.toString(result.getRow()));//打桩
				if(resultString.equals("")) {
					resultString += Bytes.toString(result.getValue(Bytes.toBytes("DATA"), LogUtil.DATA_RESULT));
				} else {
					resultString += "\n" + Bytes.toString(result.getValue(Bytes.toBytes("DATA"), LogUtil.DATA_RESULT));
				}
			}
		}
		rs.close();
		table.close();
		//统计各阈值下结果
		return resultString;
	}
	
}
