
<%@ page import="fr.isima.Question" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-question" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class="home" controller="question" action="list"><g:message code="default.home.label"/></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label.question" args="[entityName]" /></g:link></li>
				<li><g:link controller="user" action="logout"><g:message code="default.logout" args="${[session.user]}" /></g:link></li>
				
				
			</ul>
		</div>
		<div id="list-question" class="content scaffold-list" role="main">
			<h1><g:message code="question.list.label" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="title" title="${message(code: 'question.title.label', default: 'Title')}" />
					
						<g:sortableColumn property="dateCreation" title="${message(code: 'question.dateCreation.label', default: 'Date Creation')}" />
					
						<g:sortableColumn property="view" title="${message(code: 'question.view.label', default: 'View')}" />
					
						<g:sortableColumn property="votes" title="${message(code: 'question.votes.label', default: 'Votes')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${questionInstanceList}" status="i" var="questionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${questionInstance.id}">${fieldValue(bean: questionInstance, field: "title")}</g:link></td>
					
						<td><g:formatDate date="${questionInstance.dateCreation}" /></td>
				
						<td>${fieldValue(bean: questionInstance, field: "view")}</td>
					
						<td>${fieldValue(bean: questionInstance, field: "votes")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${questionInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
