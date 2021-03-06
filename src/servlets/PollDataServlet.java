package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import testdata.TestIpClass;
import models.ErrorData;
import controllers.AppController;

@WebServlet(name = "polldata", urlPatterns = { "" })
public class PollDataServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public PollDataServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		Map<String,Object> data = new HashMap<String,Object>();
		
		try {
			
			data = AppController.getPollDataOnCheck(TestIpClass.TEST_IP);
			session.setAttribute("TestIp", TestIpClass.TEST_IP);
			request.setAttribute("PollData", data);

		} catch (SQLException e) {
			ErrorData error = new ErrorData(500, "internal server error", "message: " + e);
			session.setAttribute("Error", error);
		}

		// forward to index.jsp
		request.getRequestDispatcher("index.jsp").forward(request, response);

	}

}
