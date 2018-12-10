

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
 * @since : 2018-04-08
 */
@Entity
@Table(name = "admin_sys_member_attr")
public class SysMemberAttr implements Serializable {
  private static final long serialVersionUID = 1L;

  /** id - */
  private String id;

  /** member_id - */
  private String memberId;

  /** attr_key - */
  private String attrKey;

  /** attr_name - */
  private String attrName;

  /** attr_value - */
  private String attrValue;



  @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator = "uuid2")
  @Column(name = "id", nullable = false)
  public String getId() {
    return this.id;
  }

  @Column(name = "member_id", nullable = false)
  public String getMemberId() {
    return memberId;
  }

  @Column(name = "attr_key", nullable = false)
  public String getAttrKey() {
    return attrKey;
  }

  @Column(name = "attr_name", nullable = false)
  public String getAttrName() {
    return attrName;
  }

  @Column(name = "attr_value", nullable = false)
  public String getAttrValue() {
    return attrValue;
  }

  public void setId(String id) {
    this.id = id;
  }

  public void setMemberId(String memberId) {
    this.memberId = memberId;
  }

  public void setAttrKey(String attrKey) {
    this.attrKey = attrKey;
  }

  public void setAttrName(String attrName) {
    this.attrName = attrName;
  }

  public void setAttrValue(String attrValue) {
    this.attrValue = attrValue;
  }

}