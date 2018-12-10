

package com.drakelee.demo.common.domain.sys;

import com.drakelee.demo.common.dto.mail.Mailable;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;



/**
 * 邮箱
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-04-03
 */
@Entity
@Table(name = "base_mailbox")
public class Mailbox implements Mailable, Serializable {
  private static final long serialVersionUID = 1L;

  /** id - */
  private String id;

  /** address - */
  private String address;

  /** password - */
  private String password;

  /** sign - */
  private String sign;

  /** create_time - */
  private java.util.Date createTime;

  /** status - 0、禁用 1、启用 */
  private Integer status;

  /** priority - */
  private Integer priority;

  /** smtp - */
  private String smtp;



  @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator = "uuid2")
  @Column(name = "id", nullable = false)
  public String getId() {
    return this.id;
  }

  @Column(name = "address")
  @Override
  public String getAddress() {
    return address;
  }

  @Column(name = "password")
  @Override
  public String getPassword() {
    return password;
  }

  @Column(name = "sign")
  public String getSign() {
    return sign;
  }

  @Column(name = "create_time", nullable = false)
  public java.util.Date getCreateTime() {
    return createTime;
  }

  @Column(name = "status", nullable = false)
  public Integer getStatus() {
    return status;
  }

  @Column(name = "priority", nullable = false)
  public Integer getPriority() {
    return priority;
  }

  @Column(name = "smtp", nullable = false)
  @Override
  public String getSmtp() {
    return smtp;
  }

  public void setId(String id) {
    this.id = id;
  }

  public void setAddress(String address) {
    this.address = address;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public void setSign(String sign) {
    this.sign = sign;
  }

  public void setCreateTime(java.util.Date createTime) {
    this.createTime = createTime;
  }

  public void setStatus(Integer status) {
    this.status = status;
  }

  public void setPriority(Integer priority) {
    this.priority = priority;
  }

  public void setSmtp(String smtp) {
    this.smtp = smtp;
  }

}