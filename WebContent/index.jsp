<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>index</title>
<link rel="stylesheet" href="css/app.css">

<!-- <script defer
	src="https://use.fontawesome.com/releases/v5.3.1/js/all.js"></script> -->
</head>

<body>
<c:if test="${ empty CurrentView or CurrentView eq 'polldata' }">
<section>
		<jsp:include page="poll.jsp" />
	</section>
</c:if>
	
<c:if test="${not empty CurrentView and CurrentView eq 'login'}">
	<section>
		<jsp:include page="login.jsp" />
	</section>
</c:if>

<c:if test="${ not empty CurrentView and CurrentView eq 'register' }">
	<section>
		<jsp:include page="register.jsp" />
	</section>
</c:if>

<c:if test="${ not empty CurrentView and CurrentView eq 'terms' }">
	<section>
		<jsp:include page="privacy.jsp" />
	</section>
</c:if>

</body>

</html>