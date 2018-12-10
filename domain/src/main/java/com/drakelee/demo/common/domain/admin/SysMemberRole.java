

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
@Table(name = "admin_sys_member_role")
public class SysMemberRole implements Serializable {
  private static final long serialVersionUID = 1L;

  /** id - */
  private String id;

  /** member_id - */
  private String memberId;

  /** role_id - */
  private String roleId;



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

  @Column(name = "role_id", nullable = false)
  public String getRoleId() {
    return roleId;
  }

  public void setId(String id) {
    this.id = id;
  }

  public void setMemberId(String memberId) {
    this.memberId = memberId;
  }

  public void setRoleId(String roleId) {
    this.roleId = roleId;
  }

}