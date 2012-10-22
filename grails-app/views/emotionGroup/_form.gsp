<%@ page import="refreshbpm.EmotionGroup" %>



<div class="fieldcontain ${hasErrors(bean: emotionGroupInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="emotionGroup.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${emotionGroupInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: emotionGroupInstance, field: 'color', 'error')} ">
	<label for="color">
		<g:message code="emotionGroup.color.label" default="Color" />
		
	</label>
	<g:textField name="color" value="${emotionGroupInstance?.color}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: emotionGroupInstance, field: 'density', 'error')} required">
	<label for="density">
		<g:message code="emotionGroup.density.label" default="Density" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="density" step="any" required="" value="${emotionGroupInstance.density}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: emotionGroupInstance, field: 'emotions', 'error')} ">
	<label for="emotions">
		<g:message code="emotionGroup.emotions.label" default="Emotions" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${emotionGroupInstance?.emotions?}" var="e">
    <li><g:link controller="emotion" action="show" id="${e.id}">${e?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="emotion" action="create" params="['emotionGroup.id': emotionGroupInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'emotion.label', default: 'Emotion')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: emotionGroupInstance, field: 'friction', 'error')} required">
	<label for="friction">
		<g:message code="emotionGroup.friction.label" default="Friction" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="friction" step="any" required="" value="${emotionGroupInstance.friction}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: emotionGroupInstance, field: 'restitution', 'error')} required">
	<label for="restitution">
		<g:message code="emotionGroup.restitution.label" default="Restitution" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="restitution" step="any" required="" value="${emotionGroupInstance.restitution}"/>
</div>

