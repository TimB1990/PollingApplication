package servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.Procedures;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// set currentview to login page and forward request
		request.setAttribute("CurrentView", "login");
		request.getRequestDispatcher("index.jsp").forward(request, response);

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// receive token on calling login procedure
			String receivedToken = Procedures.loginUser(request.getParameterMap());
			
			// if received token has value 'invalid' set loginerror attribute and forward request to loginpage
			if(receivedToken.contentEquals("invalid")) {
				request.setAttribute("LoginError", "invalid credentials, please try again");
				request.getRequestDispatcher("login.jsp").forward(request, response);	
			}
			else {
				// create token cookie
				Cookie tokenCookie = new Cookie("token",receivedToken);
				
				// set max age to 15 minutes
				tokenCookie.setMaxAge(60*15);
				
				// add cookie and send redirect to frontpage loading new poll
				response.addCookie(tokenCookie);
				response.sendRedirect("./");
			}
			
		}
		// catch SQL Exception
		catch(SQLException e) {
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
		}
	}

}
