

package com.drakelee.demo.pm.listener.user;

import com.base.components.cache.msgqueue.service.BaseSyncChannelMessageListener;
import com.base.components.common.constants.msgqueue.Channel;
import com.fasterxml.jackson.databind.JsonNode;
import com.drakelee.demo.common.constants.msgqueue.channels.MessageChannel;
import com.drakelee.demo.common.domain.demo.Demo;
import com.drakelee.demo.pm.service.demo.DemoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.Serializable;
import java.util.Date;

/**
 * TestListener
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2018-05-17 14:08
 */
@Component
public class TestListener extends BaseSyncChannelMessageListener {
  @Autowired
  private DemoService demoService;
  @Override
  protected Serializable onSyncMessage(Channel messageChannel, JsonNode eventInfoJson, String remark, boolean isSyncSender) throws Exception {
    Demo d = new Demo();
    d.setName("TestListener");
    d.setCreateTime(new Date());
    demoService.save(d);
    System.err.println("@@@@@@@@@@@@@@@@@@@@@@@" + eventInfoJson);
    System.err.println("!!!!!!!!!!!!!!!!!!!!!" + messageChannel);
    return d;
  }

  @Override
  public MessageChannel[] registerChannels() {
    return new MessageChannel[]{MessageChannel.TEST_CHANNEL};
  }
}
