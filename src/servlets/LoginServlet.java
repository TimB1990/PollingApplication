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
import models.ConfirmData;
import models.ErrorData;
import security.JWToken;
import testdata.TestIpClass;

@WebServlet(name = "loginServlet", urlPatterns = { "/login" })
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	HttpSession session;
	
    public LoginServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String content = "poll";
		request.setAttribute("Content", content);
		request.getRequestDispatcher("/index.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(true);
		
		// retrieve ip, username and password from request
		String ip = TestIpClass.TEST_IP;
		String uname = request.getParameter("uname");
		String pass = request.getParameter("pass");
		
		try {
			
			// check if login is valid, returns boolean
			Boolean valid = AppController.loginUser(ip, uname, pass);
			
			if(valid) {
				
				// if valid issue new token -> key, issuer, subject, ttlMillis
				String token = JWToken.issueJWT(ip, uname, pass, 1000 * 60 * 10);
				System.out.println(token);
				
				// put token inside sessionscope
				
				session.setAttribute("token", token);
				session.setAttribute("loggedin", true);
				session.setAttribute("user", uname);
				
				// send confirmation message
				ConfirmData confirmation = new ConfirmData(200,"OK","login successful!");
				
				// remove any previous Error messages
				session.removeAttribute("Error");
				
				// put confirmation as request attribute
				session.setAttribute("ConfirmMsg", confirmation);
					
			}
			else {
				
				// send error message
				ErrorData error = new ErrorData(401,"unauthorized","invalid login credentials!");
				
				// put error as request attribute
				session.setAttribute("Error", error);
				
				session.setAttribute("loggedin", false);
							
			}
			
		}
		catch(SQLException e) {
			
			// send error message
			ErrorData error = new ErrorData(500,"internal server error", "message: " + e.getMessage());
			
			// put error as request attribute
			session.setAttribute("Error", error);
			session.setAttribute("loggedin", false);
				
		}
		
		
		// dispatch request to index.jsp
		// request.getRequestDispatcher("/index.jsp").forward(request, response);
		response.sendRedirect("./");
			
	}
}
