package com.drakelee.demo.common.domain.sys;

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
 * @since : 2018-05-21
 */
@Entity
@Table(name = "base_variable_data")
public class VariableData implements Serializable {
  private static final long serialVersionUID = 1L;

  /** id - */
  private String id;

  /** type - */
  private Integer type;

  /** ref_id - */
  private String refId;

  /** json_data - */
  private String jsonData;

  /** remark - */
  private String remark;

  private Integer orderNo;

  private String avatar;


  @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator = "uuid2")
  @Column(name = "id", nullable = false)
  public String getId() {
    return this.id;
  }

  @Column(name = "type", nullable = false)
  public Integer getType() {
    return type;
  }

  @Column(name = "ref_id", nullable = false)
  public String getRefId() {
    return refId;
  }

  @Column(name = "json_data", nullable = false)
  public String getJsonData() {
    return jsonData;
  }

  @Column(name = "remark")
  public String getRemark() {
    return remark;
  }

  @Column(name = "avatar")
  public String getAvatar() {
    return avatar;
  }

  @Column(name = "order_no")
  public Integer getOrderNo() {
    return orderNo;
  }

  public void setId(String id) {
    this.id = id;
  }

  public void setType(Integer type) {
    this.type = type;
  }

  public void setRefId(String refId) {
    this.refId = refId;
  }

  public void setJsonData(String jsonData) {
    this.jsonData = jsonData;
  }

  public void setRemark(String remark) {
    this.remark = remark;
  }

  public void setAvatar(String avatar) {
    this.avatar = avatar;
  }

  public void setOrderNo(Integer orderNo) {
    this.orderNo = orderNo;
  }

}