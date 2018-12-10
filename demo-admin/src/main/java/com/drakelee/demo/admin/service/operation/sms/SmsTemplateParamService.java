package com.drakelee.demo.admin.service.operation.sms;

import com.drakelee.demo.common.domain.sys.SmsTemplateParam;
import com.drakelee.demo.database.dao.sys.SmsTemplateParamDao;
import com.base.components.database.service.AbstractJpaService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.List;

/**
 * SmsTemplateUsuallyParam Service
 * @author : code generator
 * @version : 1.0
 * @since : 2018-06-09
 */
@Service
public class SmsTemplateParamService extends AbstractJpaService<SmsTemplateParam, String, SmsTemplateParamDao> {
  /**
   * SmsTemplateParam新增和修改
   *
   * @param smsTemplateParam
   *
   * @return
   */
  @Transactional(rollbackFor = Exception.class)
  public SmsTemplateParam saveOrUpdate(SmsTemplateParam smsTemplateParam) {
    return getDao().saveAndFlush(smsTemplateParam);
  }

  /**
   * SmsTemplateParam删除
   * @param ids
   */
  @Transactional(rollbackFor = Exception.class)
  public void delete(Iterable<String> ids) {
    List<SmsTemplateParam> list = getDao().findAllById(ids);
    if(!CollectionUtils.isEmpty(list)){
      getDao().deleteInBatch(list);
    }
  }



}