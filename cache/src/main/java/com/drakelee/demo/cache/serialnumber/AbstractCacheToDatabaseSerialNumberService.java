package com.drakelee.demo.cache.serialnumber;

import com.base.components.cache.CacheLock;
import com.base.components.cache.CacheManager;
import com.base.components.common.service.serialnumber.DataBaseSerialNumberStrategy;
import com.base.components.common.service.serialnumber.SerialNumberBuilderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.Cache;
import org.springframework.util.Assert;

/**
 * AbstractCacheToDatabaseSerialNumberService
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version v1.0.0
 * @date 2018-06-13 17:09
 */
@SuppressWarnings("unchecked")
public abstract class AbstractCacheToDatabaseSerialNumberService<T, DataBaseStrategy extends DataBaseSerialNumberStrategy<T>>
  implements SerialNumberBuilderService<T, DataBaseStrategy> {

  @Autowired
  protected CacheLock cacheLock;

  @Autowired
  protected CacheManager cacheManager;

  @Autowired
  protected DataBaseStrategy dataBaseStrategy;


  @Override
  public T increment(String cacheKey){
    Assert.hasText(cacheKey, "cacheKey is null !");
    return cacheLock.lock(cacheKey, () -> {
      Cache cache = cacheManager.getDefaultCache();
      T val = (T) cacheManager.getDefaultCache().get(cacheKey).get();
      if(val == null){
        val = dataBaseStrategy.selectCurrentMaxSerialNumber(cacheKey);
      }
      val = dataBaseStrategy.increment(cacheKey, val);
      cache.put(cacheKey, val);
      return val;
    });
  }

  @Override
  public T current(String cacheKey) {
    return (T) cacheManager.getDefaultCache().get(cacheKey).get();
  }
}
