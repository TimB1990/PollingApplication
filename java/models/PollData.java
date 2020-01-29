package models;
public class PollData {

    Boolean showVotes;
    Boolean loginRequiredToVote;

    public Boolean getLoginRequiredToVote() {
        return this.loginRequiredToVote;
    }

    public void setLoginRequiredToVote(Boolean loginRequiredToVote) {
        this.loginRequiredToVote = loginRequiredToVote;
    }

    int qid;
    String description;
    Answer[] answerArray;

    public Answer[] getAnswerArray() {
        return this.answerArray;
    }

    public void setAnswerArray(Answer[] answerArray) {
        this.answerArray = answerArray;
    }

    public Boolean getShowVotes() {
        return this.showVotes;
    }

    public void setShowVotes(Boolean showVotes) {
        this.showVotes = showVotes;
    }

    public int getQid() {
        return this.qid;
    }

    public void setQid(int qid) {
        this.qid = qid;
    }

    public String getDescription() {
        return this.description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}