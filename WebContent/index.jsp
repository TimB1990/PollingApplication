<%@ taglib
	uri="http://java.sun.com/jstl/core_rt"
	prefix="c"
%>
<%@ taglib
	prefix="fmt"
	uri="http://java.sun.com/jsp/jstl/fmt"
%>
<html>

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>index</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.8.0/css/bulma.min.css">
	<link rel="stylesheet" href="css/styling.css">

	<script defer src="https://use.fontawesome.com/releases/v5.3.1/js/all.js"></script>
</head>

<body>
	<section class="section">
		<div class="tile is-ancestor">
			<div class="tile is-6 is-vertical is-parent">

				<c:if test="${ loggedin eq false and not empty Error }">
					<div class="notification is-danger is-light">
						<p>${Error.status}${Error.statusText}${ Error.message }</p>
					</div>
				</c:if>

				<!-- when logged in status true -->
				<c:if test="${ loggedin eq true and not empty ConfirmMsg}">
					<div class="notification is-success">
						<p>
							<strong>confirmation: </strong> <span>${ConfirmMsg.status},
								${ConfirmMsg.statusText}, ${ConfirmMsg.message}</span>
						</p>

						<p>
							Welcome back <strong>${ user }!</strong>. If you want to see
							which questions you voted on visit your <a>dashboard</a>
						</p>
					</div>
				</c:if>

				<!-- poll display, data could be string or could be PollData -->
				<c:set var="data" value="${PollData.data}" />
				<c:choose>
					<c:when test="${data eq 'none'}">
						<p>There are no questions left, stay tuned!</p>
					</c:when>
					<c:otherwise>
						<!-- polldata is data -->
						<div class="poll-container">
							<p>${data.description}</p>
							<form id="vote-form" method="POST" action="./vote">
								<div>
									<input type="hidden" name="qid" value="${data.qid}">
								</div>

								<c:forEach var="answer" items="${data.answerList}">
									<div class="poll-answer">
										<span>${answer.value}</span>
										<c:if test="${data.showVotes eq false}">
											<input type="radio" name="answer" id="${answer.aid}" value="${answer.aid}">
										</c:if>
										<c:if test="${data.showVotes eq true}">
											<meter value="${answer.avotes}" min="0" max="${data.qvotes}"></meter>
											<span>${answer.avotes} of ${PollData['data'].qvotes}</span>
										</c:if>
									</div>
								</c:forEach>
								<div class="button-panel">
									<c:if test="${data.loginRequiredToVote eq true or data.showVotes eq true}">
										<button type="submit" disabled>Vote</button>
									</c:if>
									<c:if test="${data.loginRequiredToVote eq false and data.showVotes eq false}">
										<button type="submit" onclick="submitVote()">Vote</button>
									</c:if>
									<div>
										<c:if test="${data.showVotes eq false and data.loginRequiredToVote eq false and empty loggedin }">
											<p>You are about to vote as anonymous, remember this is the only vote allowed from this machine
											</p>
										</c:if>
										<c:if test="${data.showVotes eq true}">
											<p>You allready casted an anonymous vote for this question, please login or register to continue
											</p>
										</c:if>
										<c:if test="${data.loginRequiredToVote eq true}">
											<p>You must be loggedin to vote</p>
										</c:if>
									</div>
								</div>
							</form>
						</div>

					</c:otherwise>
				</c:choose>


				<!-- login form -->
				<div id="login-modal" class="modal">
					<div class="modal-background"></div>
					<div class="modal-content box">
						<span class="title">Login</span>
						<button id="close-login" style="float: right;" class="button close is-small" aria-label="close">
							<i class="fas fa-times"></i>
						</button>
						<form id="login-form" method="post" action="./login">
							<div class="field">
								<label class="label">username</label>
								<div class="control has-icons-left">
									<input class="input" type="text" name="uname" placeholder="username" required /> <span
										class="icon is-small is-left"> <i class="fas fa-user"></i>
									</span>
								</div>
							</div>
							<div class="field">
								<label class="label">password</label>
								<div class="control has-icons-left">
									<input class="input" type="password" placeholder="password" name="pass" required /> <span
										class="icon is-small is-left"> <i class="fas fa-key" aria-hidden="true"></i>
									</span>
								</div>
							</div>
							<div class="field">
								<button type="button" class="button is-link" onclick="submitLogin()">login as user</button>
							</div>
						</form>
					</div>
				</div>

				<!-- registration form -->
				<div id="register-modal" class="modal">
					<div class="modal-background"></div>
					<div class="modal-content box">
						<span class="title">Register</span>
						<button id="close-register" style="float: right;" class="button close is-small" aria-label="close">
							<i class="fas fa-times"></i>
						</button>
						<form>
							<div class="field">
								<label class="label">Username:</label>
								<div class="control has-icons-left">
									<input class="input" type="text" placeholder="username" required /> <span
										class="icon is-small is-left"> <i class="fas fa-user"></i>
									</span>
								</div>
								<p class="help is-danger">on_error_message</p>
							</div>
							<div class="field">
								<label class="label">Password:</label>
								<div class="control has-icons-left">
									<input class="input" type="password" placeholder="password" required /> <span
										class="icon is-small is-left"> <i class="fas fa-key" aria-hidden="true"></i>
									</span>
								</div>
							</div>
							<div class="field">
								<label class="label">Repeat Password:</label>
								<div class="control has-icons-left">
									<input class="input" type="password" placeholder="password" required /> <span
										class="icon is-small is-left"> <i class="fas fa-key" aria-hidden="true"></i>
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
		</div>
		<p>loggedin: ${ sessionScope.loggedin }</p>

		<c:choose>
			<c:when test="${ loggedin eq true }">
				<a href="./logout">logout</a>
			</c:when>
			<c:otherwise>
				<a class="login-link">login</a>
				or <a class="register-link">register</a>

			</c:otherwise>
		</c:choose>

		<p><strong>${sessionScope.TestIp}</strong></p>

	</section>
	<script src="modals.js"></script>
	<script src="login.js"></script>
	<script src="vote.js"></script>
</body>

</html>