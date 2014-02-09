<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>${message(code:'message.welcome')}</title>
		<style type="text/css" media="screen">
			#status {
				background-color: #eee;
				border: .2em solid #fff;
				margin: 2em 2em 1em;
				padding: 1em;
				width: 12em;
				float: left;
				-moz-box-shadow: 0px 0px 1.25em #ccc;
				-webkit-box-shadow: 0px 0px 1.25em #ccc;
				box-shadow: 0px 0px 1.25em #ccc;
				-moz-border-radius: 0.6em;
				-webkit-border-radius: 0.6em;
				border-radius: 0.6em;
			}

			.ie6 #status {
				display: inline; /* float double margin fix http://www.positioniseverything.net/explorer/doubled-margin.html */
			}

			#status ul {
				font-size: 0.9em;
				list-style-type: none;
				margin-bottom: 0.6em;
				padding: 0;
			}
            
			#status li {
				line-height: 1.3;
			}

			#status h1 {
				text-transform: uppercase;
				font-size: 1.1em;
				margin: 0 0 0.3em;
			}

			#page-body {
				margin: 2em 1em 1.25em 18em;
			}

			h2 {
				margin-top: 1em;
				margin-bottom: 0.3em;
				font-size: 1em;
			}

			p {
				line-height: 1.5;
				margin: 0.25em 0;
			}

			#controller-list ul {
				list-style-position: inside;
			}

			#controller-list li {
				line-height: 1.3;
				list-style-position: inside;
				margin: 0.25em 0;
			}

			@media screen and (max-width: 480px) {
				#status {
					display: none;
				}

				#page-body {
					margin: 0 1em 1em;
				}

				#page-body h1 {
					margin-top: 0;
				}
			}
		</style>
		
	</head>
	<body >
		<div align="right">
		
		
			<g:if test="${session.user}">
				 
			</g:if>
			<g:else>
				<g:form  controller="user" action="langdef">
				<select id="lang" name="lang"> 
				   <option value="en" >${message(code:'message.english')}</option> 
				   <option value="fr">${message(code:'message.french')}</option> 
				</select> 
				<input type="submit" value="${message(code:'message.validate')}">
			</g:form>
			</g:else>
			
		</div>
		
		<div id="page-body" role="main">
			<h1>${message(code:'message.welcome')}</h1>

			${flash.message }
			<g:if test="${session.user}">
				 ${session.user} | <g:link controller="user" action="logout">logout</g:link>
			</g:if>
			<g:else>
				<g:form controller="user" action="login">
				<div>
					<label>${message(code:'message.login.email')}</label><input name="Login" type="text">
					<label>${message(code:'message.login.password')}</label><input name="Password" type="password">
					<input type="submit" value="${message(code:'message.login.connect')}">
				</div>
				</g:form>
				<g:link controller="user" action="create">${message(code:'message.signup')}</g:link>
			</g:else>
			
		</div>
	</body>
</html>
