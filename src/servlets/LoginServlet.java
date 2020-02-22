package servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controllers.AppController;
import models.ConfirmData;
import models.ErrorData;
import security.JWToken;
import testdata.TestIpClass;

@WebServlet(name = "loginVoteServlet", urlPatterns = { "/login", "/vote" })
public class LoginVoteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public LoginVoteServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// no doGet logic
	}
	
	/* This do post method issues an token on successful login */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(request.getRequestURI().contains("/login")) {
			
			// if valid this method will issue a token in the response authorization header
			validateLogin(request,response);
			request.getRequestDispatcher("/index").forward(request,response);		
		}
		
		if(request.getRequestURI().contains("/vote")) {
			
			String ip = TestIpClass.TEST_IP;
			String aid = request.getParameter("aid");

			
			// check if vote can be placed anonymous on forehand, the method returns voteAccepted to be true or false, when true vote is placed
			// AppController.addAnonVote(ip, qid, aid)
			
			
			
			// validate token
			Boolean hasValidToken = JWToken.validateJWT(request, TestIpClass.TEST_IP);
			
			if(hasValidToken) {
				
				
				
			}
			
		}
		
		
	}
	
	
	private void validateLogin(HttpServletRequest request, HttpServletResponse response) {
		
		Boolean validLogin = false;
		String loginRequired = request.getParameter("loginRequired");
		
		if(loginRequired != null && loginRequired.contentEquals("1")) {
			String ip = TestIpClass.TEST_IP;
			String uname = request.getParameter("uname");
			String pass = request.getParameter("pass");
			
			try {
				// call LoginUser from appController to validate login
				validLogin = AppController.loginUser(ip, uname, pass);
				if(validLogin) {
					
					// if valid login issue a token
					// public static String issueJWT(String key, String issuer, String subject, long ttlMillis)
					String token = JWToken.issueJWT(ip, uname, pass, 1000 * 20 * 60);
					response.setHeader("authorization", "Bearer " + token);
					ConfirmData confirmation = new ConfirmData(200,"OK","login successful");
					request.setAttribute("ConfirmMsg", confirmation);
				}
				else {
					
					ErrorData error = new ErrorData(401,"unauthorized", "message: invalid username or password");
					request.setAttribute("Error", error);
				}
			}
			catch(SQLException e) {
				
				ErrorData error = new ErrorData(500,"internal server error","message: " + e);
				request.setAttribute("Error", error);	
			}
		}
	}
}
