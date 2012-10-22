<%@ page import="refreshbpm.Emotion" %>



<div class="fieldcontain ${hasErrors(bean: emotionInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="emotion.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${emotionInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: emotionInstance, field: 'intensity', 'error')} required">
	<label for="intensity">
		<g:message code="emotion.intensity.label" default="Intensity" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="intensity" required="" value="${emotionInstance.intensity}"/>
</div>

