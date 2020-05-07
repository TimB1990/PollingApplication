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
		request.setAttribute("CurrentView", "login");
		request.getRequestDispatcher("index.jsp").forward(request, response);

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String receivedToken = Procedures.loginUser(request.getParameterMap());
			if(receivedToken.contentEquals("invalid")) {
				request.setAttribute("LoginError", "invalid credentials, please try again");
				request.getRequestDispatcher("login.jsp").forward(request, response);	
			}
			else {
				// create token cookie
				Cookie tokenCookie = new Cookie("token",receivedToken);
				tokenCookie.setMaxAge(60*15);
				response.addCookie(tokenCookie);
				response.sendRedirect("./");
			}
			
		}catch(SQLException e) {
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
		}
	}

}
