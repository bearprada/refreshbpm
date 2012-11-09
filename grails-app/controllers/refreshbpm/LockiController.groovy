package refreshbpm
import grails.converters.JSON

import java.text.SimpleDateFormat

class LockiController {

    def treemap() {}

    def treemapsvg(){ [total_emotion:Feed.count] }

    def reel() {}

    def stockcsv() {
        def random = new Random()
        def stock = ['AAPL','IBM','MSFT','AMZN','PRADA']
        def t = "symbol,date,price\n"
        stock.each{ s->
            (2000..2010).each{ y->
                t += "${s},Jan ${y},${random.nextInt(10000)}\n"
            }
        }
        render(contentType:"html/text",text:t)
    }

/*
 new EmotionGroup(name:'高興', color:'#FFCC33', red:255 , green:204, blue:51).save(flush:true)
            new EmotionGroup(name:'悲傷', color:'#1c4aa8', red:28 , green:74, blue:168).save(flush:true)
            new EmotionGroup(name:'憂愁', color:'#663399', red:102 , green:51, blue:153).save(flush:true)
            new EmotionGroup(name:'憤怒', color:'#de2121', red:222 , green:33, blue:33).save(flush:true)
            new EmotionGroup(name:'失望', color:'#b4cc66', red:180 , green:204, blue:102).save(flush:true)
            new EmotionGroup(name:'平靜', color:'#E0E0E0', red:224 , green:224, blue:224).save(flush:true)
            new EmotionGroup(name:'慌張', color:'#0cad34', red:12 , green:173, blue:52).save(flush:true)
            new EmotionGroup(name:'害怕', color:'#33ccb8', red:51 , green:204, blue:184).save(flush:true)
            new EmotionGroup(name:'感動', color:'#FF9933', red:255 , green:153, blue:51).save(flush:true)
            new EmotionGroup(name:'希望', color:'#f5721b', red:245 , green:114, blue:27).save(flush:true)
            new EmotionGroup(name:'愛', color:'#FF3399', red:255 , green:51, blue:153).save(flush:true)
            new EmotionGroup(name:'恨', color:'#000000', red:0 , green:0, blue:0).save(flush:true)
*/
  def emotioncsv(){
    def t = "symbol,date,price\n"
    def group = [[name:"happy",id:1] , [name:"sad",id:2] , [name:"nervois", id:3],[name:"angry", id:4],[name:"disappoint", id:5],[name:"love", id:11],[name:"hate", id:12]]
    //EmotionGroup.list().each{ eg->
    group.each{
        def eg = EmotionGroup.get(it.id)
        def es = getEmotion(eg)
        def count = 0
        def num
        es.date.each{ d->
            num = es.amount[count++]
          //  if(num>0)
                t += "${it.name},${d},${num}\n"
        }
    }
    render(contentType:"html/text",text:t)
  }

    private def getEmotion(def emotionGroup){
        def dateList=[]
        def amountList=[]
        def dateFormat =new SimpleDateFormat("yyyy-MM-dd");
        
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.YEAR, -1);
      //  def firstDate=dateFormat.parse(cal.getTime().format("yyyy-MM-dd HH"))

        def lastDate=new Date(Feed.createCriteria().get{
            ne("publishTime",0.toLong())
            lt('publishTime',new Date().getTime())
            order("publishTime","desc")
            maxResults(1)
            projections{
                property("publishTime")
            }
        })
        
        //def formatFirstDate=dateFormat.parse(cal.getTime().format("yyyy-MM-dd")).getTime()
        def formatFirstDate=cal.getTimeInMillis()
        //def formatLastDate=dateFormat.parse(lastDate.format("yyyy-MM-dd")).getTime()
        def formatLastDate=lastDate.getTime()
        
       
        //def emotionGroup=EmotionGroup.get(Integer.parseInt(params.emotionGroupNameId))
        def emotionList=new ArrayList(Emotion.createCriteria().list{
            createAlias("emotionGroup", "e")
                eq("e.id",emotionGroup.id)
            projections {
                property "name"
            }
        })
        
        long diff=86400000*10 //FIXME
        def first=formatFirstDate
        def last=formatFirstDate+diff
        while(1){
            def feedList=new ArrayList(Feed.createCriteria().list{
                if(session.facebookUser&&session.mapMode=="personal")
                    eq('facebookUser',session.facebookUser)
                ne("publishTime",0.toLong())
                gt('publishTime',first.toLong())
                lt('publishTime',last.toLong())
                mostEmotion{
                    projections {
                        property "name"
                    }
                }
            })
            
            feedList.retainAll(emotionList)
            def amount=feedList.size()
            if (first>=formatLastDate)
                break
            else {
                dateList.add(first-3600000*8) // parse to GMT
                amountList.add(amount)
                first+=diff
                last+=diff
        }
        }
    
        //def ret=[]
        //ret.add("date":dateList,"amount":amountList,"title":"Emotion ("+emotionGroup.name+")")
        
        //render ret as JSON
        return [date:dateList , amount:amountList]
    }

    def thor(){
    	def result = [name:"emotions",children:[]]
    	EmotionGroup.list().each{ eg->
    		def childs = []
    		eg.emotions.each{ e->
    			int c = Feed.countByMostEmotion(e)
    			if(c>10)
    				childs.add([name:e.name,size:c])
    		}
    		if(childs.size()>0)
    			result.children.add([name:eg.name,children:childs])
    	}
    	render result as JSON
    }
}
