package com.drakelee.demo.admin.service.operation.sms;

import com.drakelee.demo.common.domain.sys.SmsSendRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * SmsUsuallyService
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-06-25 11:51
 */
@Service
@RefreshScope
@ConfigurationProperties("base.admin.sms.param")
public class SmsUsuallyParamService {

  @Autowired
  private Map<String,SmsUsuallyParamInterface> paramInterface;
  /**
   * 业务类型与参数接口实现关系映射
   */
  private Map<String,String> mapping;


  public Map<String, Object> execute(SmsSendRecord record,String type,List<String> code,Map<String, Object> extra) {
    return paramInterface.get(mapping.get(type)).loadParamValues(record,code,extra);
  }

  public Map<String, String> getMapping() {
    return mapping;
  }

  public void setMapping(Map<String, String> mapping) {
    this.mapping = mapping;
  }
}
