package servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controllers.AppController;
import testdata.TestIpClass;

@WebServlet(name = "logoutServlet", urlPatterns = { "/logout" })
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LogoutServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
		Boolean loggedin = (Boolean) session.getAttribute("loggedin");
		loggedin = false;
		session.setAttribute("loggedin", loggedin);
		
		try {
			AppController.LogoutUser(TestIpClass.TEST_IP);
		}
		catch(SQLException e) {
			
			// set loggedin to false indeed
			session.setAttribute("loggedin", false);
			session.removeAttribute("Error");
		}
		
		response.sendRedirect("./");
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
