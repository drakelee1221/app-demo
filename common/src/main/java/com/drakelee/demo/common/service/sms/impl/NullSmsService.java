package com.drakelee.demo.common.service.sms.impl;

import com.drakelee.demo.common.constants.sms.SmsTemplateId;
import com.drakelee.demo.common.service.sms.SmsService;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * 短信服务具体实现
 *
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/3/26 0026 14:10
 */
@Service
@ConditionalOnProperty(name = "base.sms.enable", havingValue = "false")
public class NullSmsService implements SmsService {

  /**
   * 异步发送短信
   *
   * @param phone 非空，手机号
   * @param content 可空，发送内容，根据服务商规则与templateId二选一选填
   * @param templateId 可空，发送内容模板ID，根据服务商规则与content二选一选填
   * @param extras 可空，拓展参数，根据具体的短信服务实现传参，参数格式见{@link SmsTemplateId}
   */
  @Override
  public void sendSmsAsync(String phone, String content, SmsTemplateId templateId, Map<String, Object> extras) {
  }

  @Override
  public boolean sendSmsSync(String phone, String content, SmsTemplateId templateId, Map<String, Object> extras) {
    return false;
  }

  @Override
  public void sendSmsAsync(String phone, String content, String templateId, Map<String, Object> extras) {

  }

  @Override
  public boolean sendSmsSync(String phone, String content, String templateId, Map<String, Object> extras) {
    return false;
  }
}