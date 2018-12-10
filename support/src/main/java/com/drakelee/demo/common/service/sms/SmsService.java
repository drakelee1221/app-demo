

package com.drakelee.demo.common.service.sms;


import com.drakelee.demo.common.constants.sms.SmsTemplateId;

import java.util.Map;

/**
 * 短信服务
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-08-18 11:55
 */
public interface SmsService {

  /**
   * 异步发送短信
   * @param phone             非空，手机号
   * @param content           可空，发送内容，根据服务商规则与templateId二选一选填
   * @param templateId        可空，发送内容模板ID，根据服务商规则与content二选一选填
   * @param extras            可空，拓展参数，根据具体的短信服务实现传参，参数格式见{@link SmsTemplateId}
   */
  void sendSmsAsync(String phone, String content, SmsTemplateId templateId, Map<String, Object> extras);

  /**
   * 同步发送短信
   * @param phone             非空，手机号
   * @param content           可空，发送内容，与templateId二选一
   * @param templateId        可空，发送内容模板ID，与content二选一
   * @param extras            可空，拓展参数，根据具体的短信服务实现传参，参数格式见{@link SmsTemplateId}
   */
  boolean sendSmsSync(String phone, String content, SmsTemplateId templateId, Map<String, Object> extras);

  /**
   * 异步发送短信
   * @param phone             非空，手机号
   * @param content           可空，发送内容，根据服务商规则与templateId二选一选填
   * @param templateId        可空，发送内容模板ID，根据服务商规则与content二选一选填
   * @param extras            可空，拓展参数，根据具体的短信服务实现传参，参数格式见{@link SmsTemplateId}
   */
  void sendSmsAsync(String phone, String content, String templateId, Map<String, Object> extras);

  /**
   * 同步发送短信
   * @param phone             非空，手机号
   * @param content           可空，发送内容，与templateId二选一
   * @param templateId        可空，发送内容模板ID，与content二选一
   * @param extras            可空，拓展参数，根据具体的短信服务实现传参，参数格式见{@link SmsTemplateId}
   */
  boolean sendSmsSync(String phone, String content, String templateId, Map<String, Object> extras);
}
