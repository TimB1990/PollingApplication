<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Template!</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.8.0/css/bulma.min.css">
	<script defer src="https://use.fontawesome.com/releases/v5.3.1/js/all.js"></script>
</head>

<body>
	<section class="section">
		<div class="tile is-ancestor">
			<div class="tile is-6 is-vertical is-parent">
				<div class="tile is-child">
					<div class="notification is-danger">
						<em>Invalid credentials provided!!</em>
					</div>
					<div class="notification is-success">
						<p>
							<em> Welcome {user} you have been successfully logged in.
								If you want to see the questions you voted on, click <a>here</a>
								to open your dashboard.
							</em>
						</p>
					</div>
				</div>
				<div class="tile is-child box">
					<code>${PollData.showVotes eq false and not empty loggedin}</code>
					<form>
						<p class="title">What is your favorite color?</p>
						<div class="control">
							<label class="radio">
								<input type="radio" name="answer">
								<span class="subtitle is-6"> Red</span>
							</label><br>
							<label class="radio">
								<input type="radio" name="answer" />
								<span class="subtitle is-6"> Green</span>
							</label><br>
							<label class="radio">
								<input type="radio" name="answer" />
								<span class="subtitle is-6"> Blue</span>
							</label><br>
							<label class="radio">
								<input type="radio" name="answer" />
								<span class="subtitle is-6"> Purple</span>
							</label>
						</div><br>
						<div class="field">
							<button type="submit" class="button is-link">Vote</button>
						</div>
					</form>
				</div>
				<div class="tile is-child box">
					<code>${ PollData.showVotes eq false 
						and PollData.loginRequiredToVote eq true 
						and not empty loggedin }
					</code>
					<form>
						<p class="title">What is your favorite color?</p>
						<div class="control">
							<label class="radio">
								<input type="radio" name="answer">
								<span class="subtitle is-6"> Red</span>
							</label><br>
							<label class="radio">
								<input type="radio" name="answer" />
								<span class="subtitle is-6"> Green</span>
							</label><br>
							<label class="radio">
								<input type="radio" name="answer" />
								<span class="subtitle is-6"> Blue</span>
							</label><br>
							<label class="radio">
								<input type="radio" name="answer" />
								<span class="subtitle is-6"> Purple</span>
							</label>
						</div><br>
						<div class="field">
							<button type="submit" class="button is-static">Vote</button>
						</div>
					</form>
					<br>
					<div class="notification box">
						<em>
							Your login session has been expired, if you want to
							continue voting please <a>login</a> again.
						</em>
					</div>
				</div>
				<div class="tile is-child box">
					<code>${PollData.showVotes eq true and empty loggedin}</code>
					<p class="title">What is your favorite color?</p>
					<div class="box">
						<span class="subtitle is-6">Red:</span>
						<progress class="progress is-medium" value="25" max="100">15%</progress>
						<span class="subtitle is-6">Green: </span>
						<progress class="progress is-medium" value="25" max="100">30%</progress>
						<span class="subtitle is-6">Blue: </span>
						<progress class="progress is-medium" value="25" max="100">30%</progress>
						<span class="subtitle is-6">Purple: </span>
						<progress class="progress is-medium" value="25" max="100">30%</progress>
					</div>
					<div class="notification box">
						<em>
							This IP-address has already voted anonymous at
							this question. If you want to continue voting, please 
							<a>login </a> or <a>register</a> as new user.
						</em>
					</div>

				</div>
				<div class="tile is-child box">
					<p class="title">Login</p>
					<form>
						<div class="field">
							<label class="label">username</label>
							<div class="control has-icons-left">
								<input class="input" type="text" placeholder="username" required />
								<span class="icon is-small is-left">
									<i class="fas fa-user"></i>
								</span>
							</div>
							<p class="help is-danger">on_error_message</p>
						</div>
						<div class="field">
							<label class="label">password</label>
							<div class="control has-icons-left">
								<input class="input" type="password" placeholder="password" required />
								<span class="icon is-small is-left">
									<i class="fas fa-key" arie-hidden="true"></i>
								</span>
							</div>
							<p class="help is-danger">on_error_message</p>
						</div>
						<div class="field">
							<button type="submit" class="button is-link">login as user</button>
						</div>
					</form>
				</div>
				<div class="tile is-child box">
					<p class="title">Register</p>
					<form>
						<div class="field">
							<label class="label">Username:</label>
							<div class="control has-icons-left">
								<input class="input" type="text" placeholder="username" required />
								<span class="icon is-small is-left">
									<i class="fas fa-user"></i>
								</span>
							</div>
							<p class="help is-danger">on_error_message</p>
						</div>
						<div class="field">
							<label class="label">Password:</label>
							<div class="control has-icons-left">
								<input class="input" type="password" placeholder="password" required />
								<span class="icon is-small is-left">
									<i class="fas fa-key" arie-hidden="true"></i>
								</span>
							</div>
						</div>
						<div class="field">
							<label class="label">Repeat Password:</label>
							<div class="control has-icons-left">
								<input class="input" type="password" placeholder="password" required />
								<span class="icon is-small is-left">
									<i class="fas fa-key" arie-hidden="true"></i>
								</span>
							</div>
							<p class="help is-danger">on_error_message</p>
						</div>
						<div class="field">
							<button type="submit" class="button is-link">Register New User</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
</body>
</html>