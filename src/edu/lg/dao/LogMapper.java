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
		line = line.replaceAll("  ", " ").replaceAll("\t", " ").replaceAll(".bmp", "");
		char[] chars = line.toCharArray();
		chars[line.lastIndexOf("/")] = ' ';
		line = String.valueOf(chars);
		System.out.println(line);
		context.write(new Text(line.split(" ")[0] + ":" + line.split(" ")[3] + ":" + line.split(" ")[4]), new Text(line));
	}
}
