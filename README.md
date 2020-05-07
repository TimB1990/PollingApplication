# PollingApplication
fictional
## Installation
<ol>
  <li> Make sure you are on branch: V2, master is deprecated </li>
  <li> clone or download V2 respository: <code>https://github.com/TimB1990/PollingApplication.git</code></li>
  <li> Open mysql CLI: <code>CREATE DATABASE polling_v2</code></li>
  <li> Import database.sql file using <code>mysql -u username -p polling_v2 < #\pollingApplication\database\v2\database.sql</code></li>
  <li> Open folder: <code>#\pollingApplication\database\database workspace</code> inside your IDE and copy/paste contents from grants.sql file into MySQL CLI </li>
</ol>

## Testing
This application is in development stage. The application uses the user's ip to determine what content is shown.
For testing purposes a java class named <code>Ip.java</code> is used to determine which fictional ip is used to perform the application's logic.
This class looks like this:

```bash
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
```

Only one IP a time can be used. Therefore you can uncomment the ip you want to use, or add a new test ip using: <code>public static final String TEST_IP = "new.test.ip"</code>
For production the ip should be retrieved from request: <code>HttpServletRequest request = request.getRemoteAddr();</code> 
Notice that this part requires refactoring.

## Business Logic
On startup this application retrieves a random poll when client is 'anonymous'. The client is then allowed to vote once.
After the client voted anonymous its role will be changed to 'guest', this means that the application requires the client to register and user and will display the results of last answered question.
When the client registres as user he must is required to login afterwards. When loggedin, The client is allowed to vote a random unanswered poll untill there are no polls left.
