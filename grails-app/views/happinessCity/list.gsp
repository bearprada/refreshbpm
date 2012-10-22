
<%@ page import="refreshbpm.HappinessCity" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'happinessCity.label', default: 'HappinessCity')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-happinessCity" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-happinessCity" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="afraid" title="${message(code: 'happinessCity.afraid.label', default: 'Afraid')}" />
					
						<g:sortableColumn property="angry" title="${message(code: 'happinessCity.angry.label', default: 'Angry')}" />
					
						<g:sortableColumn property="country" title="${message(code: 'happinessCity.country.label', default: 'Country')}" />
					
						<g:sortableColumn property="disappoint" title="${message(code: 'happinessCity.disappoint.label', default: 'Disappoint')}" />
					
						<g:sortableColumn property="happy" title="${message(code: 'happinessCity.happy.label', default: 'Happy')}" />
					
						<g:sortableColumn property="hate" title="${message(code: 'happinessCity.hate.label', default: 'Hate')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${happinessCityInstanceList}" status="i" var="happinessCityInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${happinessCityInstance.id}">${fieldValue(bean: happinessCityInstance, field: "afraid")}</g:link></td>
					
						<td>${fieldValue(bean: happinessCityInstance, field: "angry")}</td>
					
						<td>${fieldValue(bean: happinessCityInstance, field: "country")}</td>
					
						<td>${fieldValue(bean: happinessCityInstance, field: "disappoint")}</td>
					
						<td>${fieldValue(bean: happinessCityInstance, field: "happy")}</td>
					
						<td>${fieldValue(bean: happinessCityInstance, field: "hate")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${happinessCityInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
