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
<meta
	name="viewport"
	content="width=device-width, initial-scale=1"
>
<title>index</title>
<link
	rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bulma@0.8.0/css/bulma.min.css"
>
<script
	defer
	src="https://use.fontawesome.com/releases/v5.3.1/js/all.js"
></script>
</head>
<body>
	<section class="section">
		<div class="tile is-ancestor">
			<div class="tile is-6 is-vertical is-parent">

				<!-- if user has not registered or voted anonymous -->
				<c:if
					test="${PollData.showVotes eq false and PollData.loginRequiredToVote eq false and empty loggedin or loggedin eq true }"
				>
					<div class="tile is-child box">
						<form>
							<p class="title">${PollData.description}</p>
							<c:forEach
								var="answer"
								items="${ PollData.answerList }"
							>
								<div class="control">
									<label class="radio"> <input
										type="radio"
										name="answer"
									> <span class="subtitle is-6">${ answer.value }</span>
									</label> <br>
								</div>
							</c:forEach>
							<br>
							<div class="field">
								<button
									type="submit"
									class="button is-link"
								>Vote</button>
							</div>
						</form>
					</div>
				</c:if>

				<!--  disable voting  -->
				<c:if
					test="${ PollData.showVotes eq false and PollData.loginRequiredToVote eq true and loggedin eq false}"
				>
					<div class="tile is-child box">
						<form>
							<p class="title">${ PollData.description }</p>
							<c:forEach
								var="answer"
								items="${ PollData.answerList }"
							>
								<div class="control">
									<label class="radio"> <input
										type="radio"
										name="answer"
									> <span class="subtitle is-6">${ answer.value }</span>
									</label> <br>
								</div>
							</c:forEach>
							<br>
							<div class="field">
								<button
									type="submit"
									class="button is-static"
								>Vote</button>
							</div>
						</form>
						<br>
						<div class="notification box">
							<em> Your login session has been expired, if you want to
								continue voting please <a class="login-link">login</a> again.
							</em>
						</div>
					</div>
				</c:if>

				<!-- show votes -->
				<c:if test="${PollData.showVotes eq true }">
					<div class="tile is-child box">
						<p class="title">${PollData.description}</p>
						<div class="box">
							<c:forEach
								var="answer"
								items="${ PollData.answerList }"
							>
								<span class="subtitle is-6"> ${ answer.value }: </span>
								<!-- ${(answer.avotes / PollData.qvotes) * 100 } %  -->
								<span style="float: right;">${ answer.avotes } / ${ PollData.qvotes }</span>
								<progress
									class="progress is-medium"
									value="${ answer.avotes }"
									max="${ PollData.qvotes }"
								> text </progress>
								<br>
							</c:forEach>
						</div>

						<div class="notification box">
							<em> This IP-address has already voted anonymous at this
								question. If you want to continue voting, please <a
								class="login-link"
							>login</a> or <a class="register-link">register</a> as new user.
							</em>
						</div>
					</div>
				</c:if>

				<!-- login form -->
				<div
					id="login-modal"
					class="modal"
				>
					<div class="modal-background"></div>
					<div class="modal-content box">
						<span class="title">Login</span>
						<button
							id="close-login"
							style="float: right;"
							class="button close is-small"
							aria-label="close"
						>
							<i class="fas fa-times"></i>
						</button>
						<form
							id="login-form"
							method="post"
							action="./login"
						>
							<div class="field">
								<label class="label">username</label>
								<div class="control has-icons-left">
									<input
										class="input"
										type="text"
										name="uname"
										placeholder="username"
										required
									/> <span class="icon is-small is-left"> <i
										class="fas fa-user"
									></i>
									</span>
								</div>
							</div>
							<div class="field">
								<label class="label">password</label>
								<div class="control has-icons-left">
									<input
										class="input"
										type="password"
										placeholder="password"
										name="pass"
										required
									/> <span class="icon is-small is-left"> <i
										class="fas fa-key"
										aria-hidden="true"
									></i>
									</span>
								</div>
							</div>
							<div class="field">
								<button
									type="button"
									class="button is-link"
									onclick="submit()"
								>login as user</button>
							</div>
						</form>
					</div>
				</div>

				<!-- registration form -->
				<div
					id="register-modal"
					class="modal"
				>
					<div class="modal-background"></div>
					<div class="modal-content box">
						<span class="title">Register</span>
						<button
							id="close-register"
							style="float: right;"
							class="button close is-small"
							aria-label="close"
						>
							<i class="fas fa-times"></i>
						</button>
						<form>
							<div class="field">
								<label class="label">Username:</label>
								<div class="control has-icons-left">
									<input
										class="input"
										type="text"
										placeholder="username"
										required
									/> <span class="icon is-small is-left"> <i
										class="fas fa-user"
									></i>
									</span>
								</div>
								<p class="help is-danger">on_error_message</p>
							</div>
							<div class="field">
								<label class="label">Password:</label>
								<div class="control has-icons-left">
									<input
										class="input"
										type="password"
										placeholder="password"
										required
									/> <span class="icon is-small is-left"> <i
										class="fas fa-key"
										aria-hidden="true"
									></i>
									</span>
								</div>
							</div>
							<div class="field">
								<label class="label">Repeat Password:</label>
								<div class="control has-icons-left">
									<input
										class="input"
										type="password"
										placeholder="password"
										required
									/> <span class="icon is-small is-left"> <i
										class="fas fa-key"
										aria-hidden="true"
									></i>
									</span>
								</div>
								<p class="help is-danger">on_error_message</p>
							</div>
							<div class="field">
								<button
									type="submit"
									class="button is-link"
								>Register New User</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<p>loggedin: ${ sessionScope.loggedin }</p>

		<c:if test="${ not empty ConfirmMsg }">
			<div class="notification is-success">
				<p>
					<strong>confirmation: </strong> <span>${ConfirmMsg.status},
						${ConfirmMsg.statusText}, ${ConfirmMsg.message}</span>
				</p>
			</div>
		</c:if>

		<c:if test="${ not empty Error }">
			<p style="color: red;">${ Error.message }</p>
		</c:if>

		<c:choose>
			<c:when test="${ loggedin eq true }">
				<a href="./logout">logout</a>
			</c:when>
			<c:otherwise>
				<a class="login-link">login</a>
		or <a class="register-link">register</a>

			</c:otherwise>
		</c:choose>

	</section>
	<script src="modals.js"></script>
	<script src="login.js"></script>
</body>
</html>