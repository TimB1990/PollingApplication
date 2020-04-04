<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>index</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bulma@0.8.0/css/bulma.min.css">
<link rel="stylesheet" href="css/styling.css">
<link rel="stylesheet" href="css/loginRegister.css">

<script defer
	src="https://use.fontawesome.com/releases/v5.3.1/js/all.js"></script>
</head>

<body>
	<section>
		<jsp:include page="voting.jsp" />
	</section>
	<section>
		<jsp:include page="login.jsp" />
	</section>
	<section>
		<jsp:include page="register.jsp" />
	</section>
	<script src="js/vote.js"></script>
</body>

</html>