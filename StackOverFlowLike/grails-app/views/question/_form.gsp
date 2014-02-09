<%@ page import="fr.isima.Question" %>



<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'user', 'error')} ">
	<g:hiddenField name="name" value="${session.userid}"/>
	
</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'title', 'error')} ">
	<label for="title">
		<g:message code="question.title.label" default="Title" />
		
	</label>
	<g:textField name="title"  value="${questionInstance?.title}" style='width: 500px;'/>
</div>


<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'content', 'error')} ">
	<label for="content">
		<g:message code="question.content.label" default="Content" />
		
	</label>
	<g:textArea class="text" name="content"  value="${questionInstance?.content}" style='width: 500px; height: 200px;' />
</div>
