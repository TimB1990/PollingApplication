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

/**
 * Servlet implementation class VotingServlet
 */
@WebServlet(name = "votingServlet", urlPatterns = { "/vote" })
public class VotingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public VotingServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// retrieve current session
		HttpSession session = request.getSession(false);

		// check if user is loggedin
		Boolean loggedin = (Boolean) session.getAttribute("loggedin");

		// get parameters for anonymous vote
		String ip = TestIpClass.TEST_IP;
		int qid = Integer.parseInt(request.getParameter("qid")); // is not implemented in frontline yet
		String aid = request.getParameter("answer");

		if (loggedin == null || !loggedin) {

			// call procedure to cast anonymous vote
			try {

				// place anon vote
				AppController.addAnonVote(ip, qid, aid);

				// put confirm message
				ConfirmData confirmation = new ConfirmData(201, "created",
						"This is the only vote allowed for this device, login to continue voting!");

				// put confirmation as session attribute
				session.setAttribute("ConfirmMsg", confirmation);

				response.sendRedirect("./");

			} catch (SQLException e) {

				// send error message
				ErrorData error = new ErrorData(500, "internal server error", "message: " + e.getMessage());

				// put error as session attribute
				session.setAttribute("Error", error);

				response.sendRedirect("./");

			}

		}
		// end if !loggedin
		else {

			// if loggedin check for valid token
			Boolean validToken = JWToken.validateJWT((String) session.getAttribute("token"), ip);

			if (validToken) {

				// get user from session
				String user = (String) request.getSession(false).getAttribute("user");

				try {

					// add new vote
					AppController.addNewVote(ip, user, qid, aid);

					// create confirm data object
					ConfirmData confirmation = new ConfirmData(201, "created", "your vote has been added!");

					// put confirmation as request attribute
					session.setAttribute("ConfirmMsg", confirmation);

					// redirect to root
					response.sendRedirect("./");

				} catch (SQLException e) {

					// send error message
					ErrorData error = new ErrorData(500, "internal server error", "message: " + e.getMessage());

					// put error as request attribute
					session.setAttribute("Error", error);

					// redirect to root
					response.sendRedirect("./");
				}
				
			}
			// end if validToken

			else {

				// send error message
				ErrorData error = new ErrorData(401, "unauthorized", "invalid token, please login");

				// put error as request attribute
				session.setAttribute("Error", error);

				// redirect to root
				response.sendRedirect("./");

			}
		}
	}
}
