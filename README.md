# PollingApplication
fictional
## Installation
<ol>
  <li> Make sure you are on branch: V2, master is deprecated </li>
  <li> clone or download V2 respository: <code>https://github.com/TimB1990/PollingApplication.git</code></li>
  <li> Open mysql CLI: <code>CREATE DATABASE polling_v2</code></li>
  <li> Import database.sql file using <code>mysql -u username -p polling_v2 < #\pollingApplication\database\v2\database.sql</code></li>
  <li> Open folder: <code>#\pollingApplication\database\database workspace</code> inside your IDE and copy/paste contents from grants.sql file into MySQL CLI </li>
	<li> Open project in Eclipse IDE, right click 'PollingApplication' in Project Explorer, click 'Run As' > 'Run on Server' to deploy application to Tomcat</li>
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
When the client registres as user he is required to login afterwards. When logged in, The client is allowed to vote a random unanswered poll untill there are no polls left.

## time log
On behalve of LOI a timelog of tasks (dutch)
logboek programmeren 2
<code>
6-1-2020: installatie beschrijving
7-1-2020: algemene orientatie
8-1-2020: orientatie op mogelijk gebruik spring mvc
8-1-2020: orientatie jax-rs
8-1-2020: beschrijving functionele requirements en security
9-1-2020: orientatie op front-end solution - ofwel javascript/axios/jquery
10-1-2020: informatie opzoeken voor implementatie JSON webtoken voor JAVA
11-1-2020: technische uitwerking en aanmaken database, stored procedures
12-1-2020: implementatie stored procedures
13-1-2020: implementatie stored procedures, orientatie java mysql connection pooling.
14-1-2020: Technische beschrijving voor authenticatie, 
15-1-2020: Technische omschrijving encryptie algoritmen, implementatie algoritmen in stored procedures
16-1-2020: implementatie encryptie algortimen in stored procedures
17-1-2020: implementatie encryptie algortimen in stored procedures
18-1-2020: testen stored procedure met encryptiealogritmen.
19-1-2020: testen stored procedures en herschrijven procedures: LoginUser, EncryptAidsAgain
20-1-2020: orientatie front-end en design voorbeeld (BS4)
20-1-2020: ontwerp API.
21-1-2020: ontwerp API, implementatie stored procedure voor ophalen beantwoorde vragen.
22-1-2020: implementatie stored procedure voor ophalen beantwoorde vragen
23-1-2020: implementatie stored procedure voor CheckVotingPrivileges
24-1-2020: implementatie stored procedure voor CheckVotingPrivileges
25-1-2020: implementatie stored procedures en tests
26-1-2020: maken verslag database description
27-1-2020: voorbereiding en orientatie applicatie back-end java.
28-1-2020: backend ontwikkeling
29-1-2020: backend ontwikkeling
30-1-2020: backend + test frontend ontwikkeling
31-1-2020: backend JWtoken implementation..
1-2-2020: back-end + frontend ontwikkeling
2-2-2020: implementatie vote en login
3-2-2020: ontwikkeling
4-2-2020: ontwikkeling
5-2-2020: ontwikkeling
15-2-2020: ontwikkeling java servlets
22-02-2020: ontwikkeling java servlets
16-03-2020: refactoring frontend
04-04-2020: refactoring frontend, fixing db bugs
05-04-2020: refactoring frontend, fixing db bugs
06-04-2020: fixing db procedure bugs
07-04-2020: fixing db procedure bugs
19-04-2020: voorbereidingen db v2 i.v.m. overkill
20-04-2020: ontwerp db v2
21-04-2020: ontwerp db v2 procedures
28-04-2020: ontwikkeling v2 java 
29-04-2020: ontwikkeling v2 java
06-05-2020: ontwikkeling v2 java
07-05-2020: afronding ontwikkeling v2 java en testrapport
	</code>
