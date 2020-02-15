package models;

public class ConfirmData {
	
    public int status;
    public String statusText;
    public String message;
    
    public ConfirmData(int status, String statusText, String message) {
    	this.status = status;
    	this.statusText = statusText;
    	this.message = message;
    }

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getStatusText() {
		return statusText;
	}

	public void setStatusText(String statusText) {
		this.statusText = statusText;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
    
}
