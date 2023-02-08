package edu.lg.dao;

import java.io.IOException;
import java.util.ArrayList;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class DataReducer extends Reducer<Text, Text, Text, Text> {
	
	@Override
	public void reduce(Text _key, Iterable<Text> values, Context context) throws IOException, InterruptedException {
		//ͳ���ܴ���
		int[] tp = new int[21];
		int[] tn = new int[21];
		int[] fp = new int[21];
		int[] fn = new int[21];
		//����value���ۼ�
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
		//ͳ�Ƹ���ֵ�½��
		String result = String.valueOf(tp[0]) + "," + tn[0] + "," + fp[0] + "," + fn[0];
		for(int i = 1; i < 21; ++i) {
			result += " " + tp[i] + "," + tn[i] + "," + fp[i] + "," + fn[i];
		}
		//���ͳ�ƽ��
		context.write(_key, new Text(result));
	}
}