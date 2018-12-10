package com.drakelee.demo.common.domain.msgqueue;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;



/**
 * @author : code generator
 * @version : 1.0
 * @since : 2017-11-15
 */
@Entity
@Table(name = "sys_message_event_error")
public class SysMessageEventError implements Serializable {
  private static final long serialVersionUID = 1L;

  /** id - */
  private String id;

  /** message_id - 消息事件ID */
  private String messageId;

  /** channel - */
  private String channel;

  /** error_server - 调用异常的服务名 */
  private String errorServer;

  /** error_host - 调用异常的服务host */
  private String errorHost;

  /** error_stack - 异常堆栈 */
  private String errorStack;



  @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator = "uuid2")
  @Column(name = "id", nullable = false)
  public String getId() {
    return this.id;
  }

  @Column(name = "message_id", nullable = false)
  public String getMessageId() {
    return messageId;
  }

  @Column(name = "channel", nullable = false)
  public String getChannel() {
    return channel;
  }

  @Column(name = "error_server", nullable = false)
  public String getErrorServer() {
    return errorServer;
  }

  @Column(name = "error_host", nullable = false)
  public String getErrorHost() {
    return errorHost;
  }

  @Column(name = "error_stack", nullable = false)
  public String getErrorStack() {
    return errorStack;
  }

  public void setId(String id) {
    this.id = id;
  }

  public void setMessageId(String messageId) {
    this.messageId = messageId;
  }

  public void setChannel(String channel) {
    this.channel = channel;
  }

  public void setErrorServer(String errorServer) {
    this.errorServer = errorServer;
  }

  public void setErrorHost(String errorHost) {
    this.errorHost = errorHost;
  }

  public void setErrorStack(String errorStack) {
    this.errorStack = errorStack;
  }

}