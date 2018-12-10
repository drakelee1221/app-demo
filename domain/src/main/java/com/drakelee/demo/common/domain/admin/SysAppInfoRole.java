

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
@Table(name = "admin_sys_app_info_role")
public class SysAppInfoRole implements Serializable {
  private static final long serialVersionUID = 1L;

  /** id - */
  private String id;

  /** app_info_id - */
  private String appInfoId;

  /** role_id - */
  private String roleId;



  @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator = "uuid2")
  @Column(name = "id", nullable = false)
  public String getId() {
    return this.id;
  }

  @Column(name = "app_info_id", nullable = false)
  public String getAppInfoId() {
    return appInfoId;
  }

  @Column(name = "role_id", nullable = false)
  public String getRoleId() {
    return roleId;
  }

  public void setId(String id) {
    this.id = id;
  }

  public void setAppInfoId(String appInfoId) {
    this.appInfoId = appInfoId;
  }

  public void setRoleId(String roleId) {
    this.roleId = roleId;
  }

}