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
 * 短信模板参数
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-06-22
 */
@Entity
@Table(name = "base_sms_template_param")
@TableName("base_sms_template_param")
public class SmsTemplateParam implements Serializable {
  private static final long serialVersionUID = 1L;

  @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator = "uuid2")
  @TableId(value = "id")
  @Column(name = "id", nullable = false)
  private String id;

  /** template_id - */
  @TableField(value = "template_id")
  @Column(name = "template_id", nullable = false)
  private String templateId;

  /** param_code - */
  @TableField(value = "param_code")
  @Column(name = "param_code", nullable = false)
  private String paramCode;

  /** param_name - */
  @TableField(value = "param_name")
  @Column(name = "param_name", nullable = false)
  private String paramName;

  /** type - */
  @TableField(value = "type")
  @Column(name = "type", nullable = false)
  private Integer type;

  /** sys_param_type - */
  @TableField(value = "sys_param_type")
  @Column(name = "sys_param_type")
  private String sysParamType;

  public String getSysParamType() {
    return sysParamType;
  }

  public void setSysParamType(String sysParamType) {
    this.sysParamType = sysParamType;
  }

  public String getId() {
    return this.id;
  }

  public String getTemplateId() {
    return templateId;
  }

  public String getParamCode() {
    return paramCode;
  }

  public String getParamName() {
    return paramName;
  }

  public Integer getType() {
    return type;
  }


  public void setId(String id) {
    this.id = id;
  }


  public void setTemplateId(String templateId) {
    this.templateId = templateId;
  }

  public void setParamCode(String paramCode) {
    this.paramCode = paramCode;
  }

  public void setParamName(String paramName) {
    this.paramName = paramName;
  }

  public void setType(Integer type) {
    this.type = type;
  }

}