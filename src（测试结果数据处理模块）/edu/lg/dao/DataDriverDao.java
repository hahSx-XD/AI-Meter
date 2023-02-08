package edu.lg.dao;

import java.io.InputStream;
import java.net.URI;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.fs.permission.FsAction;
import org.apache.hadoop.io.IOUtils;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class DataDriverDao {

	public int driver(String id) throws Exception {
		System.setProperty("HADOOP_USER_NAME", "root");
		Configuration conf = new Configuration();
		//设置副本数量
		conf.set("dfs.replication", "1");
		conf.set("fs.defaultFS", "hdfs://192.168.43.100:9000"); // 运行在hdfs上
		Job job = Job.getInstance(conf, "JobName");
		
		job.setJarByClass(edu.lg.dao.DataDriverDao.class);
		job.setMapperClass(edu.lg.dao.DataMapper.class);

		job.setReducerClass(edu.lg.dao.DataReducer.class);

		job.setMapOutputKeyClass(Text.class);
		job.setMapOutputValueClass(Text.class);
		
		// TODO: specify output types
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(Text.class);

		// TODO: specify input and output DIRECTORIES (not files)
		FileInputFormat.setInputPaths(job, new Path("hdfs://192.168.43.100:9000/arcData/" + id + ".csv"));
		FileOutputFormat.setOutputPath(job, new Path("hdfs://192.168.43.100:9000/arcClear/" + id));
		
		if (!job.waitForCompletion(true))
			return 0;
		else {
//			//重命名
			FileSystem fs = FileSystem.get(new URI("hdfs://192.168.43.100:9000"), conf, "root");
			fs.rename(new Path("/arcClear/" + id + "/part-r-00000"), new Path("/arcClear/" + id + "/arcClear.csv"));
			fs.close();
			return 1;
		}
	}

}
