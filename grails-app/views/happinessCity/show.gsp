
<%@ page import="refreshbpm.HappinessCity" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'happinessCity.label', default: 'HappinessCity')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-happinessCity" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-happinessCity" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list happinessCity">
			
				<g:if test="${happinessCityInstance?.afraid}">
				<li class="fieldcontain">
					<span id="afraid-label" class="property-label"><g:message code="happinessCity.afraid.label" default="Afraid" /></span>
					
						<span class="property-value" aria-labelledby="afraid-label"><g:fieldValue bean="${happinessCityInstance}" field="afraid"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${happinessCityInstance?.angry}">
				<li class="fieldcontain">
					<span id="angry-label" class="property-label"><g:message code="happinessCity.angry.label" default="Angry" /></span>
					
						<span class="property-value" aria-labelledby="angry-label"><g:fieldValue bean="${happinessCityInstance}" field="angry"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${happinessCityInstance?.country}">
				<li class="fieldcontain">
					<span id="country-label" class="property-label"><g:message code="happinessCity.country.label" default="Country" /></span>
					
						<span class="property-value" aria-labelledby="country-label"><g:fieldValue bean="${happinessCityInstance}" field="country"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${happinessCityInstance?.disappoint}">
				<li class="fieldcontain">
					<span id="disappoint-label" class="property-label"><g:message code="happinessCity.disappoint.label" default="Disappoint" /></span>
					
						<span class="property-value" aria-labelledby="disappoint-label"><g:fieldValue bean="${happinessCityInstance}" field="disappoint"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${happinessCityInstance?.happy}">
				<li class="fieldcontain">
					<span id="happy-label" class="property-label"><g:message code="happinessCity.happy.label" default="Happy" /></span>
					
						<span class="property-value" aria-labelledby="happy-label"><g:fieldValue bean="${happinessCityInstance}" field="happy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${happinessCityInstance?.hate}">
				<li class="fieldcontain">
					<span id="hate-label" class="property-label"><g:message code="happinessCity.hate.label" default="Hate" /></span>
					
						<span class="property-value" aria-labelledby="hate-label"><g:fieldValue bean="${happinessCityInstance}" field="hate"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${happinessCityInstance?.hope}">
				<li class="fieldcontain">
					<span id="hope-label" class="property-label"><g:message code="happinessCity.hope.label" default="Hope" /></span>
					
						<span class="property-value" aria-labelledby="hope-label"><g:fieldValue bean="${happinessCityInstance}" field="hope"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${happinessCityInstance?.lat}">
				<li class="fieldcontain">
					<span id="lat-label" class="property-label"><g:message code="happinessCity.lat.label" default="Lat" /></span>
					
						<span class="property-value" aria-labelledby="lat-label"><g:fieldValue bean="${happinessCityInstance}" field="lat"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${happinessCityInstance?.lng}">
				<li class="fieldcontain">
					<span id="lng-label" class="property-label"><g:message code="happinessCity.lng.label" default="Lng" /></span>
					
						<span class="property-value" aria-labelledby="lng-label"><g:fieldValue bean="${happinessCityInstance}" field="lng"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${happinessCityInstance?.love}">
				<li class="fieldcontain">
					<span id="love-label" class="property-label"><g:message code="happinessCity.love.label" default="Love" /></span>
					
						<span class="property-value" aria-labelledby="love-label"><g:fieldValue bean="${happinessCityInstance}" field="love"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${happinessCityInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="happinessCity.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${happinessCityInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${happinessCityInstance?.nervous}">
				<li class="fieldcontain">
					<span id="nervous-label" class="property-label"><g:message code="happinessCity.nervous.label" default="Nervous" /></span>
					
						<span class="property-value" aria-labelledby="nervous-label"><g:fieldValue bean="${happinessCityInstance}" field="nervous"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${happinessCityInstance?.peace}">
				<li class="fieldcontain">
					<span id="peace-label" class="property-label"><g:message code="happinessCity.peace.label" default="Peace" /></span>
					
						<span class="property-value" aria-labelledby="peace-label"><g:fieldValue bean="${happinessCityInstance}" field="peace"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${happinessCityInstance?.sad}">
				<li class="fieldcontain">
					<span id="sad-label" class="property-label"><g:message code="happinessCity.sad.label" default="Sad" /></span>
					
						<span class="property-value" aria-labelledby="sad-label"><g:fieldValue bean="${happinessCityInstance}" field="sad"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${happinessCityInstance?.touched}">
				<li class="fieldcontain">
					<span id="touched-label" class="property-label"><g:message code="happinessCity.touched.label" default="Touched" /></span>
					
						<span class="property-value" aria-labelledby="touched-label"><g:fieldValue bean="${happinessCityInstance}" field="touched"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${happinessCityInstance?.worried}">
				<li class="fieldcontain">
					<span id="worried-label" class="property-label"><g:message code="happinessCity.worried.label" default="Worried" /></span>
					
						<span class="property-value" aria-labelledby="worried-label"><g:fieldValue bean="${happinessCityInstance}" field="worried"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${happinessCityInstance?.id}" />
					<g:link class="edit" action="edit" id="${happinessCityInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
