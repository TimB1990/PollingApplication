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
import testdata.Ip;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LogoutServlet() {
        super();
        
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// call logout user procedure
			Procedures.logoutUser(Ip.TEST_IP);
			
			// set cookie with token 'notoken'
			Cookie token = new Cookie("token", "notoken");
			
			// add cookie and redirect to frontpage
			response.addCookie(token);
			response.sendRedirect("./");
			
		}catch(SQLException e) {
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
		}

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
