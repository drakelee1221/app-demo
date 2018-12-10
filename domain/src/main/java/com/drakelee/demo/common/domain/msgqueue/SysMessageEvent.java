package com.drakelee.demo.common.domain.msgqueue;

import com.base.components.common.service.message.MessageEvent;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;



/**
 * 消息队列事件
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2017-11-15
 */
@Entity
@Table(name = "sys_message_event")
public class SysMessageEvent implements MessageEvent,Serializable {
  private static final long serialVersionUID = 1L;

  /** id - 消息队列会以此ID作为消息体进行发送 */
  private String id;

  /** channel - 业务channel */
  private String channel;

  /** event_info_json - 业务Json */
  private String eventInfoJson;

  /** has_done - 是否已完成，-1 = 执行中，0 = 未完成，1 = 完成 */
  private Integer hasDone;

  /** create_time - 创建时间 */
  private java.util.Date createTime;

  /** sender_info - 发送者调用栈信息 */
  private String senderInfo;

  /** send_time - 发送时间 */
  private java.util.Date sendTime;

  /** send_count - 被发送的次数 */
  private Integer sendCount;

  /** done_server - 完成调用的服务名 */
  private String doneServer;

  /** done_host - 完成调用的服务host */
  private String doneHost;

  /** done_time - 完成时间 */
  private java.util.Date doneTime;

  /** error_time - 最近发生异常的时间 */
  private java.util.Date errorTime;

  /** error_stack - 最近异常栈信息 */
  private String errorStack;

  /** remark - 备注 */
  private String remark;



  @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator = "uuid2")
  @Column(name = "id", nullable = false)
  @Override
  public String getId() {
    return this.id;
  }

  @Column(name = "channel", nullable = false)
  public String getChannel() {
    return channel;
  }

  @Column(name = "event_info_json", nullable = false)
  @Override
  public String getEventInfoJson() {
    return eventInfoJson;
  }

  @Column(name = "has_done", nullable = false)
  public Integer getHasDone() {
    return hasDone;
  }

  @Column(name = "create_time", nullable = false)
  public java.util.Date getCreateTime() {
    return createTime;
  }

  @Column(name = "sender_info", nullable = false)
  public String getSenderInfo() {
    return senderInfo;
  }

  @Column(name = "send_time", nullable = false)
  public java.util.Date getSendTime() {
    return sendTime;
  }

  @Column(name = "send_count", nullable = false)
  public Integer getSendCount() {
    return sendCount;
  }

  @Column(name = "done_server")
  public String getDoneServer() {
    return doneServer;
  }

  @Column(name = "done_host")
  public String getDoneHost() {
    return doneHost;
  }

  @Column(name = "done_time")
  public java.util.Date getDoneTime() {
    return doneTime;
  }

  @Column(name = "error_time")
  public java.util.Date getErrorTime() {
    return errorTime;
  }

  @Column(name = "error_stack")
  public String getErrorStack() {
    return errorStack;
  }

  @Column(name = "remark")
  @Override
  public String getRemark() {
    return remark;
  }

  public void setId(String id) {
    this.id = id;
  }

  public void setChannel(String channel) {
    this.channel = channel;
  }

  public void setEventInfoJson(String eventInfoJson) {
    this.eventInfoJson = eventInfoJson;
  }

  public void setHasDone(Integer hasDone) {
    this.hasDone = hasDone;
  }

  public void setCreateTime(java.util.Date createTime) {
    this.createTime = createTime;
  }

  public void setSenderInfo(String senderInfo) {
    this.senderInfo = senderInfo;
  }

  public void setSendTime(java.util.Date sendTime) {
    this.sendTime = sendTime;
  }

  public void setSendCount(Integer sendCount) {
    this.sendCount = sendCount;
  }

  public void setDoneServer(String doneServer) {
    this.doneServer = doneServer;
  }

  public void setDoneHost(String doneHost) {
    this.doneHost = doneHost;
  }

  public void setDoneTime(java.util.Date doneTime) {
    this.doneTime = doneTime;
  }

  public void setErrorTime(java.util.Date errorTime) {
    this.errorTime = errorTime;
  }

  public void setErrorStack(String errorStack) {
    this.errorStack = errorStack;
  }

  public void setRemark(String remark) {
    this.remark = remark;
  }

}