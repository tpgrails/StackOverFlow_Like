
<%@ page import="fr.isima.Answer" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'answer.label', default: 'Answer')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-answer" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-answer" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="content" title="${message(code: 'answer.content.label', default: 'Content')}" />
					
						<th><g:message code="answer.question.label" default="Question" /></th>
					
						<th><g:message code="answer.user.label" default="User" /></th>
					
						<g:sortableColumn property="validated" title="${message(code: 'answer.validated.label', default: 'Validated')}" />
					
						<g:sortableColumn property="votes" title="${message(code: 'answer.votes.label', default: 'Votes')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${answerInstanceList}" status="i" var="answerInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${answerInstance.id}">${fieldValue(bean: answerInstance, field: "content")}</g:link></td>
					
						<td>${fieldValue(bean: answerInstance, field: "question")}</td>
					
						<td>${fieldValue(bean: answerInstance, field: "user")}</td>
					
						<td><g:formatBoolean boolean="${answerInstance.validated}" /></td>
					
						<td>${fieldValue(bean: answerInstance, field: "votes")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${answerInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
