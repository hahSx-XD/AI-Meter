package edu.lg.dao;

import java.io.IOException;
import java.util.ArrayList;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class DataReducer extends Reducer<Text, Text, Text, Text> {
	
	@Override
	public void reduce(Text _key, Iterable<Text> values, Context context) throws IOException, InterruptedException {
		//统计总次数
		int[] tp = new int[21];
		int[] tn = new int[21];
		int[] fp = new int[21];
		int[] fn = new int[21];
		//处理value：累加
		for(Text vals : values) {
			String[] val = vals.toString().split(",");
			for(int i = 1; i < val.length; ++i) {
				if (val[i].contains(":1")) {
					tp[i-1]++;
				} else if(val[i].contains(":2")) {
					tn[i-1]++;
				} else if(val[i].contains(":3")) {
					fp[i-1]++;
				} else if(val[i].contains(":4")) {
					fn[i-1]++;
				}
			}
		}
		//统计各阈值下结果
		String result = String.valueOf(tp[0]) + "," + tn[0] + "," + fp[0] + "," + fn[0];
		for(int i = 1; i < 21; ++i) {
			result += " " + tp[i] + "," + tn[i] + "," + fp[i] + "," + fn[i];
		}
		//输出统计结果
		context.write(_key, new Text(result));
	}
}