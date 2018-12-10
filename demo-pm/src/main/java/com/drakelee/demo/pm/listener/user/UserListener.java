package com.drakelee.demo.pm.listener.user;

import com.base.components.cache.msgqueue.service.BaseAsyncChannelMessageListener;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.base.components.common.constants.msgqueue.Channel;
import com.drakelee.demo.common.constants.msgqueue.channels.MessageChannel;
import com.drakelee.demo.pm.service.sys.SendMessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * user
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/3/27 0027 10:59
 */
@Component
public class UserListener extends BaseAsyncChannelMessageListener {
  @Autowired
  private SendMessageService sendMessageService;

  @Override
  protected void onAsyncMessage(Channel messageChannel, JsonNode eventInfoJson, String remark, boolean isSyncSender) throws Exception {
    MessageChannel channel = (MessageChannel) messageChannel;
    sendMessageService.sendSysTemplateMsg(channel, ((ObjectNode) eventInfoJson));
    sendMessageService.sendWechatTemplateMsg(channel,((ObjectNode) eventInfoJson));
  }

  @Override
  public MessageChannel[] registerChannels() {
    return new MessageChannel[] {MessageChannel.USER_LOGIN};
  }
}
