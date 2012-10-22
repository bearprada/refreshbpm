package refreshbpm

import org.apache.http.HttpEntity
import org.apache.http.HttpResponse
import org.apache.http.client.HttpClient
import org.apache.http.client.methods.HttpGet
import org.apache.http.impl.client.DefaultHttpClient
import org.apache.http.util.EntityUtils
import grails.converters.*
import java.text.SimpleDateFormat

class FacebookParserService {

    private static String mefeedApi   = "https://graph.facebook.com/me/posts?limit=400&access_token="
    private static String photoApi    = "https://graph.facebook.com/me/photos?limit=400&access_token="
    private static String checkinApi  = "https://graph.facebook.com/me/checkins?limit=400&access_token="

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'+0000'")

    def backgroundService
    def emotionDetectorService


	def getUserInfoOnce(user){
	
        backgroundService.execute("Get user facebook info once", {

                println "Start to background Service for user: ${user.id}"

                String apiMe =  mefeedApi + user.accessToken
                String apiPhoto =  photoApi + user.accessToken
				String apiCheckin = checkinApi + user.accessToken
				queryAndStoreMeFeed(apiMe, user)
				queryAndStoreMePhotos(apiPhoto, user)
				queryAndStoreMeCheckins(apiCheckin, user)

            })
	
	}
	
	
    def getUserInfo(user){

        backgroundService.execute("Get user facebook info", {

                println "Start to background Service for user: ${user.id}"

                String apiMe =  mefeedApi + user.accessToken
                String apiPhoto =  photoApi + user.accessToken
		String apiCheckin = checkinApi + user.accessToken
				
				
                def next = queryAndStoreMeFeed(apiMe, user)
                while(next != ""){
                    String apiMe2 = next
                    next = queryAndStoreMeFeed(apiMe2, user)
                }// end while

                def next2 = queryAndStoreMePhotos(apiPhoto, user)
                while(next2 != ""){
                    String apiPhoto2 = next2
                    next2 = queryAndStoreMePhotos(apiPhoto2, user)
                }// end while

                def next3 = queryAndStoreMeCheckins(apiCheckin, user)
                while(next3 != ""){
                    String apiCheckin2 = next3
                    next3 = queryAndStoreMeCheckins(apiCheckin2, user)
                }// end while

            })


    }
  
    private def queryAndStoreMeFeed(apiMe, user){
        
        
        println "queryAndStoreMeFeed: " + apiMe
        
        def resultFeed = connect(apiMe)
        def resultFeedData = resultFeed.data
        println "result data: " + resultFeedData

        if(resultFeedData!=null){

                for(int i=0;i<resultFeedData.size();i++){

                    // Make sure post come from user and not duplicate
                    def mefeed = Feed.findByFlickrPhotoId(resultFeedData[i].id)
                    println "mefeed is null or not: " + mefeed;
                    //def from = resultFeedData[i].from.id
                    //println resultFeedData[i].from.id

                    if( mefeed == null){

                        if(resultFeedData[i].message != null && resultFeedData[i].message != "null" &&
                            resultFeedData[i].message != ""){

                            def emotion = emotionDetectorService.analyser(resultFeedData[i].message)
                            if(emotion!=null){

                                mefeed = new Feed();
                                mefeed.sourcePath = ""
                                mefeed.imageThumbnailPath = ""
                                mefeed.flickrPhotoId = resultFeedData[i].id

                                // Save title and content
                                println "name:" + resultFeedData[i].name
                                println "message:" + resultFeedData[i].message
                                println "description:" + resultFeedData[i].description
                                println "created_time:" + resultFeedData[i].created_time
                                println "icon:" + resultFeedData[i].picture
                                println "picture source: " + resultFeedData[i].source
                                println "link:" + resultFeedData[i].link
                                println "place:" + resultFeedData[i].place


                                if(resultFeedData[i].name!=null)
                                mefeed.title =  resultFeedData[i].name
                                if(resultFeedData[i].message!=null)
                                mefeed.content =  resultFeedData[i].message

                                // Save publish time
                                mefeed.publishTime = parseTimeToLong(resultFeedData[i].created_time)

                                // Save link
                                if(resultFeedData[i].picture!=null)
                                mefeed.imagePath = resultFeedData[i].picture
                                if(resultFeedData[i].icon!=null)
                                mefeed.imageThumbnailPath = resultFeedData[i].icon
                                if(resultFeedData[i].link!=null)
                                mefeed.sourcePath = resultFeedData[i].link

                                // Save location
                                if(resultFeedData[i].place!=null){
                                    mefeed.lat = resultFeedData[i].place.location?.latitude
                                    mefeed.lng = resultFeedData[i].place.location?.longitude
                                    mefeed.country = resultFeedData[i].place.location?.country
                                    mefeed.city = resultFeedData[i].place.location?.city
                                    mefeed.address = resultFeedData[i].place.location?.street
                                }// end if

                                // Save feed
                                mefeed.mostEmotion = emotion
                                mefeed.addToEmotions(emotion)
                                mefeed.type = 0;
                                mefeed.facebookUser = user;
                                mefeed.save(flush:true)

                                // Add emotions
                                if (mefeed.hasErrors())
                                    mefeed.errors.each { println it }
                                else
                                    new FeedEmtionMapped(feed:mefeed,emotion:emotion).save()

                            }//end if

                        }//end if

                    }// end if

                }// end for
                
        }// end if
        println "paging: " + resultFeed.paging


        if(resultFeed.paging == null || resultFeed.paging == "" || resultFeed.paging == "undefined")
        return ""
        else
        return resultFeed.paging.next

    }

	 
	
    private def queryAndStoreMePhotos(apiMe, user){
        
        
        println "queryAndStoreMePhotos: " + apiMe
        
        def resultFeed = connect(apiMe)
        def resultFeedData = resultFeed.data
        println "result data: " + resultFeedData
        
        if(resultFeedData!=null){

                for(int i=0;i<resultFeedData.size();i++){

                    // Make sure post come from user and not duplicate
                    def mefeed = Feed.findByFlickrPhotoId(resultFeedData[i].id)
                    println "mefeed is null or not: " + mefeed;
                    if( mefeed == null){

                        if(resultFeedData[i].name != null && resultFeedData[i].name != "null" &&
                            resultFeedData[i].name != ""){

                            def emotion = emotionDetectorService.analyser(resultFeedData[i].name)
                            if(emotion!=null){

                                mefeed = new Feed();
                                mefeed.sourcePath = ""
                                mefeed.imageThumbnailPath = ""
                                mefeed.flickrPhotoId = resultFeedData[i].id

                                // Save title and content
                                println "name:" + resultFeedData[i].name
                                println "created_time:" + resultFeedData[i].created_time
                                println "icon:" + resultFeedData[i].picture
                                println "source: " + resultFeedData[i].source
                                println "place:" + resultFeedData[i].place


                                if(resultFeedData[i].name!=null)
                                mefeed.title =  resultFeedData[i].name

                                // Save publish time
                                mefeed.publishTime = parseTimeToLong(resultFeedData[i].created_time)

                                // Save link
                                if(resultFeedData[i].source!=null)
                                mefeed.imagePath = resultFeedData[i].source
                                if(resultFeedData[i].picture!=null)
                                mefeed.imageThumbnailPath = resultFeedData[i].picture

                                // Save location
                                if(resultFeedData[i].place!=null){
                                    mefeed.lat = resultFeedData[i].place.location?.latitude
                                    mefeed.lng = resultFeedData[i].place.location?.longitude
                                    mefeed.country = resultFeedData[i].place.location?.country
                                    mefeed.city = resultFeedData[i].place.location?.city
                                    mefeed.address = resultFeedData[i].place.location?.street
                                }// end if

                                // Save feed
                                mefeed.mostEmotion = emotion
                                mefeed.addToEmotions(emotion)
                                mefeed.type = 1;
                                mefeed.facebookUser = user;
                                mefeed.save(flush:true)
                                                              
                                // Add emotions
                                if (mefeed.hasErrors())
                                    mefeed.errors.each { println it }
                                else
                                    new FeedEmtionMapped(feed:mefeed,emotion:emotion).save()

                            }//end if

                        }// end if

                    }// end if

                }// end for

        }// end if
        println "paging: " + resultFeed.paging


        if(resultFeed.paging == null || resultFeed.paging == "" || resultFeed.paging == "undefined")
        return ""
        else
        return resultFeed.paging.next

    }


    private def queryAndStoreMeCheckins(apiMe, user){
        
        
        println "queryAndStoreMeCheckins: " + apiMe
        
        def resultFeed = connect(apiMe)
        def resultFeedData = resultFeed.data
        println "result data: " + resultFeedData

        if(resultFeedData!=null){

                for(int i=0;i<resultFeedData.size();i++){

                    // Make sure post come from user and not duplicate
                    def mefeed = Feed.findByFlickrPhotoId(resultFeedData[i].id)
                    println "mefeed is null or not: " + mefeed;
                    if( mefeed == null){

                        if(resultFeedData[i].message != null && resultFeedData[i].message != "null" &&
                            resultFeedData[i].message != ""){

                            def emotion = emotionDetectorService.analyser(resultFeedData[i].message)
                            if(emotion!=null){

                                mefeed = new Feed();
                                mefeed.sourcePath = ""
                                mefeed.imageThumbnailPath = ""
                                mefeed.flickrPhotoId = resultFeedData[i].id

                                // Save title and content
                                println "created_time:" + resultFeedData[i].created_time
                                println "message:" + resultFeedData[i].message
                                println "place:" + resultFeedData[i].place
                                if(resultFeedData[i].message!=null)
                                mefeed.content =  resultFeedData[i].message
                                
                                // Save publish time
                                mefeed.publishTime = parseTimeToLong(resultFeedData[i].created_time)

                                // Save location
                                if(resultFeedData[i].place!=null){
                                    mefeed.lat = resultFeedData[i].place.location?.latitude
                                    mefeed.lng = resultFeedData[i].place.location?.longitude
                                    mefeed.country = resultFeedData[i].place.location?.country
                                    mefeed.city = resultFeedData[i].place.location?.city
                                    mefeed.address = resultFeedData[i].place.location?.street
                                }// end if

                                // Save feed
                                mefeed.mostEmotion = emotion
                                mefeed.addToEmotions(emotion)
                                mefeed.type = 2;
                                mefeed.facebookUser = user;
                                mefeed.save(flush:true)

                                // Add emotions
                                if (mefeed.hasErrors())
                                    mefeed.errors.each { println it }
                                else
                                    new FeedEmtionMapped(feed:mefeed,emotion:emotion).save()
                                    
                            }//end if

                        }//end if

                    }// end if

                }// end for

        }//end if
        println "paging: " + resultFeed.paging


        if(resultFeed.paging == null || resultFeed.paging == "" || resultFeed.paging == "undefined")
        return ""
        else
        return resultFeed.paging.next

    }

	
	
	
    private def connect(String url){
        DefaultHttpClient httpclient = new DefaultHttpClient()
        HttpGet httpGet = new HttpGet(url)
        HttpResponse response1 = httpclient.execute(httpGet)
        try {
            //println response1.getStatusLine()
            HttpEntity entity1 = response1.getEntity()
            return JSON.parse(EntityUtils.toString(entity1))
        } finally {
            httpGet.releaseConnection()
        }
    }

    private long parseTimeToLong(jtdate){
        def date = sdf.parse(jtdate);
        return date.getTime()
    }


}
