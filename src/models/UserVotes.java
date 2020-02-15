package models;
public class UserVotes {

    int qid;
    String description;
    String aid;
    String value;
    int avotes;
    Boolean voted;
    Double share;

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

    public String getAid() {
        return this.aid;
    }

    public void setAid(String aid) {
        this.aid = aid;
    }

    public String getValue() {
        return this.value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public int getAvotes() {
        return this.avotes;
    }

    public void setAvotes(int avotes) {
        this.avotes = avotes;
    }

    public Boolean getVoted() {
        return this.voted;
    }

    public void setVoted(Boolean voted) {
        this.voted = voted;
    }

    public Double getShare() {
        return this.share;
    }

    public void setShare(Double share) {
        this.share = share;
    }
}
