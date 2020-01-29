package controllers;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import database.DBCPDataSource;
import models.Answer;
import models.PollData;

public class AppController {

    public static PollData getPollDataOnCheck(String ip) throws SQLException {

        PollData pollData = new PollData();
        List<Answer> answerList = new ArrayList<>();

        // retrieve resultset from check vote privileges procedure
        Connection con = DBCPDataSource.getConnection();
        CallableStatement cStmt = con.prepareCall("{call CheckVotePrivileges(?)}");
        cStmt.setString(1,ip);
        ResultSet rs = cStmt.executeQuery();

        if(rs.first()){

            int qid = rs.getInt(1);
            Boolean showVotes = rs.getBoolean(2);
            Boolean loginRequiredToVote = rs.getBoolean(3);

            pollData.setQid(qid);
            pollData.setShowVotes(showVotes);
            pollData.setLoginRequiredToVote(loginRequiredToVote);
            
            // retrieve resultset from get poll data (resultset.first on showvotes and qid )
            CallableStatement cStmt2 = con.prepareCall("{call GetPollData(?,?)}");
            cStmt2.setInt(1,qid);
            cStmt2.setBoolean(2,showVotes);
            ResultSet rs2 = cStmt2.executeQuery();

            if(rs2.next()){

                String description = rs.getString(3);
                pollData.setDescription(description);
            }

            while(rs2.next()){
                
                Answer answer = new Answer();
                answer.setAid(rs2.getString("aid"));
                answer.setValue(rs2.getString("value"));
                answer.setAvotes(rs2.getInt("avotes"));
                answerList.add(answer);
            }

            Answer[]answerArray = (Answer[]) answerList.toArray();
            pollData.setAnswerArray(answerArray);
        }   

        return pollData;
    }
}