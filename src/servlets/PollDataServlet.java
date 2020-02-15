package servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.PollData;
import testdata.TestIpClass;
import models.ErrorData;
import controllers.AppController;

@WebServlet(name = "/poll", urlPatterns = { "/poll" })
public class PollDataServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public PollDataServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		PollData data = new PollData();
		try {
			
			data = AppController.getPollDataOnCheck(TestIpClass.TEST_IP);
			request.setAttribute("PollData", data);
			
		}catch(SQLException e) {
			ErrorData error = new ErrorData(500,"internal server error","message: " + e);
			request.setAttribute("Error", error);
		}
		
		request.getRequestDispatcher("/index.jsp").forward(request,response);
	}

}
