<%@ page import="fr.isima.Answer" %>



<div class="fieldcontain ${hasErrors(bean: answerInstance, field: 'content', 'error')} ">
	<label for="content">
		<g:message code="answer.content.label" default="Content" />
		
	</label>
	<g:textArea name="content" cols="40" rows="5" maxlength="2000" value="${answerInstance?.content}"/>
</div>


