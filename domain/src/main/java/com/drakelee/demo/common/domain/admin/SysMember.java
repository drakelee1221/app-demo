

package com.drakelee.demo.common.domain.admin;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;



/**
 * 后台组织机构
 *
 * @author : code generator
 * @version : 1.0
 * @since : 2018-03-17
 */
@Entity
@Table(name = "admin_sys_member")
public class SysMember implements Serializable {
  private static final long serialVersionUID = 1L;

  /** id - */
  private String id;

  /** account - */
  private String account;

  /** pwd - */
  private String pwd;

  /** avatar - */
  private String avatar;

  /** member_code - 成员编码 */
  private String memberCode;

  /** member_name - */
  private String memberName;

  /** gender - 0、 未填写  1、男  2、女 */
  private Integer gender;

  /** email_address - */
  private String emailAddress;

  /** member_type - 0、部门 1、员工用户 */
  private Integer memberType;

  /** create_time - */
  private java.util.Date createTime;

  /** last_login_time - */
  private java.util.Date lastLoginTime;

  /** last_login_ip - */
  private String lastLoginIp;

  /** status - 1,正常 0.限制登录 */
  private Integer status;

  /** parent_id - */
  private String parentId;

  /** left_val - */
  private Integer leftVal;

  /** right_val - */
  private Integer rightVal;

  /** tree_kind - 树分类 */
  private String treeKind;
  /** region_id - 区域id */
  private String regionId;
  /** default_org - 是否默认机构 */
  private Integer defaultOrg;

  @Id
  @GenericGenerator(name = "uuid2", strategy = "uuid2")
  @GeneratedValue(generator = "uuid2")
  @Column(name = "id", nullable = false)
  public String getId() {
    return this.id;
  }

  @Column(name = "account")
  public String getAccount() {
    return account;
  }

  @Column(name = "pwd")
  public String getPwd() {
    return pwd;
  }

  @Column(name = "avatar")
  public String getAvatar() {
    return avatar;
  }

  @Column(name = "member_code")
  public String getMemberCode() {
    return memberCode;
  }

  @Column(name = "member_name", nullable = false)
  public String getMemberName() {
    return memberName;
  }

  @Column(name = "gender")
  public Integer getGender() {
    return gender;
  }

  @Column(name = "email_address")
  public String getEmailAddress() {
    return emailAddress;
  }

  @Column(name = "member_type", nullable = false)
  public Integer getMemberType() {
    return memberType;
  }

  @Column(name = "create_time", nullable = false)
  public java.util.Date getCreateTime() {
    return createTime;
  }

  @Column(name = "last_login_time")
  public java.util.Date getLastLoginTime() {
    return lastLoginTime;
  }

  @Column(name = "last_login_ip")
  public String getLastLoginIp() {
    return lastLoginIp;
  }

  @Column(name = "status", nullable = false)
  public Integer getStatus() {
    return status;
  }

  @Column(name = "parent_id", nullable = false)
  public String getParentId() {
    return parentId;
  }

  @Column(name = "left_val", nullable = false)
  public Integer getLeftVal() {
    return leftVal;
  }

  @Column(name = "right_val", nullable = false)
  public Integer getRightVal() {
    return rightVal;
  }

  @Column(name = "tree_kind", nullable = false)
  public String getTreeKind() {
    return treeKind;
  }

  @Column(name = "region_id")
  public String getRegionId() {
    return regionId;
  }

  public void setId(String id) {
    this.id = id;
  }

  public void setAccount(String account) {
    this.account = account;
  }

  public void setPwd(String pwd) {
    this.pwd = pwd;
  }

  public void setAvatar(String avatar) {
    this.avatar = avatar;
  }

  public void setMemberCode(String memberCode) {
    this.memberCode = memberCode;
  }

  public void setMemberName(String memberName) {
    this.memberName = memberName;
  }

  public void setGender(Integer gender) {
    this.gender = gender;
  }

  public void setEmailAddress(String emailAddress) {
    this.emailAddress = emailAddress;
  }

  public void setMemberType(Integer memberType) {
    this.memberType = memberType;
  }

  public void setCreateTime(java.util.Date createTime) {
    this.createTime = createTime;
  }

  public void setLastLoginTime(java.util.Date lastLoginTime) {
    this.lastLoginTime = lastLoginTime;
  }

  public void setLastLoginIp(String lastLoginIp) {
    this.lastLoginIp = lastLoginIp;
  }

  public void setStatus(Integer status) {
    this.status = status;
  }

  public void setParentId(String parentId) {
    this.parentId = parentId;
  }

  public void setLeftVal(Integer leftVal) {
    this.leftVal = leftVal;
  }

  public void setRightVal(Integer rightVal) {
    this.rightVal = rightVal;
  }

  public void setTreeKind(String treeKind) {
    this.treeKind = treeKind;
  }

  public void setRegionId(String regionId) {
    this.regionId = regionId;
  }
  @Column(name = "default_org")
  public Integer getDefaultOrg() {
    return defaultOrg;
  }

  public void setDefaultOrg(Integer defaultOrg) {
    this.defaultOrg = defaultOrg;
  }
}