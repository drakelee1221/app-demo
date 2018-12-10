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
 * 短信模板
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-06-22
 */
@Entity
@Table(name = "base_sms_template")
@TableName("base_sms_template")
public class SmsTemplate implements Serializable  {
  private static final long serialVersionUID = 1L;

    @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator="uuid2")
  @TableId(value = "id")
  @Column(name = "id", nullable = false)
  private String  id ;
    
  /** tpl_name -  */
  @TableField(value = "tpl_name")
  @Column(name = "tpl_name", nullable = false)
  private String  tplName ;

  /** type_name -  */
  @TableField(value = "type_name")
  @Column(name = "type_name", nullable = false)
  private String  typeName ;

  /** content -  */
  @TableField(value = "content")
  @Column(name = "content", nullable = false)
  private String  content ;

  /** ali_sms_id -  */
  @TableField(value = "ali_sms_id")
  @Column(name = "ali_sms_id")
  private String  aliSmsId ;

  /** status - 0、未发送 1、已发送 */
  @TableField(value = "status")
  @Column(name = "status", nullable = false)
  private Integer  status ;

  /** create_time -  */
  @TableField(value = "create_time")
  @Column(name = "create_time", nullable = false)
  private java.util.Date  createTime ;

  

    public String  getId  () {
        return this.id;
      }
  
    public String  getTplName  () {
    return tplName;
  }

    public String  getTypeName  () {
    return typeName;
  }

    public String  getContent  () {
    return content;
  }

    public String  getAliSmsId  () {
    return aliSmsId;
  }

    public Integer  getStatus  () {
    return status;
  }

    public java.util.Date  getCreateTime  () {
    return createTime;
  }

  
    public void setId (String  id) {
        this.id = id;
      }

  
    public void setTplName (String  tplName) {
    this.tplName = tplName;
  }
    public void setTypeName (String  typeName) {
    this.typeName = typeName;
  }
    public void setContent (String  content) {
    this.content = content;
  }
    public void setAliSmsId (String  aliSmsId) {
    this.aliSmsId = aliSmsId;
  }
    public void setStatus (Integer  status) {
    this.status = status;
  }
    public void setCreateTime (java.util.Date  createTime) {
    this.createTime = createTime;
  }
  
  }