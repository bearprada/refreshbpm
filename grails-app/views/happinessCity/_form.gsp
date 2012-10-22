<%@ page import="refreshbpm.HappinessCity" %>



<div class="fieldcontain ${hasErrors(bean: happinessCityInstance, field: 'afraid', 'error')} required">
	<label for="afraid">
		<g:message code="happinessCity.afraid.label" default="Afraid" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="afraid" required="" value="${happinessCityInstance.afraid}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: happinessCityInstance, field: 'angry', 'error')} required">
	<label for="angry">
		<g:message code="happinessCity.angry.label" default="Angry" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="angry" required="" value="${happinessCityInstance.angry}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: happinessCityInstance, field: 'country', 'error')} ">
	<label for="country">
		<g:message code="happinessCity.country.label" default="Country" />
		
	</label>
	<g:textField name="country" value="${happinessCityInstance?.country}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: happinessCityInstance, field: 'disappoint', 'error')} required">
	<label for="disappoint">
		<g:message code="happinessCity.disappoint.label" default="Disappoint" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="disappoint" required="" value="${happinessCityInstance.disappoint}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: happinessCityInstance, field: 'happy', 'error')} required">
	<label for="happy">
		<g:message code="happinessCity.happy.label" default="Happy" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="happy" required="" value="${happinessCityInstance.happy}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: happinessCityInstance, field: 'hate', 'error')} required">
	<label for="hate">
		<g:message code="happinessCity.hate.label" default="Hate" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="hate" required="" value="${happinessCityInstance.hate}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: happinessCityInstance, field: 'hope', 'error')} required">
	<label for="hope">
		<g:message code="happinessCity.hope.label" default="Hope" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="hope" required="" value="${happinessCityInstance.hope}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: happinessCityInstance, field: 'lat', 'error')} required">
	<label for="lat">
		<g:message code="happinessCity.lat.label" default="Lat" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="lat" step="any" required="" value="${happinessCityInstance.lat}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: happinessCityInstance, field: 'lng', 'error')} required">
	<label for="lng">
		<g:message code="happinessCity.lng.label" default="Lng" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="lng" step="any" required="" value="${happinessCityInstance.lng}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: happinessCityInstance, field: 'love', 'error')} required">
	<label for="love">
		<g:message code="happinessCity.love.label" default="Love" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="love" required="" value="${happinessCityInstance.love}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: happinessCityInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="happinessCity.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${happinessCityInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: happinessCityInstance, field: 'nervous', 'error')} required">
	<label for="nervous">
		<g:message code="happinessCity.nervous.label" default="Nervous" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="nervous" required="" value="${happinessCityInstance.nervous}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: happinessCityInstance, field: 'peace', 'error')} required">
	<label for="peace">
		<g:message code="happinessCity.peace.label" default="Peace" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="peace" required="" value="${happinessCityInstance.peace}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: happinessCityInstance, field: 'sad', 'error')} required">
	<label for="sad">
		<g:message code="happinessCity.sad.label" default="Sad" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="sad" required="" value="${happinessCityInstance.sad}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: happinessCityInstance, field: 'touched', 'error')} required">
	<label for="touched">
		<g:message code="happinessCity.touched.label" default="Touched" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="touched" required="" value="${happinessCityInstance.touched}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: happinessCityInstance, field: 'worried', 'error')} required">
	<label for="worried">
		<g:message code="happinessCity.worried.label" default="Worried" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="worried" required="" value="${happinessCityInstance.worried}"/>
</div>

