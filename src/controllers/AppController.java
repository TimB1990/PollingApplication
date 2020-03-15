package controllers;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import models.Answer;
import models.PollData;
import pollDatabase.DBCPDataSource;

public class AppController {

	public static Map<String, Object> getPollDataOnCheck(String ip) throws SQLException {

		Map<String, Object> pollDataMap = new HashMap<String, Object>();

		PollData data = new PollData();

		Map<String, Object> privileges = getVotePrivileges(ip);

		List<Answer> answerList = new ArrayList<>();

		// if map polldata does not contain empty key
		if ((Integer) privileges.get("qid") != 0) {

			// retrieve resultset from GetPollData procedure
			Connection con = DBCPDataSource.getConnection();
			CallableStatement cStmt = con.prepareCall("{call GetPollData(?,?)}");

			cStmt.setInt(1, (Integer) privileges.get("qid"));
			cStmt.setBoolean(2, (Boolean) privileges.get("showVotes"));

			cStmt.execute();
			ResultSet rs = cStmt.getResultSet();

			// go to first row to retrieve showVotes, qid, description and qvotes
			rs.first();

			// retrieve fields and assign their values to PollData'
			data.setShowVotes(rs.getBoolean("showVotes"));
			data.setQid(rs.getInt("qid"));
			data.setDescription(rs.getString("description"));
			data.setQvotes(rs.getInt("qvotes"));

			//// go to before first, next loop through resultset from start
			rs.beforeFirst();

			while (rs.next()) {
				// populate answerlist
				Answer answer = new Answer();
				answer.setAid(rs.getString("aid"));
				answer.setValue(rs.getString("value"));
				answer.setAvotes(rs.getInt("avotes"));
				answerList.add(answer);
			}
			
			data.setLoginRequiredToVote((Boolean) privileges.get("loginRequiredToVote"));
			data.setAnswerList(answerList);

			// put PollData object in pollDataMap having key 'data'
			pollDataMap.put("data", data);
		}
		else {
			// if qid is 0
			pollDataMap.put("data", "none");
		}

		return pollDataMap;

	}

	/* This method returns check voting data */
	private static Map<String, Object> getVotePrivileges(String ip) throws SQLException {

		Map<String, Object> priv = new HashMap<String, Object>();

		Connection con = DBCPDataSource.getConnection();
		CallableStatement cStmt = con.prepareCall("{call CheckVotePrivileges(?)}");
		cStmt.setString(1, ip);

		cStmt.execute();
		ResultSet rs = cStmt.getResultSet();
		
		rs.first();
		
		priv.put("qid", rs.getInt("qid"));
		priv.put("showVotes", rs.getBoolean("showVotes"));
		priv.put("loginRequiredToVote", rs.getBoolean("loginRequiredToVote"));
		
		con.close();
		return priv;
	}

	public static Boolean loginUser(String ip, String uname, String pass) throws SQLException {

		Boolean validLogin = false;
		Connection con = DBCPDataSource.getConnection();

		CallableStatement cStmt = con.prepareCall("{call LoginUser(?,?,?)}");
		cStmt.setString(1, ip);
		cStmt.setString(2, uname);
		cStmt.setString(3, pass);

		ResultSet rs = cStmt.executeQuery();

		if (rs.next()) {

			validLogin = rs.getBoolean(1);
		}

		con.close();

		return validLogin;

	}

	public static void LogoutUser(String ip) throws SQLException {
		Connection con = DBCPDataSource.getConnection();
		CallableStatement cStmt = con.prepareCall("{call logoutUser(?}");
		cStmt.setString(1, ip);
		cStmt.executeUpdate();
		con.close();

	}

	public static Boolean addAnonVote(String ip, int qid, String aid) throws SQLException {

		Boolean voteAccepted = false;
		Connection con = DBCPDataSource.getConnection();
		CallableStatement cStmt = con.prepareCall("{call AddAnonVote(?,?,?)}");
		cStmt.setString(1, ip);
		cStmt.setInt(2, qid);
		cStmt.setString(3, aid);

		ResultSet rs = cStmt.executeQuery();

		if (rs.next()) {

			voteAccepted = rs.getBoolean(1);
		}

		con.close();

		return voteAccepted;
	}

	public static void addNewVote(String ip, String uname, int qid, String aid) throws SQLException {

		Connection con = DBCPDataSource.getConnection();
		CallableStatement cStmt = con.prepareCall("{call AddNewVote(?,?,?,?)}");
		cStmt.setString(1, ip);
		cStmt.setString(2, uname);
		cStmt.setInt(3, qid);
		cStmt.setString(4, aid);

		cStmt.executeUpdate();

		con.close();

	}
}
