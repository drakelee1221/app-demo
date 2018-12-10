package com.drakelee.demo.pm.service.sys;

import com.base.components.common.constants.Valid;
import com.base.components.common.util.EnumUtil;
import com.base.components.common.util.JsonUtils;
import com.drakelee.demo.pm.service.user.UserBaseInfoService;
import com.drakelee.demo.pm.service.user.WeChatService;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.google.common.collect.Maps;
import com.drakelee.demo.common.constants.KnowStatus;
import com.drakelee.demo.common.constants.msgqueue.channels.MessageChannel;
import com.drakelee.demo.common.constants.sms.SmsTemplateId;
import com.drakelee.demo.common.constants.weChat.WxMsgTemplate;
import com.drakelee.demo.common.domain.sys.SysMessage;
import com.drakelee.demo.common.domain.user.UserBaseInfo;
import com.drakelee.demo.common.service.sms.SmsService;
import com.drakelee.demo.common.service.template.SysMessageManager;
import com.drakelee.demo.database.dao.sys.SysMessageDao;
import com.drakelee.demo.pm.service.user.UserBaseInfoService;
import com.drakelee.demo.pm.service.user.WeChatService;
import me.chanjar.weixin.common.error.WxErrorException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.io.IOException;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;
import java.util.function.BiConsumer;

/**
 * 系统消息service
 *
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/3/20 0020 15:23
 */
@Service
@RefreshScope
public class SendMessageService {

  private static final Logger logger = LoggerFactory.getLogger(SendMessageService.class);

  @Autowired
  private SysMessageDao sysMessageDao;

  @Autowired
  private SysMessageManager.Templates sysMsgTemplates;

  @Autowired
  private WeChatService weChatService;

  @Autowired
  private SmsService smsService;

  @Autowired
  private UserBaseInfoService userBaseInfoService;

  /**
   * 发送站内信模板消息
   *
   * @param messageChannel 消息类型
   * @param params 消息参数
   * <p> targetId  - Notnull  - Str - 发送模板消息的目标id </p>
   *
   * @return
   */
  @Transactional(rollbackFor = Exception.class)
  public boolean sendSysTemplateMsg(MessageChannel messageChannel, ObjectNode params) {
    Assert.notNull(messageChannel, "messageChannel can not be null");
    Assert.notNull(params.get("targetId"), "targetId can not be null");
    String msg = sysMsgTemplates.getSysTemplates().get(messageChannel.toString());
    Assert.notNull(msg, "无法找到该模板消息数据");
    String targetId = params.get("targetId").textValue();
    Iterator<String> fieldNames = params.fieldNames();
    while (fieldNames.hasNext()) {
      String next = fieldNames.next();
      msg = msg.replaceAll("\\{" + next + "}", params.get(next).textValue());
    }
    String bizType = "";
    String bizId = "";
    if (params.has("bizType")) {
      bizType = params.get("bizType").asText();
    } else {
      bizType = messageChannel.getDesc();
    }
    if (params.has("bizId")) {
      bizId = params.get("bizId").asText();
    }
    sendSysMessage(targetId, msg, bizType, bizId);
    return true;
  }



  private void sendSysMessage(String targetId, String content, String bizType, String bizId) {
    SysMessage sysMessage = new SysMessage();
    sysMessage.setUserId(targetId);
    sysMessage.setContent(content);
    sysMessage.setCreateTime(new Date());
    sysMessage.setStatus(KnowStatus.UNREAD.getStatus());
    sysMessage.setBizId(bizId);
    sysMessage.setBizType(bizType);
    sysMessage.setDelFlag(Valid.TRUE.getVal());
    sysMessageDao.save(sysMessage);
  }

  /**
   * 发送微信模板消息
   *
   * @param messageChannel 消息类型
   * @param params 消息参数
   * <p> targetId  - Notnull  - Str - 发送模板消息的目标id </p>
   * <p> localId   - Notnull  - Str - 发送模板消息的用户id </p>
   *
   * @return
   */
  @Transactional(rollbackFor = Exception.class)
  public boolean sendWechatTemplateMsg(MessageChannel messageChannel, ObjectNode params) throws WxErrorException {
    Assert.notNull(messageChannel, "messageChannel can not be null");
    Assert.notNull(params.get("targetId"), "targetId can not be null");
    Assert.notNull(params.get("localId"), "localId can not be null");
    String targetId = params.get("targetId").textValue();
    String localId = params.get("localId").textValue();
    Iterator<String> fieldNames = params.fieldNames();
    Map<String, String> map = Maps.newHashMap();
    while (fieldNames.hasNext()) {
      String next = fieldNames.next();
      map.put(next, params.get(next).textValue());
    }
    weChatService.sendWxMessage(localId, targetId, WxMsgTemplate.parse(messageChannel.toString()), map);
    return true;
  }

  /**
   * 发送短信模板消息
   *
   * @param messageChannel 消息类型
   * @param params 消息参数
   * <p> targetPhone  - Notnull  - Str - 发送模板消息的目标phone </p>
   * <p> targetId     - Notnull  - Str - 发送模板消息的目标id 与phone必有一个 </p>
   * <p> templateId   - Notnull  - Str - 发送模板消息模板类型 </p>
   * <p> templateId   - Notnull  - Str - 发送模板消息模板类型 </p>
   *
   * @return
   */
  public boolean sendSmsTemplateMsg(MessageChannel messageChannel, ObjectNode params) {
    Assert.notNull(messageChannel, "messageChannel can not be null");
    Assert.notNull(params.get("templateId"), "templateId can not be null");
    String targetPhone = params.has("targetPhone") ? params.get("targetPhone").asText() : "";
    String targetId = params.has("targetId") ? params.get("targetId").asText() : "";
    String targetPhoneStr = targetPhone;
    if (org.apache.commons.lang3.StringUtils.isBlank(targetPhoneStr)) {
      UserBaseInfo userBaseInfo = userBaseInfoService.getOne(targetId);
      Assert.notNull(userBaseInfo, "发送短信，未找到对应用户：" + targetId);
      targetPhoneStr = userBaseInfo.getPhone();
      Assert.isTrue(org.apache.commons.lang3.StringUtils.isNotBlank(targetPhoneStr), "用户未设置手机号码：" + targetId);
    }
    logger.debug("接收电话：" + targetPhoneStr);
    String templateId = params.get("templateId").textValue();
    params.remove("templateId");
    params.remove("targetId");
    Map paramsMap = Maps.newHashMap();
    try {
      paramsMap = JsonUtils.reader(params.toString(), Map.class);
    } catch (IOException e) {
      e.printStackTrace();
    }

    paramsMap.forEach(new BiConsumer<String, Object>() {
      @Override
      public void accept(String s, Object o) {
        logger.debug("参数：" + s + ":" + o.toString() + " length " + o.toString().length());
      }
    });
    smsService
      .sendSmsAsync(targetPhoneStr, null, EnumUtil.parse(SmsTemplateId.class, "templateId", templateId), paramsMap);

    return true;
  }

}
