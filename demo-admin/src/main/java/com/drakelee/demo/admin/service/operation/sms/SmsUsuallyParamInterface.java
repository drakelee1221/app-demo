package com.drakelee.demo.admin.service.operation.sms;

import com.drakelee.demo.common.domain.sys.SmsSendRecord;

import java.util.List;
import java.util.Map;

/**
 * SmsUsuallyParamInterface
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-06-25 11:49
 */
public interface SmsUsuallyParamInterface {
  /**
   * 获取参数值
   * @param record
   * @param code
   * @param extraParam
   * @return
   */
  Map<String,Object> loadParamValues(SmsSendRecord record, List<String> code, Map<String, Object> extraParam);


}
