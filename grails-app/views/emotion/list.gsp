
<%@ page import="refreshbpm.Emotion" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'emotion.label', default: 'Emotion')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-emotion" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-emotion" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'emotion.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="intensity" title="${message(code: 'emotion.intensity.label', default: 'Intensity')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${emotionInstanceList}" status="i" var="emotionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${emotionInstance.id}">${fieldValue(bean: emotionInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: emotionInstance, field: "intensity")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${emotionInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
