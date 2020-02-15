package models;

public class VotePrivileges {
    int qid;
    Boolean showVotes;
    Boolean loginRequiredToVote;

    public int getQid() {
        return this.qid;
    }

    public void setQid(int qid) {
        this.qid = qid;
    }

    public Boolean getShowVotes() {
        return this.showVotes;
    }

    public void setShowVotes(Boolean showVotes) {
        this.showVotes = showVotes;
    }

    public Boolean getloginRequiredToVote() {
        return this.loginRequiredToVote;
    }

    public void setloginRequiredToVote(Boolean loginRequiredToVote) {
        this.loginRequiredToVote = loginRequiredToVote;
    }
}
