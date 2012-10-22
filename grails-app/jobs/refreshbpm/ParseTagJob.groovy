package refreshbpm



class ParseTagJob {
  static triggers = {
      simple repeatInterval: 900*1000 
    }

    def parserService

    def execute() {
    	println "execute job"
     	parserService.parseFlickrByApi()
    	//parserService.flickrByTagSearch2()
    }
}
