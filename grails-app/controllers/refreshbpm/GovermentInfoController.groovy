package refreshbpm

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import grails.converters.*

class GovermentInfoController {

    // Tourist site of goverment
    private static String GOVERMENT_SITE = "http://www.api.cloud.taipei.gov.tw/CSCP_API/etm/trv"
    
    private static DefaultHttpClient httpclient = new DefaultHttpClient()


    def index() {

         // Get all categories
         def categories = getCategory()
         for(int i=0; i<categories.size(); i++){
            
            def category = categories[i]
             println "subCategoryId: " + category.subCategoryId + " ; " + "subCategoryName: " + category.subCategoryName

            // Get all subcategories
            def subcategories = getSubcategory(category.subCategoryId)
            //println "subcategory details: " + subcategories
            
            for(int j=0; j<subcategories.size(); j++){
                
                def subcategory = subcategories[j]
                println subcategory
                
                
                // Get scenic point details
                def travels = getTravel(subcategory.travelId);
                
                for(int k=0; k<travels.size(); k++){
                    
                    def travel = travels[k]
                    println travel
                    println travel.imgURL
                    def images = travel.imgURL.split(',')
                    
                    //println travel.address
                    println travel.description
                    
                    
                    def govInfo = new GovermentTouristInfo(
                        name: travel.travelName,
                        description: travel.description
                    );

                    // Process address
                    if(travel.address != null && travel.address != "null"){
                        govInfo.address = travel.address;
                        if(govInfo.address.indexOf("臺北")!=-1){
                            govInfo.city = "taipei"
                        }else if(govInfo.address.indexOf("桃園")!=-1){
                            govInfo.city = "taoyuan"
                        }else if(govInfo.address.indexOf("新竹")!=-1){
                            govInfo.city = "hsinchu"
                        }else if(govInfo.address.indexOf("基隆")!=-1){
                            govInfo.city = "keelung"
                        }else if(govInfo.address.indexOf("宜蘭")!=-1){
                            govInfo.city = "yilan"
                        }else if(govInfo.address.indexOf("苗栗")!=-1){
                            govInfo.city = "miaoli"
                        }// end if
                    }// end if

                    // Process lat and lng part
                    if(travel.lat != null && travel.lat!="null")
                        govInfo.lat = Double.parseDouble(travel.lat)
                    if(travel.lng != null && travel.lng!="null")    
                        govInfo.lng = Double.parseDouble(travel.lng)
                    
                    // Process images part
                    for(int g=0; g<images.size(); g++){
                        if(g==0)
                            govInfo.imageUrl1= images[0]
                        if(g==1)
                            govInfo.imageUrl2 = images[1]
                        if(g==2)
                            govInfo.imageUrl3 = images[2]
                    }//end for
                    
                    govInfo.save(flush: true)
                    
                    
                    println "ffffff000000000000000: " + travel.description
                    
                }
                
                
            }// end for j
            

         }// end for i


    }


    /* Get categories of all scenic spots */
    private def getCategory(){
        String CATEGORY_API = "/categories/1/topics" // 1: scenic spot catogory 2: hotel
    	def rp = GOVERMENT_SITE + CATEGORY_API
        
        println "api: " + rp;
        return connect(rp)
    }

    /* Get subcategories of all categories */
    private def getSubcategory(String id){
        String SUBCATEGORY_API = "/subCategories/${id}/topics"
    	def rp = GOVERMENT_SITE + SUBCATEGORY_API
        return connect(rp)
    }

    /* Get subcategories of all categories */
    private def getTravel(String id){
        String SUBCATEGORY_API = "/rows/${id}"
       def rp = GOVERMENT_SITE + SUBCATEGORY_API
        return connect(rp)
    }
    
    
    

    private def connect(String url){
        HttpGet httpGet = new HttpGet(url)
        HttpResponse response1 = httpclient.execute(httpGet)
        try {
            println response1.getStatusLine()
            HttpEntity entity1 = response1.getEntity()
            
            
            def result =  EntityUtils.toString(entity1)// .replace("[","").replace("]","")
            
            println result
            
            def resultJ = JSON.parse(result)
            
            println resultJ
            
            return resultJ
            
        } finally {
            httpGet.releaseConnection()
        }
    }


}
