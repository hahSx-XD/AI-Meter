package edu.lg.dao;

import java.io.IOException;
import java.util.ArrayList;

import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class LogReducer extends Reducer<Text, Text, Text, Text> {
	
	@Override
	public void reduce(Text _key, Iterable<Text> values, Context context) throws IOException, InterruptedException {
		//处理value
		String result = "";
		for(Text vals : values) {
			String[] val = vals.toString().split(" ");
			if (vals.toString().contains("FP")||vals.toString().contains("FN")){
				result += "[ ERROR: TaskID= " + val[0] + ", RegistLable= " + val[2] + ", TestLable= " + val[5] + ", Type= " + val[3] + ", ConfidenceLevel= " + val[4] + " ]";
			}
			else {
				result += "[ERROR: " + vals.toString() + " ]";
			}
		}
		//输出结果
		context.write(_key, new Text(result));
	}
}