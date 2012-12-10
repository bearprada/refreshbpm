package refreshbpm
import grails.util.Environment

class TwitterJob {

	def twitterService
    static triggers = {
     	simple repeatInterval: 10*1000 
    }

    def execute() {
    	if(Environment.getCurrent().equals(Environment.PRODUCTION) )
	        twitterService.getRecentTweet()
    }
}
