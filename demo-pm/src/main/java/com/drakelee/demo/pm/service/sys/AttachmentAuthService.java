package com.drakelee.demo.pm.service.sys;

import com.google.common.collect.Lists;
import com.base.components.cache.CacheManager;
import com.drakelee.demo.cache.CacheName;
import com.base.components.common.constants.sys.Pages;
import com.drakelee.demo.common.domain.sys.AttachmentAuth;
import com.base.components.common.dto.page.DataPage;
import com.drakelee.demo.database.dao.sys.AttachmentAuthDao;
import com.base.components.database.service.AbstractJpaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * AttachmentAuthService 附件
 *
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/3/20 0020 10:23
 */
@Service
public class AttachmentAuthService extends AbstractJpaService<AttachmentAuth, String, AttachmentAuthDao> {

  @Autowired
  private CacheManager cacheManager;

  public List<Map<String, String>> findAuthList(String attachmentId) {
    return getDao().findAuthList(attachmentId);
  }

  /**
   * 添加权限记录列表
   *
   * @param attachementId  附件id
   * @param url            附件地址
   * @param userIds        权限列表
   */
  @Transactional(rollbackFor = Exception.class)
  public void addAttachmentAuths(String attachementId, String url, List<String> userIds) {
    List list = Lists.newArrayList();
    for (String userId : userIds) {
      AttachmentAuth auth = new AttachmentAuth();
      auth.setUrl(url);
      auth.setAttachmentId(attachementId);
      auth.setUserId(userId);
      list.add(auth);
    }
    getDao().saveAll(list);
  }

  public DataPage<Map> searchCollectData(Integer fileType, String userId, Map<String, String> params) {
    return getDao()
      .searchCollectData(fileType, userId, Pages.Helper.pageNum(params.get("pageNum")),
                         Pages.Helper.pageNum(params.get("pageSize"))
      );
  }

  /**
   *  赋予权限
   * @param id 附件id
   * @param url 附件url
   * @param userIds 需要赋予权限的id
   */
  public void giveAuth(String id, String url, ArrayList<String> userIds) {
    List<String> authids = getDao().findUserIdById(id);
    // 取差集
    userIds.removeAll(authids);

    List list = Lists.newArrayList();
    for (String userId : userIds) {
      AttachmentAuth attachmentAuth = new AttachmentAuth();
      attachmentAuth.setUserId(userId);
      attachmentAuth.setAttachmentId(id);
      attachmentAuth.setUrl(url);
      list.add(attachmentAuth);
    }
    if(list.size() > 0){
      getDao().saveAll(list);
      // 刷新cache 如果还未存入缓存，则没有ATTACHMENT_ID_URL 会重新写入缓存，如果有，直接加入权限
      cacheManager.getCache(CacheName.ATTACHMENT_ID_LIST).setsOfAdd(id, true, userIds);
    }
  }
}
