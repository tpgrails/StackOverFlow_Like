
<%@ page import="fr.isima.Question" %>
<%@ page import="fr.isima.Answer" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-question" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class="home" controller="question" action="list"><g:message code="default.home.label"/></g:link></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.question" args="[entityName]" /></g:link></li>
				
				
				
				<g:hiddenField name="id" value="${questionInstance?.id}" />
				<g:if test="${questionInstance?.user.id == session.userid || session.badge.currentTitle.compareTo(session.badge.title.get(3))== 0}">
    				<li><g:link class="edit" action="edit" id="${questionInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link><li>

				</g:if>
			
				<li><g:link controller="user" action="logout"><g:message code="default.logout" args="${[session.user]}" /></g:link></li>
				
				
			</ul>
		</div>
		
		
		<div id="show-question" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
				<g:if test="${flash.message}">
					<div class="message" role="status">${flash.message}</div>
				</g:if>
			<TABLE  cellpadding="1">

			<TR>
			  <TD>
			  		<g:form  method="post" controller="question" action="voteup" >
					<g:hiddenField name="id" value="${questionInstance?.id}" />
					
					<fieldset class="buttons">
						<g:submitButton name="up" value="  ${message(code: 'message.vote.up'  , default: 'Vote up')}" />
					</fieldset>
				</g:form>
				<div align="center"><span class="property-value" aria-labelledby="user-label">${questionInstance?.votes}</span></div>
			 	<g:form method="post" controller="question" action="votedown" >
						<g:hiddenField name="id" value="${questionInstance?.id}" />
						
						<fieldset class="buttons">
							<g:submitButton name="down" value="${message(code: 'message.vote.down', default: 'Vote down')}" />
						</fieldset>
					</g:form>
			  </TD>
			  <TD width=85% rowspan="1">
			  	
			  		<ol class="property-list question">
			
			
						<g:if test="${questionInstance?.user}">
						<li class="fieldcontain">
							<span id="user-label" class="property-label"><g:message code="question.user.label" default="User" /></span>
							
								<span class="property-value" aria-labelledby="user-label"><g:link controller="user" action="show" id="${questionInstance?.user?.id}">${questionInstance?.user?.name}</g:link></span>
							
						</li>
						</g:if>
						
						<g:if test="${questionInstance?.title}">
						<li class="fieldcontain">
							<span id="title-label" class="property-label"><g:message code="question.title.label" default="Title" /></span>
							
								<span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${questionInstance}" field="title"/></span>
							
						</li>
						</g:if>
						
						<g:if test="${questionInstance?.content}">
						<li class="fieldcontain">
							<span id="content-label" class="property-label"><g:message code="question.content.label" default="Content" /></span>
							
								<span class="property-value" aria-labelledby="content-label"><g:fieldValue bean="${questionInstance}" field="content"/></span>
							
						</li>
						</g:if>
					
					
					</ol>
				
				</div>
			  
			  </TD> 
			</TR>
			
			</TABLE>
			
		
		
		<div id="show-answer" class="content scaffold-show" role="main">
			<h1><g:message code="message.answers" /></h1>
			
			<ol class="property-list question">
			<g:each in="${listAnswer}" var="answer">
			
			<TABLE  cellpadding="1">

			<TR>
			  <TD>
			  
			  		
					<g:if test="${answer?.validated}">
						<span id="user-label" class="property-label"><g:message code="message.answer.valide" default="Validated answer" /></span>
					</g:if>
					
			  		<g:form method="post" controller="answer" action="voteup" >
						<g:hiddenField name="id" value="${answer?.id}" />
						<g:hiddenField name="idquestion" value="${questionInstance?.id}" />
						<fieldset class="buttons">
							<g:submitButton name="up" value="  ${message(code: 'message.vote.up'  , default: 'Vote up')}" />
						</fieldset>
					</g:form>
					<div align="center">${answer?.votes}</div>
				 	<g:form method="post" controller="answer" action="votedown" >
							<g:hiddenField name="id" value="${answer?.id}" />
							<g:hiddenField name="idquestion" value="${questionInstance?.id}" />
							<fieldset class="buttons">
								<g:submitButton name="down" value="${message(code: 'message.vote.down', default: 'Vote down')}" />
							</fieldset>
					</g:form>
					
					<g:if test="${questionInstance?.user.id == session.userid}">
					<g:if test="${params.validate == null}">
					<g:if test="${validate == false}">
	    				<g:form method="post" controller="answer" action="validate" >
							<g:hiddenField name="id" value="${answer?.id}" />
							<g:hiddenField name="idquestion" value="${questionInstance?.id}" />
							<fieldset class="buttons">
								<g:submitButton name="down" value="${message(code: 'message.answer.validate', default: 'Validate')}" />
							</fieldset>
					</g:form>
					</g:if>
					</g:if>
					</g:if>
			  </TD>
			  <TD width=80%>
			  		<li class="fieldcontain">
						<span id="content-label" class="property-label"><g:message code="question.user.label" default="User" /></span>
						<span class="property-value" aria-labelledby="user-label"><g:link controller="user" action="show" id="${answer?.user?.id}">${answer?.user?.name}</g:link></span>
					</li>
					
					<li class="fieldcontain">
						<span id="content-label" class="property-label"><g:message code="question.content.label" default="Content" /></span>
						<span class="property-value" aria-labelledby="user-label">${answer?.content}</span>
					</li>
					
					<g:if test="${answer?.user.id == session.userid || session.badge.currentTitle.compareTo(session.badge.title.get(3))== 0}">
						   <div align="right">
						   		<g:link class="edit" controller="answer" action="edit" id="${answer?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
						   		
						   </div>
					</g:if>
			  </TD>
			</TR>
			</TABLE>
				
				
			</g:each>
			</ol>
			
		</div>
		
		
		<div id="post-answer" class="content scaffold-show" role="main">
			<h1><g:message code="message.answer" /></h1>
			<g:form method="post" controller="answer" action="save" >
				<g:hiddenField name="idquestion" value="${questionInstance?.id}" />
				
				<div class="fieldcontain ${hasErrors(bean: answerInstance, field: 'content', 'error')} ">
					<label for="content">
						<g:message code="answer.content.label" default="Content" />
						
					</label>
					<g:textArea name="content" style='width: 500px; height: 200px;'/>
				</div>
				
				
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'message.post', default: 'Post your answer')}" />
				</fieldset>
			</g:form>
			
			
			
		</div>
	</body>
</html>
