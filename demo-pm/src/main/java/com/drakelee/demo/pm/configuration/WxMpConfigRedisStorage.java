package com.drakelee.demo.pm.configuration;

import com.base.components.cache.CacheLock;
import com.base.components.cache.CacheManager;
import com.base.components.cache.redis.RedisConnector;
import com.base.components.cache.redis.RedisExecutor;
import me.chanjar.weixin.common.bean.WxAccessToken;
import me.chanjar.weixin.mp.api.WxMpInMemoryConfigStorage;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * WxMpConfigRedisStorage
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-07-26 09:33
 */
public class WxMpConfigRedisStorage extends WxMpInMemoryConfigStorage {
  private final static String ACCESS_TOKEN_KEY = "wechat_access_token_";

  private final static String JSAPI_TICKET_KEY = "wechat_jsapi_ticket_";


  private String accessTokenKey;
  private String jsapiTicketKey;
  @Autowired
  private CacheLock cacheLock;
  @Autowired
  private CacheManager cacheManager;
  @Autowired
  private RedisConnector connector;

  @Override
  public void setAppId(String appId) {
    super.setAppId(appId);
    super.setAppId(appId);
    this.accessTokenKey = ACCESS_TOKEN_KEY.concat(appId);
    this.jsapiTicketKey = JSAPI_TICKET_KEY.concat(appId);
    //this.cardapiTicketKey = CARDAPI_TICKET_KEY.concat(appId);
  }

  @Override
  public String getAccessToken() {
    final String[] key = {null};
    try {
      cacheLock.lock(accessTokenKey, () -> {
        key[0] = connector.execute((connection, serial) -> {
          byte[] bytes = connection.get(serial.serialKey(accessTokenKey));
          if(bytes == null){
            return "";
          }
          return serial.deserialVal(bytes).toString();
        });
      });
      return key[0];
    } catch (Exception e) {
      e.printStackTrace();
    }
    return key[0];
  }

  @Override
  public void setAccessToken(String accessToken) {
    cacheLock.lock(accessTokenKey, () -> updateAccessToken(accessToken, 7200));

  }

  @Override
  public boolean isAccessTokenExpired() {
    final boolean[] key = {false};
    cacheLock.lock(accessTokenKey, () -> {
      key[0] = connector.execute((connection, serial) -> {
        byte[] bytes = connection.get(serial.serialKey(accessTokenKey));
        return bytes == null || bytes.length == 0;
      });
    });
    return key[0];
  }

  @Override
  public synchronized void updateAccessToken(WxAccessToken accessToken) {
    setAccessToken(accessToken.getAccessToken());
  }

  @Override
  public void expireAccessToken() {
    cacheLock.lock(accessTokenKey, () -> {
      connector.execute((RedisExecutor<String>) (connection, serial) -> {
        connection.pExpire(serial.serialKey(accessTokenKey),0);
        return null;
      });
    });
  }

  @Override
  public String getJsapiTicket() {
    final String[] key = {null};
    cacheLock.lock(jsapiTicketKey, () -> {
      String s = connector.execute((connection, serial) -> {
        byte[] bytes = connection.get(serial.serialKey(jsapiTicketKey));
        if(bytes == null){
          return "";
        }
        return serial.deserialVal(bytes).toString();
      });

      key[0] = s;
    });
    return key[0];
  }

  @Override
  public void setJsapiTicket(String jsapiTicket) {
    cacheLock.lock(jsapiTicketKey, () -> {
      updateJsapiTicket(jsapiTicket,7200);
    });
  }

  @Override
  public boolean isJsapiTicketExpired() {
    final boolean[] key = {false};
    cacheLock.lock(jsapiTicketKey, () -> {
      key[0] = connector.execute((connection, serial) -> {
        byte[] bytes = connection.get(serial.serialKey(jsapiTicketKey));
        return bytes == null || bytes.length == 0;
      });
    });
    return key[0];
  }

  @Override
  public synchronized void updateAccessToken(String accessToken, int expiresInSeconds) {
    cacheLock.lock(accessTokenKey, () -> {
      connector.execute((RedisExecutor<String>) (connection, serial) -> {
        connection.setEx(serial.serialKey(accessTokenKey), expiresInSeconds, serial.serialVal(accessToken));
        return null;
      });
    });
  }

  @Override
  public synchronized void updateJsapiTicket(String jsapiTicket, int expiresInSeconds) {
    cacheLock.lock(jsapiTicketKey, () -> {
      connector.execute((RedisExecutor<String>) (connection, serial) -> {
        connection.setEx(serial.serialKey(jsapiTicketKey), expiresInSeconds, serial.serialVal(jsapiTicket));
        return null;
      });
    });
  }

  @Override
  public void expireJsapiTicket() {
    cacheLock.lock(jsapiTicketKey, () -> {
      connector.execute((RedisExecutor<String>) (connection, serial) -> {
        connection.pExpire(serial.serialKey(jsapiTicketKey),0);
        return null;
      });
    });
  }
}
