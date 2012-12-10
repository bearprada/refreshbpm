package refreshbpm

import grails.util.Environment

class FacebookPublicCollectorJob {

	def facebookParserService
    static triggers = {
      simple repeatInterval: 90*1000 
    }

    def execute() {
    	if(Environment.getCurrent().equals(Environment.PRODUCTION))
        	facebookParserService.getPublicPost()
    }
}
