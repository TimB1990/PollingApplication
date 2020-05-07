package testdata;

/*
 * This static class is used to setup test ip.
 * In production the ip will be retrieved from request, by using request.getRemoteAddr();
 * Uncomment or create new static TEST_IPs in this class.
 * */
public class Ip {
	
	/* predefined test ips */
	
	// public static final String TEST_IP = "anon.test.ip";
	
	// public static final String TEST_IP = "guest.test.ip";
	
	/*username: user, password: user*/
	public static final String TEST_IP = "user.test.ip";

}
