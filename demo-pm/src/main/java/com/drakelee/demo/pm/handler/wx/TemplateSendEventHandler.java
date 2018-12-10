package com.drakelee.demo.pm.handler.wx;

import com.drakelee.demo.pm.service.user.WeChatService;
import com.drakelee.demo.pm.service.user.WeChatService;
import me.chanjar.weixin.common.error.WxErrorException;
import me.chanjar.weixin.common.session.WxSessionManager;
import me.chanjar.weixin.mp.api.WxMpMessageHandler;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.bean.message.WxMpXmlMessage;
import me.chanjar.weixin.mp.bean.message.WxMpXmlOutMessage;
import me.chanjar.weixin.mp.bean.message.WxMpXmlOutTextMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * 模板消息发送后事件处理类
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-03-17 11:27
 */
@Component
public class TemplateSendEventHandler implements WxMpMessageHandler {
  @Autowired
  private WeChatService weChatService;

  @Override
  public WxMpXmlOutMessage handle(WxMpXmlMessage wxMessage, Map<String, Object> context, WxMpService wxMpService,
                                  WxSessionManager sessionManager) throws WxErrorException {
    Long msgId = wxMessage.getMsgId();
    weChatService.updateMsgStatus(msgId, wxMessage.getStatus());
    WxMpXmlOutTextMessage wxMpXmlOutTextMessage = new WxMpXmlOutTextMessage();
    wxMpXmlOutTextMessage.setContent("success");
    return wxMpXmlOutTextMessage;
  }

  public static void main(String[] args) {
    System.out.println(System.currentTimeMillis());
  }
}
