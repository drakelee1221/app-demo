package com.drakelee.demo.cache.order;

import com.base.components.cache.Cache;
import com.base.components.cache.CacheLock;
import com.base.components.cache.CacheManager;
import com.drakelee.demo.cache.CacheName;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * 订单编号
 *
 * @author <a href="lijian@xianyunsoft.com">Lijian</a>
 * @version 1.0.0, 2017-11-24
 */
@Component
@RefreshScope
public class BusinessNoGenerator {
  private static Logger logger = LoggerFactory.getLogger(BusinessNoGenerator.class);
  private static final String CACHE_KEY = "order_no_cache_key";
  @Autowired
  private CacheLock cacheLock;
  @Autowired
  private CacheManager cacheManager;

  @SuppressWarnings("unchecked")
  public String getKey(CacheName name) {
    Cache cache = cacheManager.getCache(name);
    final String[] key = {null};
    try {
      cacheLock.lock(CACHE_KEY, new Runnable() {
        @Override
        public void run() {
          Integer s = cache.get(CACHE_KEY, Integer.class);
          if(s ==null){
            s = 0;
          }
          DateTime now = DateTime.now();
          DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyyMMddHHmmss");
          int l = 5-String.valueOf(s).length();
          StringBuilder t = new StringBuilder();
          for(int i=0;i<l;i++){
            t.append("0");
          }
          key[0] = name.toString().charAt(0)+now.toString(formatter)+t+s;
          Date date = now.withHourOfDay(23).withMinuteOfHour(59).withMinuteOfHour(59).toDate();
          cache.expireAt(CACHE_KEY,date);
          cache.put(CACHE_KEY,s+1);
        }
      });
      return key[0];
    } catch (Exception e) {
      e.printStackTrace();
    }
    return key[0];
  }
}
