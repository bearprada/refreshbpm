
<%@ page import="refreshbpm.EmotionGroup" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'emotionGroup.label', default: 'EmotionGroup')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-emotionGroup" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-emotionGroup" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list emotionGroup">
			
				<g:if test="${emotionGroupInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="emotionGroup.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${emotionGroupInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${emotionGroupInstance?.color}">
				<li class="fieldcontain">
					<span id="color-label" class="property-label"><g:message code="emotionGroup.color.label" default="Color" /></span>
					
						<span class="property-value" aria-labelledby="color-label"><g:fieldValue bean="${emotionGroupInstance}" field="color"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${emotionGroupInstance?.density}">
				<li class="fieldcontain">
					<span id="density-label" class="property-label"><g:message code="emotionGroup.density.label" default="Density" /></span>
					
						<span class="property-value" aria-labelledby="density-label"><g:fieldValue bean="${emotionGroupInstance}" field="density"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${emotionGroupInstance?.emotions}">
				<li class="fieldcontain">
					<span id="emotions-label" class="property-label"><g:message code="emotionGroup.emotions.label" default="Emotions" /></span>
					
						<g:each in="${emotionGroupInstance.emotions}" var="e">
						<span class="property-value" aria-labelledby="emotions-label"><g:link controller="emotion" action="show" id="${e.id}">${e?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${emotionGroupInstance?.friction}">
				<li class="fieldcontain">
					<span id="friction-label" class="property-label"><g:message code="emotionGroup.friction.label" default="Friction" /></span>
					
						<span class="property-value" aria-labelledby="friction-label"><g:fieldValue bean="${emotionGroupInstance}" field="friction"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${emotionGroupInstance?.restitution}">
				<li class="fieldcontain">
					<span id="restitution-label" class="property-label"><g:message code="emotionGroup.restitution.label" default="Restitution" /></span>
					
						<span class="property-value" aria-labelledby="restitution-label"><g:fieldValue bean="${emotionGroupInstance}" field="restitution"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${emotionGroupInstance?.id}" />
					<g:link class="edit" action="edit" id="${emotionGroupInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
