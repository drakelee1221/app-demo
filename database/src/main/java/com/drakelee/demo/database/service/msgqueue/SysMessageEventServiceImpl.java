

package com.drakelee.demo.database.service.msgqueue;

import com.base.components.common.constants.msgqueue.MessageChannelStatus;
import com.base.components.common.service.message.MessageEvent;
import com.base.components.common.service.message.SysMessageEventService;
import com.base.components.database.dao.base.condition.ConditionEnum;
import com.base.components.database.dao.base.condition.ConditionGroup;
import com.base.components.database.service.AbstractJpaService;
import com.drakelee.demo.database.dao.msgqueue.SysMessageEventDao;
import com.drakelee.demo.database.dao.msgqueue.SysMessageEventErrorDao;
import com.drakelee.demo.database.dao.sys.SysMessageEventHandleDao;
import com.fasterxml.jackson.databind.JsonNode;
import com.drakelee.demo.common.domain.msgqueue.SysMessageEvent;
import com.drakelee.demo.common.domain.msgqueue.SysMessageEventError;
import com.drakelee.demo.common.domain.sys.SysMessageEventHandle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import javax.annotation.PostConstruct;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Date;

/**
 * SysMessageEvent Service
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2017-11-15
 */
@Service
public class SysMessageEventServiceImpl extends AbstractJpaService<SysMessageEvent, String, SysMessageEventDao>
  implements SysMessageEventService {

  @Autowired
  private SysMessageEventErrorDao sysMessageEventErrorDao;
  @Autowired
  private SysMessageEventHandleDao sysMessageEventHandleDao;

  @Value("${server.port}")
  private String serverPort;

  @Value("${spring.application.name}")
  private String serverName;

  private static String serverHost;

  @PostConstruct
  public void init() {
    try {
      serverHost = InetAddress.getLocalHost().getHostAddress() + ":" + serverPort;
    } catch (UnknownHostException e) {
      serverHost = "http://localhost:" + serverPort;
    }
  }

  @Override
  @Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRES_NEW)
  public String createHandle(String id, String listenerId, String listenerClass) throws Exception {
    SysMessageEventHandle handle = new SysMessageEventHandle();
    handle.setEventId(id);
    handle.setListenerId(listenerId);
    handle.setHasDone(MessageChannelStatus.DOING);
    handle.setListenerClass(listenerClass);
    handle.setCreateTime(new Date());
    handle.setDoneServer(serverName);
    handle = sysMessageEventHandleDao.save(handle);
    return handle.getId();
  }

  @Override
  @Transactional(rollbackFor = Exception.class)
  public SysMessageEvent findById(String id) {
    return super.findById(id);
  }

  @Override
  @Transactional(rollbackFor = Exception.class)
  public MessageEvent save(StackTraceElement stack, String messageChannel, JsonNode eventInfoJson, String remark) {
    SysMessageEvent message = createMessage(stack, messageChannel, eventInfoJson, remark);
    return getDao().saveAndFlush(message);
  }

  @Override
  @Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRES_NEW)
  public MessageEvent saveWithNewTx(StackTraceElement stack, String messageChannel, JsonNode eventInfoJson,
                                    String remark) {
    SysMessageEvent message = createMessage(stack, messageChannel, eventInfoJson, remark);
    return getDao().saveAndFlush(message);
  }

  @Override
  @Transactional(rollbackFor = Exception.class)
  public boolean existsById(String id) {
    return getDao().existsById(id);
  }

  @Override
  @Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRES_NEW)
  public boolean existsByIdWithNewTx(String id) {
    return getDao().existsById(id);
  }

  @Override
  @Transactional(rollbackFor = Exception.class, propagation = Propagation.REQUIRES_NEW)
  public void updateDoing(String handleId, String channelId, String error) {
    SysMessageEventHandle eventHandle = sysMessageEventHandleDao.findOne(
      ConditionGroup.build().addCondition("id", ConditionEnum.OPERATE_EQUAL, handleId)
                    .addCondition("hasDone", ConditionEnum.OPERATE_EQUAL, MessageChannelStatus.DOING)).orElse(null);
    Assert.notNull(eventHandle, "SysMessageEventHandle is not exists (" + handleId + ") !");
    Date now = new Date();
    eventHandle.setDoneServer(serverName);
    eventHandle.setDoneHost(serverHost);
    eventHandle.setDoneTime(now);
    if (error != null) {
      eventHandle.setErrorStack(error);
      eventHandle.setErrorTime(now);
      eventHandle.setHasDone(MessageChannelStatus.ERROR);
      SysMessageEventError errorLog = new SysMessageEventError();
      errorLog.setChannel(channelId);
      errorLog.setErrorHost(serverHost);
      errorLog.setErrorServer(serverName);
      errorLog.setErrorStack(error);
      errorLog.setMessageId(eventHandle.getId());
      sysMessageEventErrorDao.save(errorLog);
    } else {
      eventHandle.setHasDone(MessageChannelStatus.DONE);
    }
    sysMessageEventHandleDao.saveAndFlush(eventHandle);
  }


  private SysMessageEvent createMessage(StackTraceElement stack, String messageChannel, JsonNode eventInfoJson,
                                        String remark) {
    Assert.notNull(messageChannel, "messageChannel is not null !");
    SysMessageEvent event = new SysMessageEvent();
    event.setChannel(messageChannel);
    if (eventInfoJson != null) {
      event.setEventInfoJson(eventInfoJson.toString());
    }
    Date now = new Date();
    event.setCreateTime(now);
    event.setHasDone(MessageChannelStatus.DONE);
    event.setSenderInfo(stack.getClassName() + "#" + stack.getMethodName() + "-" + stack.getLineNumber());
    event.setSendTime(now);
    event.setSendCount(1);
    event.setRemark(remark);
    return event;
  }

}