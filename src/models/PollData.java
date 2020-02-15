package models;

import java.util.List;

public class PollData {

    public Boolean showVotes;
    public Boolean loginRequiredToVote;
    public int qid;
    public int qvotes;
    public String description;
    public List<Answer> answerList;
    
	public Boolean getShowVotes() {
		return showVotes;
	}
	public void setShowVotes(Boolean showVotes) {
		this.showVotes = showVotes;
	}
	public Boolean getLoginRequiredToVote() {
		return loginRequiredToVote;
	}
	public void setLoginRequiredToVote(Boolean loginRequiredToVote) {
		this.loginRequiredToVote = loginRequiredToVote;
	}
	public int getQid() {
		return qid;
	}
	public void setQid(int qid) {
		this.qid = qid;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public List<Answer> getAnswerList() {
		return answerList;
	}
	public void setAnswerList(List<Answer> answerList) {
		this.answerList = answerList;
	}
	public int getQvotes() {
		return qvotes;
	}
	public void setQvotes(int qvotes) {
		this.qvotes = qvotes;
	}
	
    
    // generate with alt-shift-s, r
}
