package com.drakelee.demo.pm.service.user;

import com.base.components.cache.Cache;
import com.base.components.cache.CacheManager;
import com.drakelee.demo.cache.CacheName;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.concurrent.TimeUnit;

/**
 * UserSearchCountOfDayService
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/3/21 0021 10:44
 */
@Service
@RefreshScope
public class UserCountOfTimeService {
  @Value("${base.userSearch.limit.countOfDay:3}")
  private int userSearchCountOfDay;

  @Value("${base.userPwdError.limit.countOfHour:3}")
  private int userPwdErrorCountOfHour;


  @Autowired
  CacheManager cacheManager;

  /**
   * 检查每天查询次数是否超过限制
   *
   * @param cacheName 缓存名称
   * @param key 查找的key(发起查询的用户的id)
   *
   * @return
   */
  public Boolean checkIsUserSearchLimit(CacheName cacheName, String key) {
    Cache cache = cacheManager.getCache(cacheName);
    Integer count = cache.get(key, Integer.class);
    if (count == null) {
      count = 1;
    } else {
      if (count >= userSearchCountOfDay) {
        return true;
      }
      count++;
    }
    Date expireDate = DateTime.now().millisOfDay().withMaximumValue().toDate();
    cache.put(key, count);
    cache.expireAt(key, expireDate);
    return false;
  }


  /**
   * 用户输错密码的次数记录
   *
   * @param cacheName
   * @param key
   */
  public void userPwdErrorCount(CacheName cacheName, String key) {
    Cache cache = cacheManager.getCache(cacheName);
    Integer count = cache.get(key, Integer.class);
    if (count == null) {
      count = 1;
      cache.put(key, count);
      cache.expire(key, 1, TimeUnit.HOURS);
    } else {
      count++;
      cache.put(key, count);
    }
  }

  /**
   * 检查一个小时内用户输错密码的次数限制
   *
   * @param cacheName
   * @param key
   *
   * @return
   */
  public Boolean checkIsUserPwdErrorLimit(CacheName cacheName, String key) {
    Cache cache = cacheManager.getCache(cacheName);
    Integer count = cache.get(key, Integer.class);
    if (count == null) {
      return false;
    } else {
      if (count >= userPwdErrorCountOfHour) {
        return true;
      } else {
        return false;
      }
    }
  }

  /**
   * 清除次数缓存
   * @param cacheName
   * @param key
   */
  public void removeUserPwdErrorLimit(CacheName cacheName, String key) {
    Cache cache = cacheManager.getCache(cacheName);
    cache.evict(key);
  }



}
