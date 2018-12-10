package com.drakelee.demo.pm.controller.sys;

import com.base.components.common.constants.msgqueue.Channel;
import com.base.components.common.exception.business.BusinessException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.drakelee.demo.common.constants.sys.GatewayPath;
import com.drakelee.demo.pm.service.sys.SendMessageService;
import me.chanjar.weixin.common.error.WxErrorException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.util.Map;

/**
 * SendMessageController
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/4/13 0013 16:22
 */
@RestController
public class SendMessageController {

  @Autowired
  SendMessageService sendMessageService;


  /**
   * 发送站内信
   *
   * @param params
   *
   * @return
   *
   * @throws Exception
   */
  @PostMapping(path = GatewayPath.API_PM + "/sys/sendSysTemplateMsg", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public boolean sendSysTemplateMsg(@RequestBody Map<String, String> params) {
    String channel = params.get("channel");
    String objectNodeStr = params.get("objectNode");
    ObjectMapper mapper = new ObjectMapper();
    JsonNode actualObj = null;
    try {
      actualObj = mapper.readTree(objectNodeStr);
    } catch (IOException e) {
      e.printStackTrace();
      throw new BusinessException("参数错误");
    }
    return sendMessageService.sendSysTemplateMsg(Channel.parse(channel), (ObjectNode) actualObj);
  }

  /**
   * 发送短信
   *
   * @param params
   *
   * @return
   *
   * @throws Exception
   */
  @PostMapping(path = GatewayPath.API_PM + "/sys/sendSmsTemplateMsg", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public boolean sendSmsTemplateMsg(@RequestBody Map<String, String> params) {
    String channel = params.get("channel");
    String objectNodeStr = params.get("objectNode");
    ObjectMapper mapper = new ObjectMapper();
    JsonNode actualObj = null;
    try {
      actualObj = mapper.readTree(objectNodeStr);
    } catch (IOException e) {
      e.printStackTrace();
      throw new BusinessException("参数错误");
    }
    return sendMessageService.sendSmsTemplateMsg(Channel.parse(channel), (ObjectNode) actualObj);
  }


  /**
   * 发送微信模板消息
   *
   * @param params
   *
   * @return
   *
   * @throws Exception
   */
  @PostMapping(path = GatewayPath.API_PM + "/sys/sendWechatTemplateMsg", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public boolean sendWechatTemplateMsg(@RequestBody Map<String, String> params) throws WxErrorException {
    String channel = params.get("channel");
    String objectNodeStr = params.get("objectNode");
    ObjectMapper mapper = new ObjectMapper();
    JsonNode actualObj = null;
    try {
      actualObj = mapper.readTree(objectNodeStr);
    } catch (IOException e) {
      e.printStackTrace();
      throw new BusinessException("参数错误");
    }
    return sendMessageService.sendWechatTemplateMsg(Channel.parse(channel), (ObjectNode) actualObj);
  }


}
