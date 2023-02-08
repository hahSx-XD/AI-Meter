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

@WebServlet("/logClear")

public class LogServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	DataDriverDao dsDataDriver = new DataDriverDao();

	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MapReduceService mapReduceService = new MapReduceService();
		String id = request.getParameter("id");//≤‚ ‘id
		String threshold = request.getParameter("threshold");//…∏—°µƒ„–÷µ
		try {
			String dataString = mapReduceService.logClear(id, threshold);
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

