

package com.drakelee.demo.common.domain.admin;

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
 * @since : 2018-04-03
 */
@Entity
@Table(name = "admin_sys_role")
public class SysRole implements Serializable {
  private static final long serialVersionUID = 1L;

  /** id - */
  private String id;

  /** name - */
  private String name;

  /** code - */
  private String code;

  /** order_no - */
  private Integer orderNo;

  /** description - 描述 */
  private String description;

  /** status - 启用状态，0、禁用，1、启用 */
  private Integer status;



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

  @Column(name = "code")
  public String getCode() {
    return code;
  }

  @Column(name = "order_no", nullable = false)
  public Integer getOrderNo() {
    return orderNo;
  }

  @Column(name = "description")
  public String getDescription() {
    return description;
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

  public void setCode(String code) {
    this.code = code;
  }

  public void setOrderNo(Integer orderNo) {
    this.orderNo = orderNo;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public void setStatus(Integer status) {
    this.status = status;
  }

}