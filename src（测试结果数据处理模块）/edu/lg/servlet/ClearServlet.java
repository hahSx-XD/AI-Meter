package edu.lg.servlet;

import java.io.IOException;

import edu.lg.dao.*;
import edu.lg.service.MapReduceService;

import java.net.URISyntaxException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.hadoop.fs.FileStatus;

import com.sun.xml.internal.ws.encoding.DataHandlerDataSource;

@WebServlet("/dataClear")

public class ClearServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	DataDriverDao dsDataDriver = new DataDriverDao();

	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MapReduceService mapReduceService = new MapReduceService();
		String id = request.getParameter("id");//测试id
		String key = request.getParameter("key");//查看的属性：性别 gender。。。
		String value = request.getParameter("value");//属性的值：年龄等使用范围如 20-30
		try {
			String dataString = mapReduceService.dataClear(id, key, value);
			response.getWriter().write(dataString);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}
}

