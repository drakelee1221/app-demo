package com.drakelee.demo.common.domain.admin;

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
 * 动态表单数据
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-06-15
 */
@Entity
@Table(name = "base_dynamic_form_data")
@TableName("base_dynamic_form_data")
public class DynamicFormData implements Serializable  {
  private static final long serialVersionUID = 1L;

  @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator="uuid2")
  @TableId(value = "id")
  @Column(name = "id", nullable = false)
  private String  id ;

  /** code - 标识某次表单类型 */
  @TableField(value = "code")
  @Column(name = "code", nullable = false)
  private String  code ;

  /** title - 表单标题 */
  @TableField(value = "title")
  @Column(name = "title", nullable = false)
  private String  title ;

  /** json_data - {"columns":[{"field":"name","title":"名字"},{"field":"sex","title":"性别"}],"data":[{"name":"哈哈哈","sex":"男"},{"name":"tec","sex":"男"}]} */
  @TableField(value = "json_data")
  @Column(name = "json_data")
  private String  jsonData ;

  /** create_time -  */
  @TableField(value = "create_time")
  @Column(name = "create_time", nullable = false)
  private java.util.Date  createTime ;

  /** status -  */
  @TableField(value = "status")
  @Column(name = "status", nullable = false)
  private Integer  status ;



  public String  getId  () {
    return this.id;
  }

  public String  getCode  () {
    return code;
  }

  public String  getTitle  () {
    return title;
  }

  public String  getJsonData  () {
    return jsonData;
  }

  public java.util.Date  getCreateTime  () {
    return createTime;
  }

  public Integer  getStatus  () {
    return status;
  }


  public void setId (String  id) {
    this.id = id;
  }


  public void setCode (String  code) {
    this.code = code;
  }

  public void setTitle (String  title) {
    this.title = title;
  }
  public void setJsonData (String  jsonData) {
    this.jsonData = jsonData;
  }
  public void setCreateTime (java.util.Date  createTime) {
    this.createTime = createTime;
  }
  public void setStatus (Integer  status) {
    this.status = status;
  }

}