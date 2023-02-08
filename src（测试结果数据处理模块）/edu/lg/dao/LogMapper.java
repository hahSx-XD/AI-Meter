package edu.lg.dao;

import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

import com.sun.xml.internal.fastinfoset.util.CharArray;

public class LogMapper extends Mapper<LongWritable, Text, Text, Text> {
	
	@Override
	public void map(LongWritable ikey, Text ivalue, Context context) throws IOException, InterruptedException {
		//��ȡ��������
		String line = ivalue.toString();
		//csvԭʼ�ļ��ĵ�һ�����ֶε����ƣ�ȥ����������
		if(line.startsWith("id")){
			return; //���ӷ���ֵ��return�ؼ��֣���ʾ�������η����ĵ���
		}
		//ԭʼ���ݵ���������ڿ��У�ȥ����
		if(line.equals("")){
			return;
		}
		//����dataΪ��Ҫ���ַ���
		line = line.replaceAll("  ", " ").replaceAll("\t", " ").replaceAll(".bmp", "");
		char[] chars = line.toCharArray();
		chars[line.lastIndexOf("/")] = ' ';
		line = String.valueOf(chars);
		System.out.println(line);
		context.write(new Text(line.split(" ")[0] + ":" + line.split(" ")[3] + ":" + line.split(" ")[4]), new Text(line));
	}
}
