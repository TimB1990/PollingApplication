package servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.PollData;
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

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// login is not possible because the test ip stays, while in the procedure it is changed when user logs in on a account	
		PollData data = new PollData();
		try {
			
			data = AppController.getPollDataOnCheck(TestIpClass.TEST_IP);
			
			HttpSession session = request.getSession();
			session.setAttribute("PollData", data);
			
		}catch(SQLException e) {
			ErrorData error = new ErrorData(500,"internal server error","message: " + e);
			request.setAttribute("Error", error);
		}
		

		// forward to index.jsp
		request.getRequestDispatcher("/index.jsp").forward(request,response);
		
		
	}

}
