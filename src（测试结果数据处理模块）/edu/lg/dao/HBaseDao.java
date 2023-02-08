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
//	�������ö���
	private static Configuration conf;
//	��ʼ�����ھ�̬�������
	static{
		conf = HBaseConfiguration.create();
//		ָ��hbase���õ�zkʵ��
		conf.set("hbase.zookeeper.quorum", "hadoop01");
	}
	
//	���崴����ķ����������д���������
	public void createTable(String tableName, List<Put> putList) throws Exception{
//		1����ȡ�������
		HBaseAdmin admin = new HBaseAdmin(conf);
//		3����������
		byte[][] columnFamilys = ArcUtil.COLUMN_FAMILYS;
//		4��ָ��TableName
		TableName tName = TableName.valueOf(tableName);
//		5�����ñ�������
		HTableDescriptor tableDesc = new HTableDescriptor(tName);
//		6����������ӵ����������У�����columnFamilys��ͨ�������������������壬������ӵ�����
		for (byte[] cs : columnFamilys) {
//			��������������
			HColumnDescriptor colDesc = new HColumnDescriptor(cs);
//			��ӵ�tableDesc
			tableDesc.addFamily(colDesc);
		}
//		����admin�����˱�
		admin.createTable(tableDesc);
		System.out.println("Create data-table success");
		admin.close();
		
//		��ȡ��
		HTable table = new HTable(conf,tableName);
		table.put(putList);
		table.close();
	}
	
//	���崴����ķ����������д���������
	public void createLogTable(String tableName, List<Put> putList) throws Exception{
//		1����ȡ�������
		HBaseAdmin admin = new HBaseAdmin(conf);
//		3����������
		byte[][] columnFamilys = LogUtil.COLUMN_FAMILYS;
//		4��ָ��TableName
		TableName tName = TableName.valueOf(tableName);
//		5�����ñ�������
		HTableDescriptor tableDesc = new HTableDescriptor(tName);
//		6����������ӵ����������У�����columnFamilys��ͨ�������������������壬������ӵ�����
		for (byte[] cs : columnFamilys) {
//			��������������
			HColumnDescriptor colDesc = new HColumnDescriptor(cs);
//			��ӵ�tableDesc
			tableDesc.addFamily(colDesc);
		}
//		����admin�����˱�
		admin.createTable(tableDesc);
		System.out.println("Create log-table success");
		admin.close();
		
//		��ȡ��
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
			//����ɸѡ����
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
			//����ɸѡ����
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
		//ͳ���ܴ���
		int[] tp = new int[21];
		int[] tn = new int[21];
		int[] fp = new int[21];
		int[] fn = new int[21];
		for (Result result : rs) {
			System.out.println(Bytes.toString(result.getRow()));//��׮
			String[] results = Bytes.toString(result.getValue(Bytes.toBytes("DATA"), ArcUtil.DATA_RESULT)).split(" ");
			//�ۼ�
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
		//ͳ�Ƹ���ֵ�½��
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
				System.out.println(Bytes.toString(result.getRow()));//��׮
				if(resultString.equals("")) {
					resultString += Bytes.toString(result.getValue(Bytes.toBytes("DATA"), LogUtil.DATA_RESULT));
				} else {
					resultString += "\n" + Bytes.toString(result.getValue(Bytes.toBytes("DATA"), LogUtil.DATA_RESULT));
				}
			}
		} else {
			//����ɸѡ����
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
			//�ۼ�
			for (Result result : rs) {
				System.out.println(Bytes.toString(result.getRow()));//��׮
				if(resultString.equals("")) {
					resultString += Bytes.toString(result.getValue(Bytes.toBytes("DATA"), LogUtil.DATA_RESULT));
				} else {
					resultString += "\n" + Bytes.toString(result.getValue(Bytes.toBytes("DATA"), LogUtil.DATA_RESULT));
				}
			}
			rs = null;
			//����ɸѡ����
			Filter filter3 = new SingleColumnValueFilter("INFO".getBytes(),
					"KEY".getBytes(),
					CompareOp.EQUAL, "FN".getBytes());
			Filter filter4 = new SingleColumnValueFilter("INFO".getBytes(),
					"THRESHOLD".getBytes(),
					CompareOp.LESS_OR_EQUAL, threshold.getBytes());
			FilterList filterList2 = new FilterList(Arrays.asList(filter3, filter4));
			scan.setFilter(filterList2);
			rs = table.getScanner(scan);
			//�ۼ�
			for (Result result : rs) {
				System.out.println(Bytes.toString(result.getRow()));//��׮
				if(resultString.equals("")) {
					resultString += Bytes.toString(result.getValue(Bytes.toBytes("DATA"), LogUtil.DATA_RESULT));
				} else {
					resultString += "\n" + Bytes.toString(result.getValue(Bytes.toBytes("DATA"), LogUtil.DATA_RESULT));
				}
			}
		}
		rs.close();
		table.close();
		//ͳ�Ƹ���ֵ�½��
		return resultString;
	}
	
}
