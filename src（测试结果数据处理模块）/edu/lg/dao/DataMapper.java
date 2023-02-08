package edu.lg.dao;

import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class DataMapper extends Mapper<LongWritable, Text, Text, Text> {
	
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
		line = line.replaceAll("\"\\{", "").replaceAll("\\}\"", "").replaceAll(" ", "").replaceAll("'", "");
		context.write(new Text("age:" + line.split(",")[0].split("_")[2]), new Text(line));
		context.write(new Text("gender:" + line.split(",")[0].split("_")[3]), new Text(line));
		context.write(new Text("roll:" + line.split(",")[0].split("_")[4]), new Text(line));
		context.write(new Text("yaw:" + line.split(",")[0].split("_")[5]), new Text(line));
		context.write(new Text("pitch:" + line.split(",")[0].split("_")[6]), new Text(line));
		context.write(new Text("expression:" + line.split(",")[0].split("_")[7]), new Text(line));
		context.write(new Text("hide:" + line.split(",")[0].split("_")[8]), new Text(line));
		context.write(new Text("single:" + line.split(",")[0].split("_")[9]), new Text(line));
		context.write(new Text("background:" + line.split(",")[0].split("_")[10]), new Text(line));
		context.write(new Text("type:" + line.split(",")[0].split("_")[11]), new Text(line));
		context.write(new Text("light:" + line.split(",")[0].split("_")[12]), new Text(line));
		context.write(new Text("distance:" + line.split(",")[0].split("_")[13]), new Text(line));
		context.write(new Text("grayscale:" + line.split(",")[0].split("_")[14]), new Text(line));
		context.write(new Text("vague:" + line.split(",")[0].split("_")[15]), new Text(line));
	}
}
