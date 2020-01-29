package models;

public class ErrorData{

    int status;
    String statusText;
    String message;

    public ErrorData(int status, String statusText, String message){
        this.status = status;
        this.statusText = statusText;
        this.message = message;
    }

    public int getStatus() {
        return this.status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getStatusText() {
        return this.statusText;
    }

    public void setStatusText(String statusText) {
        this.statusText = statusText;
    }

    public String getMessage() {
        return this.message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}