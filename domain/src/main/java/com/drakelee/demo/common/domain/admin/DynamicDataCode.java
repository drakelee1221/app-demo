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
 * 动态表单类型
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-06-21
 */
@Entity
@Table(name = "base_dynamic_data_code")
@TableName("base_dynamic_data_code")
public class DynamicDataCode implements Serializable  {
  private static final long serialVersionUID = 1L;

    @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator="uuid2")
  @TableId(value = "id")
  @Column(name = "id", nullable = false)
  private String  id ;
    
  /** code - 表单编号 */
  @TableField(value = "code")
  @Column(name = "code", nullable = false)
  private String  code ;

  /** begin_time - 开始时间 */
  @TableField(value = "begin_time")
  @Column(name = "begin_time", nullable = false)
  private java.util.Date  beginTime ;

  /** end_time - 结束时间 */
  @TableField(value = "end_time")
  @Column(name = "end_time", nullable = false)
  private java.util.Date  endTime ;

  /** title - 表单标题 */
  @TableField(value = "title")
  @Column(name = "title", nullable = false)
  private String  title ;

  /** remark -  */
  @TableField(value = "remark")
  @Column(name = "remark")
  private String  remark ;

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

    public java.util.Date  getBeginTime  () {
    return beginTime;
  }

    public java.util.Date  getEndTime  () {
    return endTime;
  }

    public String  getTitle  () {
    return title;
  }

    public String  getRemark  () {
    return remark;
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
    public void setBeginTime (java.util.Date  beginTime) {
    this.beginTime = beginTime;
  }
    public void setEndTime (java.util.Date  endTime) {
    this.endTime = endTime;
  }
    public void setTitle (String  title) {
    this.title = title;
  }
    public void setRemark (String  remark) {
    this.remark = remark;
  }
    public void setStatus (Integer  status) {
    this.status = status;
  }
  
  }