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
 * 短信
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-06-27
 */
@Entity
@Table(name = "base_sms")
@TableName("base_sms")
public class Sms implements Serializable  {
  private static final long serialVersionUID = 1L;

    @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator="uuid2")
  @TableId(value = "id")
  @Column(name = "id", nullable = false)
  private String  id ;
    
  /** remarks -  */
  @TableField(value = "remarks")
  @Column(name = "remarks")
  private String  remarks ;

  /** create_time -  */
  @TableField(value = "create_time")
  @Column(name = "create_time", nullable = false)
  private java.util.Date  createTime ;

  /** author_id -  */
  @TableField(value = "author_id")
  @Column(name = "author_id", nullable = false)
  private String  authorId ;

  /** status - 0、未发送 1、已发送 2、未完成 */
  @TableField(value = "status")
  @Column(name = "status", nullable = false)
  private Integer  status ;

  /** send_time -  */
  @TableField(value = "send_time")
  @Column(name = "send_time")
  private java.util.Date  sendTime ;

  /** type - 0 系统发送，1 后台管理发送，template_id 短信模板id */
  @TableField(value = "type")
  @Column(name = "type", nullable = false)
  private Integer  type ;

  /** template_id -  */
  @TableField(value = "template_id")
  @Column(name = "template_id")
  private String  templateId ;

  /** batch -  */
  @TableField(value = "batch")
  @Column(name = "batch")
  private String  batch ;

  /** param_json -  */
  @TableField(value = "param_json")
  @Column(name = "param_json")
  private String  paramJson ;

  /** sms_channel - 短信通道 */
  @TableField(value = "sms_channel")
  @Column(name = "sms_channel")
  private Integer  smsChannel ;

  /** user_filter - 接收短信的user过滤条件 */
  @TableField(value = "user_filter")
  @Column(name = "user_filter")
  private String  userFilter ;

  /** sms_send_mode - 短信发送模式，0 系统用户，1 只输手机号 */
  @TableField(value = "sms_send_mode")
  @Column(name = "sms_send_mode")
  private Integer  smsSendMode ;

  

    public String  getId  () {
        return this.id;
      }
  
    public String  getRemarks  () {
    return remarks;
  }

    public java.util.Date  getCreateTime  () {
    return createTime;
  }

    public String  getAuthorId  () {
    return authorId;
  }

    public Integer  getStatus  () {
    return status;
  }

    public java.util.Date  getSendTime  () {
    return sendTime;
  }

    public Integer  getType  () {
    return type;
  }

    public String  getTemplateId  () {
    return templateId;
  }

    public String  getBatch  () {
    return batch;
  }

    public String  getParamJson  () {
    return paramJson;
  }

    public Integer  getSmsChannel  () {
    return smsChannel;
  }

    public String  getUserFilter  () {
    return userFilter;
  }

    public Integer  getSmsSendMode  () {
    return smsSendMode;
  }

  
    public void setId (String  id) {
        this.id = id;
      }

  
    public void setRemarks (String  remarks) {
    this.remarks = remarks;
  }
    public void setCreateTime (java.util.Date  createTime) {
    this.createTime = createTime;
  }
    public void setAuthorId (String  authorId) {
    this.authorId = authorId;
  }
    public void setStatus (Integer  status) {
    this.status = status;
  }
    public void setSendTime (java.util.Date  sendTime) {
    this.sendTime = sendTime;
  }
    public void setType (Integer  type) {
    this.type = type;
  }
    public void setTemplateId (String  templateId) {
    this.templateId = templateId;
  }
    public void setBatch (String  batch) {
    this.batch = batch;
  }
    public void setParamJson (String  paramJson) {
    this.paramJson = paramJson;
  }
    public void setSmsChannel (Integer  smsChannel) {
    this.smsChannel = smsChannel;
  }
    public void setUserFilter (String  userFilter) {
    this.userFilter = userFilter;
  }
    public void setSmsSendMode (Integer  smsSendMode) {
    this.smsSendMode = smsSendMode;
  }
  
  }