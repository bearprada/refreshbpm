dataSource {
    pooled = true
    driverClassName = "com.mysql.jdbc.Driver"
    username = "root"
    password = "888999"

    //Avoid mysql database interupt the connection
    properties {
       maxActive = 50
       maxIdle = 25
       minIdle = 5
       initialSize = 5
       minEvictableIdleTimeMillis = 1800000
       timeBetweenEvictionRunsMillis = 1800000
       maxWait = 10000
    }
 }

hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://localhost/refreshbpm?useUnicode=true&characterEncoding=utf-8"  //?autoReconnect=true&characterEncoding=UTF-8&zeroDateTimeBehavior=convertToNull
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://localhost/refreshbpm?useUnicode=true&characterEncoding=utf-8"  //?autoReconnect=true&characterEncoding=UTF-8&zeroDateTimeBehavior=convertToNull
        }
    }
    production {
        dataSource {
            dbCreate = "update"
            username = "root"
            password = "f5iscool"
            url = "jdbc:mysql://localhost/refreshbpm?useUnicode=true&characterEncoding=utf-8"  //?autoReconnect=true&characterEncoding=UTF-8&zeroDateTimeBehavior=convertToNull
        }
    }
    bees {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://ec2-23-21-211-172.compute-1.amazonaws.com/refreshbpm?useUnicode=true&characterEncoding=utf-8"  //?autoReconnect=true&characterEncoding=UTF-8&zeroDateTimeBehavior=convertToNull
            username = "f5"
            password = "f5iscool"

        }
    }
}
