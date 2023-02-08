package edu.lg.dao;

import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class DataMapper extends Mapper<LongWritable, Text, Text, Text> {
	
	@Override
	public void map(LongWritable ikey, Text ivalue, Context context) throws IOException, InterruptedException {
		//获取整行数据
		String line = ivalue.toString();
		//csv原始文件的第一行是字段的名称，去除此行数据
		if(line.startsWith("id")){
			return; //不加返回值的return关键字，表示结束本次方法的调用
		}
		//原始数据当中如果存在空行，去除掉
		if(line.equals("")){
			return;
		}
		//处理data为需要的字符串
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
