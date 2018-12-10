

package com.drakelee.demo.common.domain.sys;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;



/**
 * 地区
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-03-15
 */
@Entity
@Table(name = "base_region")
public class Region implements Serializable {
  private static final long serialVersionUID = 1L;

  /** id - */
  private String id;

  /** name - */
  private String name;

  /** name_path - */
  private String namePath;

  /** order_no - */
  private Integer orderNo;

  /** parent_id - */
  private String parentId;

  /** leaf - 0、否 1、是 */
  private Integer leaf;

  /** remark - */
  private String remark;

  /** create_time - */
  private java.util.Date createTime;

  /** status - 0、禁用 1、启用 */
  private Integer status;

  /** left_val - */
  private Integer leftVal;

  /** right_val - */
  private Integer rightVal;

  @Column(name = "left_val")
  public Integer getLeftVal() {
    return leftVal;
  }

  @Column(name = "right_val")
  public Integer getRightVal() {
    return rightVal;
  }



  @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator = "uuid2")
  @Column(name = "id", nullable = false)
  public String getId() {
    return this.id;
  }

  @Column(name = "name", nullable = false)
  public String getName() {
    return name;
  }

  @Column(name = "name_path", nullable = false)
  public String getNamePath() {
    return namePath;
  }

  @Column(name = "order_no", nullable = false)
  public Integer getOrderNo() {
    return orderNo;
  }

  @Column(name = "parent_id")
  public String getParentId() {
    return parentId;
  }

  @Column(name = "leaf")
  public Integer getLeaf() {
    return leaf;
  }

  @Column(name = "remark")
  public String getRemark() {
    return remark;
  }

  @Column(name = "create_time", nullable = false)
  public java.util.Date getCreateTime() {
    return createTime;
  }

  @Column(name = "status", nullable = false)
  public Integer getStatus() {
    return status;
  }

  public void setId(String id) {
    this.id = id;
  }

  public void setName(String name) {
    this.name = name;
  }

  public void setNamePath(String namePath) {
    this.namePath = namePath;
  }

  public void setOrderNo(Integer orderNo) {
    this.orderNo = orderNo;
  }

  public void setParentId(String parentId) {
    this.parentId = parentId;
  }

  public void setLeaf(Integer leaf) {
    this.leaf = leaf;
  }

  public void setRemark(String remark) {
    this.remark = remark;
  }

  public void setCreateTime(java.util.Date createTime) {
    this.createTime = createTime;
  }

  public void setStatus(Integer status) {
    this.status = status;
  }

  public void setLeftVal(Integer leftVal) {
    this.leftVal = leftVal;
  }

  public void setRightVal(Integer rightVal) {
    this.rightVal = rightVal;
  }


}