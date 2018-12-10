

package com.drakelee.demo.common.domain.user;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;



/**
 * 微信公众号消息发送记录
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-03-16
 */
@Entity
@Table(name = "base_weixin_msg_log")
public class WeixinMsgLog implements Serializable {
  private static final long serialVersionUID = 1L;

  /** id - */
  private String id;

  /** user_id - 发送者id */
  private String userId;

  /** receive_id - 接受用户id */
  private String receiveId;

  /** open_id - openid */
  private String openId;

  /** msg_id - 消息id */
  private String msgId;

  /** template_id - 消息模板id */
  private String templateId;

  /** send_time - 发送时间 */
  private java.util.Date sendTime;

  /** recevie_status - 接受状态 */
  private Integer recevieStatus;

  /** wx_name - 微信名称 */
  private String wxName;

  /** template_name - 模板名称 */
  private String templateName;

  @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator = "uuid2")
  @Column(name = "id", nullable = false)
  public String getId() {
    return this.id;
  }

  @Column(name = "user_id")
  public String getUserId() {
    return userId;
  }

  @Column(name = "receive_id")
  public String getReceiveId() {
    return receiveId;
  }

  @Column(name = "open_id")
  public String getOpenId() {
    return openId;
  }

  @Column(name = "msg_id")
  public String getMsgId() {
    return msgId;
  }

  @Column(name = "template_id")
  public String getTemplateId() {
    return templateId;
  }

  @Column(name = "send_time")
  public java.util.Date getSendTime() {
    return sendTime;
  }

  @Column(name = "recevie_status")
  public Integer getRecevieStatus() {
    return recevieStatus;
  }

  @Column(name = "wx_name")
  public String getWxName() {
    return wxName;
  }
  @Column(name = "template_name")
  public String getTemplateName() {
    return templateName;
  }

  public void setId(String id) {
    this.id = id;
  }

  public void setUserId(String userId) {
    this.userId = userId;
  }

  public void setReceiveId(String receiveId) {
    this.receiveId = receiveId;
  }

  public void setOpenId(String openId) {
    this.openId = openId;
  }

  public void setMsgId(String msgId) {
    this.msgId = msgId;
  }

  public void setTemplateId(String templateId) {
    this.templateId = templateId;
  }

  public void setSendTime(java.util.Date sendTime) {
    this.sendTime = sendTime;
  }

  public void setRecevieStatus(Integer recevieStatus) {
    this.recevieStatus = recevieStatus;
  }

  public void setWxName(String wxName) {
    this.wxName = wxName;
  }

  public void setTemplateName(String templateName) {
    this.templateName = templateName;
  }
}