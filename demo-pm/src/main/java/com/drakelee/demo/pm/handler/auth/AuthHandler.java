package com.drakelee.demo.pm.handler.auth;

import com.base.components.cache.CacheLock;
import com.base.components.cache.CacheManager;
import com.base.components.common.util.JsonUtils;
import com.drakelee.demo.pm.service.sys.AttachmentAuthService;
import com.drakelee.demo.pm.service.sys.AttachmentService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.google.common.collect.Maps;
import com.drakelee.demo.cache.CacheName;
import com.drakelee.demo.common.domain.sys.Attachment;
import com.drakelee.demo.pm.service.oss.QiniuOssService;
import com.drakelee.demo.pm.service.sys.AttachmentAuthService;
import com.drakelee.demo.pm.service.sys.AttachmentService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.List;
import java.util.Map;

/**
 * 权限验证redis
 *
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/3/27 0027 10:57
 */
@Component
@ConditionalOnProperty({"spring.redis.host", "base.common.cache.enable"})
public class AuthHandler {

  @Autowired
  private CacheManager cacheManager;

  @Autowired
  private QiniuOssService qiniuOssService;

  @Autowired
  private AttachmentAuthService attachmentAuthService;

  @Autowired
  private AttachmentService attachmentService;

  @Autowired
  private CacheLock cacheLock;

  private static String lock_pre = "attachment_";

  @Transactional(rollbackFor = Exception.class)
  public JsonNode getRedirectString(String curUserId, String fileId) {
    ObjectNode node = JsonUtils.mapper.createObjectNode();
    Assert.notNull(fileId, "fileId can not be null");
    // 验证登录
    boolean hasauth = false;
    // 查询url
    String file = cacheManager.getCache(CacheName.ATTACHMENT_ID_URL).get(fileId, String.class);
    if (StringUtils.isBlank(file)) {
      Map map = cacheLock.lock(lock_pre + fileId, () -> {
        Map result = Maps.newHashMap();
        boolean checkAuth = false;
        // 需要查询出该url所有权限列表验证权限并放入cache
        List<Map<String, String>> attachmentAuths = attachmentAuthService.findAuthList(fileId);
        if (!attachmentAuths.isEmpty()) {
          String[] arr = new String[attachmentAuths.size()];
          for (int i = 0; i < attachmentAuths.size(); i++) {
            String userId = attachmentAuths.get(i).get("userId");
            arr[i] = userId;
            if (userId.equalsIgnoreCase(curUserId)) {
              checkAuth = true;
            }
          }
          cacheManager.getCache(CacheName.ATTACHMENT_ID_URL).put(fileId, attachmentAuths.get(0).get("url"));
          cacheManager.getCache(CacheName.ATTACHMENT_ID_LIST).setsOfAdd(fileId, true, arr);
          result.put("url", attachmentAuths.get(0).get("url"));
        }
        result.put("hasauth", checkAuth);
        return result;
      }, 10000);
      hasauth = (boolean) map.get("hasauth");
      file = (String) map.get("url");
    } else {
      // 验证是否在权限列表里
      if (cacheManager.getCache(CacheName.ATTACHMENT_ID_LIST).setsOfIsMember(fileId, curUserId)) {
        hasauth = true;
      }
    }
    if (hasauth) {
      String url = qiniuOssService.getDownloadToken(null, file, true);
      node.put("url", url);
    }
    node.put("hasauth", hasauth);
    return node;
  }

  public String getRedirectInternalsString(String file, String fileId) {
    String url = "";
    if(file != null) {
      url = qiniuOssService.getDownloadToken(null, file, true);
    } else {
      Attachment attachment = attachmentService.findById(fileId);
      if(attachment != null){
        url = qiniuOssService.getDownloadToken(null, attachment.getUrl(), true);
      }
    }
    return url;
  }
}
