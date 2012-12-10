package refreshbpm

import grails.util.Environment

class ParseTagJob {
  static triggers = {
      simple repeatInterval: 90*1000 
    }

    def parserService

    def execute() {
    	if(Environment.getCurrent().equals(Environment.PRODUCTION) )
     	    parserService.parseFlickrNoGeoLimited()
    }
}
