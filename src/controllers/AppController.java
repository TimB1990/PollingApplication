package controllers;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import models.Answer;
import models.PollData;
import pollDatabase.DBCPDataSource;


public class AppController {

    public static PollData getPollDataOnCheck(String ip) throws SQLException {

        PollData pollData = new PollData();
        List<Answer> answerList = new ArrayList<>();

        // retrieve resultset from check vote privileges procedure
        Connection con = DBCPDataSource.getConnection();
        CallableStatement cStmt = con.prepareCall("{call CheckVotePrivileges(?)}");
        cStmt.setString(1,ip);
        ResultSet rs = cStmt.executeQuery();
        
        rs.first();
        
        pollData.setQid(rs.getInt("qid"));
        pollData.setShowVotes(rs.getBoolean("showVotes"));
        pollData.setLoginRequiredToVote(rs.getBoolean("loginRequiredToVote"));
        
        // retrieve resultset from GetPollData
        CallableStatement cStmt2 = con.prepareCall("{call GetPollData(?,?)}");
        cStmt2.setInt(1,pollData.getQid());
        cStmt2.setBoolean(2,pollData.getShowVotes());
        ResultSet rs2 = cStmt2.executeQuery();
        
        rs2.first();
        pollData.setDescription(rs2.getString("description"));
        pollData.setQvotes(rs2.getInt("qvotes"));
        rs2.beforeFirst();
        
        while(rs2.next()) {
        	Answer answer = new Answer();
        	answer.setAid(rs2.getString("aid"));
        	answer.setValue(rs2.getString("value"));
        	answer.setAvotes(rs2.getInt("avotes"));
        	answerList.add(answer);	
        }
         
        pollData.setAnswerList(answerList);
        
        con.close();
        
        return pollData;
    }
    
    public static Boolean loginUser(String ip, String uname, String pass) throws SQLException {
    	
    	Boolean validLogin = false;
        Connection con = DBCPDataSource.getConnection();
        
        CallableStatement cStmt = con.prepareCall("{call LoginUser(?,?,?)}");
        cStmt.setString(1, ip);
        cStmt.setString(2, uname);
        cStmt.setString(3, pass);
        
        ResultSet rs = cStmt.executeQuery();
        
        if(rs.next()) {
        	
        	validLogin = rs.getBoolean(1);
        }
        
        con.close();
        
        return validLogin;
        
    }
    
    public static Boolean addAnonVote(String ip, int qid, String aid) throws SQLException {
    	
    	Boolean voteAccepted = false;
    	Connection con = DBCPDataSource.getConnection();
    	CallableStatement cStmt = con.prepareCall("{call AddAnonVote(?,?,?)}");
    	cStmt.setString(1, ip);
    	cStmt.setInt(2, qid);
    	cStmt.setString(3, aid);
    	
    	ResultSet rs = cStmt.executeQuery();
    	
    	if(rs.next()) {
    		
    		voteAccepted = rs.getBoolean(1);
    	}
    	
    	con.close();
    	
    	return voteAccepted;
    }
    
    public static void addNewVote(String ip, String uname, int qid, String aid) throws SQLException {
    	
    	Connection con = DBCPDataSource.getConnection();
    	CallableStatement cStmt = con.prepareCall("{call AddNewVote(?,?,?,?)}");
    	cStmt.setString(1,ip);
    	cStmt.setString(2, uname);
    	cStmt.setInt(3, qid);
    	cStmt.setString(4, aid);
    	
    	cStmt.executeUpdate();
    	
    	con.close();
    	
    }
}
