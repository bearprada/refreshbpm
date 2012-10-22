
<%@ page import="refreshbpm.EmotionGroup" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'emotionGroup.label', default: 'EmotionGroup')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-emotionGroup" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-emotionGroup" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'emotionGroup.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="color" title="${message(code: 'emotionGroup.color.label', default: 'Color')}" />
					
						<g:sortableColumn property="density" title="${message(code: 'emotionGroup.density.label', default: 'Density')}" />
					
						<g:sortableColumn property="friction" title="${message(code: 'emotionGroup.friction.label', default: 'Friction')}" />
					
						<g:sortableColumn property="restitution" title="${message(code: 'emotionGroup.restitution.label', default: 'Restitution')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${emotionGroupInstanceList}" status="i" var="emotionGroupInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${emotionGroupInstance.id}">${fieldValue(bean: emotionGroupInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: emotionGroupInstance, field: "color")}</td>
					
						<td>${fieldValue(bean: emotionGroupInstance, field: "density")}</td>
					
						<td>${fieldValue(bean: emotionGroupInstance, field: "friction")}</td>
					
						<td>${fieldValue(bean: emotionGroupInstance, field: "restitution")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${emotionGroupInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
