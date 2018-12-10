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
 * 字典表
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-07-02
 */
@Entity
@Table(name = "base_dictionary")
@TableName("base_dictionary")
public class Dictionary implements Serializable {
  private static final long serialVersionUID = 1L;

  @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator = "uuid2")
  @TableId(value = "id")
  @Column(name = "id", nullable = false)
  private String id;

  /** dict_code - */
  @TableField(value = "dict_code")
  @Column(name = "dict_code", nullable = false)
  private String dictCode;


  /** dict_name - */
  @TableField(value = "dict_name")
  @Column(name = "dict_name", nullable = false)
  private String dictName;

  /** remarks - */
  @TableField(value = "remarks")
  @Column(name = "remarks")
  private String remarks;

  /** data_type - */
  @TableField(value = "data_type")
  @Column(name = "data_type", nullable = false)
  private String dataType;

  /** order_no - */
  @TableField(value = "order_no")
  @Column(name = "order_no")
  private Integer orderNo;

  /** status - 0、禁用 1、启用 */
  @TableField(value = "status")
  @Column(name = "status", nullable = false)
  private Integer status;

  /** can_edit - 0、不可编辑 1、可编辑 */
  @TableField(value = "can_edit")
  @Column(name = "can_edit", nullable = false)
  private Integer canEdit;

  public Integer getCanEdit() {
    return canEdit;
  }

  public void setCanEdit(Integer canEdit) {
    this.canEdit = canEdit;
  }

  public String getId() {
    return this.id;
  }

  public String getDictName() {
    return dictName;
  }

  public String getRemarks() {
    return remarks;
  }

  public String getDataType() {
    return dataType;
  }

  public Integer getOrderNo() {
    return orderNo;
  }

  public Integer getStatus() {
    return status;
  }


  public void setId(String id) {
    this.id = id;
  }

  public String getDictCode() {
    return dictCode;
  }

  public void setDictCode(String dictCode) {
    this.dictCode = dictCode;
  }

  public void setDictName(String dictName) {
    this.dictName = dictName;
  }

  public void setRemarks(String remarks) {
    this.remarks = remarks;
  }

  public void setDataType(String dataType) {
    this.dataType = dataType;
  }

  public void setOrderNo(Integer orderNo) {
    this.orderNo = orderNo;
  }

  public void setStatus(Integer status) {
    this.status = status;
  }

}