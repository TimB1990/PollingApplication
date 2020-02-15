<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %> 
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Polling startup</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta charset="utf-8">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>

<body>
<div class="container-fluid pt-3">

<p><a href="/PollingApplication/poll" class="btn btn-outline-primary" role="button">get Poll</a></p>

<c:if test="${not empty Error}">
	<div class="alert alert-danger">
		<strong>error: </strong>
		<span>${Error.status}, ${Error.statusText}, ${Error.message}</span>
	</div>
</c:if>

<c:if test="${not empty ConfirmMsg}">
	<div class="alert alert-success">
		<strong>confirmation: </strong> 
		<span>${ConfirmMsg.status}, ${ConfirmMsg.statusText}, ${ConfirmMsg.message}</span><br>
		<span>Welcome <strong>${User}</strong>, your login was successfull. If you want to the see the questions you already voted on and their details,
        go to your <a href="#">My Votings</a> dashboard!</span>
	</div>
</c:if>

<c:if test="${not empty PollData}">
	<div>
		<h3>${PollData.description}</h3>
		<form method="POST" action="/PollingApplication/vote">
			<c:forEach items="${PollData.answerList}" var="answer">
				<c:if test="${PollData.showVotes eq false}">
				<div class="custom-control custom-radio">
					<input type="radio" class="custom-control-input" id="${answer.aid}" name="aid" value="${answer.aid}" required/>
					<label class="custom-control-label" for="${answer.aid}">${answer.value}</label>
				</div>
				</c:if>
				<c:if test="${PollData.showVotes eq true}">
				<span>${answer.value}:</span>
				<c:set var="barwidth" value="${(answer.avotes / PollData.qvotes)*100}"/>
				<div class="progress" style="height:15px;">
					<div class="progress-bar" style="width:${barwidth}%;height:15px;background-color:lightblue">${barwidth}</div>
				</div>
				</c:if>
			</c:forEach>
			<br>
			
			<!-- if login is required disable vote -->
			<c:choose>
			<c:when test="${PollData.loginRequiredToVote eq true}">
				<c:set var="disabled" value="disabled"/>
			</c:when>'
			<c:otherwise>
				<c:set var="disabled" value=""/>
			</c:otherwise>
			</c:choose>
			<button type="submit" class="btn btn-primary ${disabled}">vote</button>
		</form>
		
		<!-- show login form if login is required -->
		<c:if test="${PollData.loginRequiredToVote eq true}">
			<form method="POST" action="/PollingApplication/login">
			<p>please login to continue</p>
			<div class="row">
				<div class="col">
					<input type="text" class="form-control" id="uname" placeholder="Enter uname" name="uname">
				</div>
				<div class="col">
					<input type="password" class="form-control" placeholder="Enter password" name="pass">
				</div>
				<div class="col">
					<button class="btn btn-primary" type="submit">login</button>
				</div>
			</div>
			
			</form>
		</c:if>
	</div>
</c:if>
</div>
</body>
</html>