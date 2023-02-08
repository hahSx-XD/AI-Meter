package edu.lg.utils;

import org.apache.hadoop.hbase.util.Bytes;

/**
 * �������ж���hbase�ı�����������������
 * ͨ��ʹ�ó�����ʽ������
 * @author tarena
 *
 */
public class LogUtil {
	
//	����gsod�������ͨ����������
//	���壺INFO&DATA���壬byte[]
	public static final byte[][] COLUMN_FAMILYS = {Bytes.toBytes("INFO"),Bytes.toBytes("DATA")};
//	�У�������INFO�����Լ�������DATA����
//	INFO����
	public static final byte[] INFO_ID = Bytes.toBytes("ID");
	public static final byte[] INFO_KEY = Bytes.toBytes("KEY");
	public static final byte[] INFO_THRESHOLD = Bytes.toBytes("THRESHOLD");
//	DATA����
	public static final byte[] DATA_RESULT = Bytes.toBytes("RESULT");
}
