package edu.lg.utils;

import org.apache.hadoop.hbase.util.Bytes;

/**
 * 工具类中定义hbase的表名、列族名、列名
 * 通常使用常量形式来定义
 * @author tarena
 *
 */
public class LogUtil {
	
//	创建gsod表的属性通过常量方法
//	列族：INFO&DATA列族，byte[]
	public static final byte[][] COLUMN_FAMILYS = {Bytes.toBytes("INFO"),Bytes.toBytes("DATA")};
//	列：归属于INFO列族以及归属于DATA列族
//	INFO列族
	public static final byte[] INFO_ID = Bytes.toBytes("ID");
	public static final byte[] INFO_KEY = Bytes.toBytes("KEY");
	public static final byte[] INFO_THRESHOLD = Bytes.toBytes("THRESHOLD");
//	DATA列族
	public static final byte[] DATA_RESULT = Bytes.toBytes("RESULT");
}
