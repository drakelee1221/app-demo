package com.drakelee.demo.common.domain.sys;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;



/**
 * 短信发送记录
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-06-22
 */
@Entity
@Table(name = "base_sms_send_record")
@TableName("base_sms_send_record")
public class SmsSendRecord implements Serializable  {
  private static final long serialVersionUID = 1L;

    @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator="uuid2")
  @TableId(value = "id")
  @Column(name = "id", nullable = false)
  private String  id ;
    
  /** sms_id -  */
  @TableField(value = "sms_id")
  @Column(name = "sms_id", nullable = false)
  private String  smsId ;

  /** template_id -  */
  @TableField(value = "template_id")
  @Column(name = "template_id", nullable = false)
  private String  templateId ;

  /** template_name -  */
  @TableField(value = "template_name")
  @Column(name = "template_name", nullable = false)
  private String  templateName ;

  /** user_id -  */
  @TableField(value = "user_id")
  @Column(name = "user_id")
  private String  userId ;

  /** phone -  */
  @TableField(value = "phone")
  @Column(name = "phone", nullable = false)
  private String  phone ;

  /** status -  */
  @TableField(value = "status")
  @Column(name = "status", nullable = false)
  private Integer  status ;

  /** send_time -  */
  @TableField(value = "send_time")
  @Column(name = "send_time")
  private java.util.Date  sendTime ;

  /** create_time -  */
  @TableField(value = "create_time")
  @Column(name = "create_time", nullable = false)
  private java.util.Date  createTime ;

  /** batch -  */
  @TableField(value = "batch")
  @Column(name = "batch", nullable = false)
  private String  batch ;

  /** user_name -  */
  @TableField(value = "user_name")
  @Column(name = "user_name")
  private String  userName ;

  /** remarks -  */
  @TableField(value = "remarks")
  @Column(name = "remarks")
  private String  remarks ;

  

    public String  getId  () {
        return this.id;
      }
  
    public String  getSmsId  () {
    return smsId;
  }

    public String  getTemplateId  () {
    return templateId;
  }

    public String  getTemplateName  () {
    return templateName;
  }

    public String  getUserId  () {
    return userId;
  }

    public String  getPhone  () {
    return phone;
  }

    public Integer  getStatus  () {
    return status;
  }

    public java.util.Date  getSendTime  () {
    return sendTime;
  }

    public java.util.Date  getCreateTime  () {
    return createTime;
  }

    public String  getBatch  () {
    return batch;
  }

    public String  getUserName  () {
    return userName;
  }

    public String  getRemarks  () {
    return remarks;
  }

  
    public void setId (String  id) {
        this.id = id;
      }

  
    public void setSmsId (String  smsId) {
    this.smsId = smsId;
  }
    public void setTemplateId (String  templateId) {
    this.templateId = templateId;
  }
    public void setTemplateName (String  templateName) {
    this.templateName = templateName;
  }
    public void setUserId (String  userId) {
    this.userId = userId;
  }
    public void setPhone (String  phone) {
    this.phone = phone;
  }
    public void setStatus (Integer  status) {
    this.status = status;
  }
    public void setSendTime (java.util.Date  sendTime) {
    this.sendTime = sendTime;
  }
    public void setCreateTime (java.util.Date  createTime) {
    this.createTime = createTime;
  }
    public void setBatch (String  batch) {
    this.batch = batch;
  }
    public void setUserName (String  userName) {
    this.userName = userName;
  }
    public void setRemarks (String  remarks) {
    this.remarks = remarks;
  }
  
  }